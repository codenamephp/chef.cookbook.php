#
# Cookbook:: chef.cookbook.php
# Recipe:: add_sury_repository
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'apt'

apt_repository 'sury-php' do
  uri 'https://packages.sury.org/php/'
  repo_name 'sury-php'
  distribution 'stretch'
  components ['main']
  key 'https://packages.sury.org/php/apt.gpg'
  only_if { node['chef.cookbook.php']['add_sury_repository'] }
end