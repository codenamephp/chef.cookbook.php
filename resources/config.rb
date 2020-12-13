# frozen_string_literal: true

property :cookbook_file, String, required: true, description: 'The cookbook file that will be used as configuration'
property :php_versions, Array, required: true, description: 'The php versions the config will be handled for'
property :config_name, String, required: true, description: 'The name the configuration will get in the conf-available and conf.d folders'
property :priority, Integer, default: 30, description: 'The priority prefix the symlink will get which determines the sequence the configs are read in'
property :services, Array, default: %w(cli apache2 fpm), description: 'The services like cli and apache2 the config will be handled for'
property :cookbook_file_cookbook, String, default: 'codenamephp_php', description: 'The cookbook the cookbook file will be taken from'

action :enable do
  manage_config(new_resource.php_versions, new_resource.config_name, new_resource.cookbook_file, new_resource.cookbook_file_cookbook, :create)
  manage_link_for_services(new_resource.php_versions, new_resource.config_name, new_resource.services, new_resource.priority, :create)
end

action :create do
  manage_config(new_resource.php_versions, new_resource.config_name, new_resource.cookbook_file, new_resource.cookbook_file_cookbook, :create)
end

action :disable do
  manage_link_for_services(new_resource.php_versions, new_resource.config_name, new_resource.services, new_resource.priority, :delete)
end

action :delete do
  manage_link_for_services(new_resource.php_versions, new_resource.config_name, new_resource.services, new_resource.priority, :delete)
  manage_config(new_resource.php_versions, new_resource.config_name, new_resource.cookbook_file, new_resource.cookbook_file_cookbook, :delete)
end

action_class do
  def manage_config(php_versions, config_name, source, source_cookbook, action)
    php_versions.each do |php_version|
      target_config_file_directory = "/etc/php/#{php_version}/mods-available"

      cookbook_file "#{target_config_file_directory}/#{config_name}" do
        cookbook source_cookbook
        source source
        owner 'root'
        group 'root'
        action action
        only_if { Dir.exist?(target_config_file_directory) }
      end
    end
  end

  def manage_link_for_services(php_versions, config_name, services, priority, action)
    services.each do |service|
      manage_link(php_versions, config_name, service, priority, action)
    end
  end

  def manage_link(php_versions, config_name, service, priority, action)
    php_versions.each do |php_version|
      target_config_file_directory = "/etc/php/#{php_version}/mods-available"
      link_directory = "/etc/php/#{php_version}/#{service}/conf.d"

      link "#{link_directory}/#{priority}-#{config_name}" do
        to "#{target_config_file_directory}/#{config_name}"
        action action
        only_if { Dir.exist?(target_config_file_directory) && Dir.exist?(link_directory) }
      end
    end
  end
end
