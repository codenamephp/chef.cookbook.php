# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Recipe:: 7_3
#
# Copyright:: 2017, The Authors, All Rights Reserved.

codenamephp_php_sury_repository 'sury-php' do
  only_if { node['codenamephp_php']['add_sury_repository'] }
end

codenamephp_php_package 'install php 7.3' do
  package_name node['codenamephp_php']['7.3']['package_name']
  additional_packages node['codenamephp_php']['7.3']['additional_packages']
end

codenamephp_php_composer 'install composer' do
  only_if { node['codenamephp_php']['install_composer'] }
end

codenamephp_php_xdebug 'install xdebug' do
  php_versions %w(7.3)
  only_if { node['codenamephp_php']['install_xdebug'] }
end
