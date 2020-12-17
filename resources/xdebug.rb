# frozen_string_literal: true

property :php_versions, Array, required: true, description: 'The php versions the xdebug config will be handled for'
property :package_name, String, default: 'php-xdebug', description: 'The package name that is used to install xdebug'
property :config_name, String, default: 'xdebug-custom.ini', description: 'The config name the config file will get'
property :config_cookbook_file, String, default: 'xdebug.ini', description: 'The name of the cookbook file of the config'
property :config_cookbook_file_cookbook, String, default: 'codenamephp_php', description: 'The name of the cookbook the cookbook file will be taken from'
property :add_sury_repository, [true, false], default: true, description: 'Flag if the sury repository should be added first'
property :services, Array, default: %w(apache2 fpm), description: 'The services like cli and apache2 the config will be handled for'

action :install do
  codenamephp_php_sury_repository 'sury-php' do
    only_if { new_resource.add_sury_repository }
  end

  package 'install xdebug from package' do
    package_name new_resource.package_name
  end

  codenamephp_php_config 'xdebug' do
    cookbook_file new_resource.config_cookbook_file
    cookbook_file_cookbook new_resource.config_cookbook_file_cookbook
    config_name new_resource.config_name
    php_versions new_resource.php_versions
    services new_resource.services
  end
end

action :remove do
  codenamephp_php_sury_repository 'sury-php' do
    only_if { new_resource.add_sury_repository }
  end

  package 'remove xdebug from package' do
    package_name new_resource.package_name
    action :remove
  end

  codenamephp_php_config 'xdebug' do
    cookbook_file new_resource.config_cookbook_file
    config_name new_resource.config_name
    php_versions new_resource.php_versions
    services new_resource.services
    action :delete
  end
end
