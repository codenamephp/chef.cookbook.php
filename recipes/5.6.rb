#
# Cookbook:: codenamephp_php
# Recipe:: 5.6
#
# Copyright:: 2017, The Authors, All Rights Reserved.

codenamephp_php_sury_repository 'sury-php' do
  only_if { node['codenamephp_php']['add_sury_repository'] }
end

codenamephp_php_package 'install php 5.6' do
  package_name node['codenamephp_php']['5.6']['package_name']
  additional_packages node['codenamephp_php']['5.6']['additional_packages']
end

codenamephp_php_composer 'install composer' do
  only_if { node['codenamephp_php']['install_composer'] }
end

codenamephp_php_xdebug 'install xdebug' do
  php_versions %w[5.6]
  only_if { node['codenamephp_php']['install_xdebug'] }
end
