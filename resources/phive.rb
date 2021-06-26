# frozen_string_literal: true

unified_mode true

property :binary_path, String, default: '/usr/bin/phive', description: 'Path to where the phive binary will be saved after verification'
property :binary_tmp_path, String, default: '/tmp/phive.phar', description: 'Path to where the phive baniray will be saved for verification'
property :source, String, default: 'https://phar.io/releases/phive.phar', description: 'URL from where the phive binary (phar) will be downloaded'
property :key_uri, String, default: 'https://phar.io/releases/phive.phar.asc', description: 'URI from where the key for verification will be downloaded'
property :key_path, String, default: '/tmp/phive.phar.asc', description: 'Local path to where the phive key is saved for verification'
property :install_php_dependencies, [true, false], default: true, description: 'Phive needs php and some extensions to run.
  Set this to false if you want to install these yourself. If true, cli, xml, mbstring and curl will be installed with respect to the given php version.'
property :php_version, String, default: 'php', description: 'The desired php version that will be used when installing the dependencies. This is usesd as prefix, e.g. php7.4 -> php7.4-curl'

action :install do
  codenamephp_php_package 'install needed extensions' do
    package_name get_dependency_package_names_with_php_version(%w(cli), new_resource.php_version).first
    additional_packages get_dependency_package_names_with_php_version(%w(xml mbstring curl), new_resource.php_version)
    only_if new_resource.install_php_dependencies.to_s
  end

  remote_file new_resource.binary_tmp_path do
    source new_resource.source
    mode '775'
    action :create
    only_if 'which php'
    not_if "test -e #{new_resource.binary_path}"
  end

  remote_file new_resource.key_path do
    source new_resource.key_uri
    mode '775'
    action :create
    only_if "test -e #{new_resource.binary_tmp_path}"
    notifies :run, 'execute[verify downloaded phar]', :immediately
  end

  execute 'verify downloaded phar' do
    command "gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79 && gpg --verify #{new_resource.key_path} #{new_resource.binary_tmp_path}"
    action :nothing
    notifies :create, 'file[move binary from tmp to final path]', :immediately
  end

  file 'move binary from tmp to final path' do
    path new_resource.binary_path
    owner 'root'
    group 'root'
    mode '755'
    content lazy { ::File.open(new_resource.binary_tmp_path).read }
    action :nothing
  end

  file 'delete tmp binary' do
    path new_resource.binary_tmp_path
    action :delete
  end

  file 'delete tmp key' do
    path new_resource.key_path
    action :delete
  end
end

action :uninstall do
  file 'delete phive.phar from binary path' do
    path new_resource.binary_path
    action :delete
  end
end

action_class do
  def get_dependency_package_names_with_php_version(packages, php_version)
    packages.map { |package| "php#{php_version.sub('php', '')}-#{package}" }
  end
end
