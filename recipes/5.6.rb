#
# Cookbook:: codenamephp_php
# Recipe:: 5.6
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe '::add_sury_repository'

package 'install php5.6 from package' do
  package_name node['codenamephp_php']['5.6']['package_name']['cli']
end

if node['codenamephp_php']['install_apache'] == true
  include_recipe 'chef.cookbook.apache2'

  package 'install apache php modules' do
    package_name node['codenamephp_php']['5.6']['package_name']['apache']
  end
end

node['codenamephp_php']['5.6']['additional_packages'].each do |additional_package|
  package "install additional package #{additional_package}" do
    package_name additional_package
  end
end

include_recipe '::composer' if node['codenamephp_php']['install_composer']
