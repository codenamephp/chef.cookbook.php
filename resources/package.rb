property :package_name, String, default: 'php', description: 'The package that is used to install php'
property :additional_packages, Array, default: [], description: 'Array of package names that will be installed in addition to the base package'

action :install do
  package 'install php from package' do
    package_name new_resource.package_name
  end

  package "install additional packages #{new_resource.additional_packages.join(', ')}".strip do
    package_name new_resource.additional_packages
  end
end
