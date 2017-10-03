#
# Cookbook:: chef.cookbook.php
# Recipe:: 7_1
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe '::add_sury_repository'

package 'install php7.1 from package' do
  package_name node['chef.cookbook.php']['7.1']['package_name']['cli']
end

if node['chef.cookbook.php']['install_apache'] == true
  include_recipe 'chef.cookbook.apache2'

  package 'install apache php modules' do
    package_name node['chef.cookbook.php']['7.1']['package_name']['apache']
  end
end

include_recipe '::composer' if node['chef.cookbook.php']['install_composer']