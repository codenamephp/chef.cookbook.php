#
# Cookbook:: codenamephp_php
# Recipe:: xdebug
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe '::add_sury_repository'

package 'install xdebug from package' do
  package_name 'php-xdebug'
end
