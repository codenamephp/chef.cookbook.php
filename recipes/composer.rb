#
# Cookbook:: chef.cookbook.php
# Recipe:: composer
#
# Copyright:: 2017, The Authors, All Rights Reserved.


remote_file '/usr/bin/composer' do
  source 'http://getcomposer.org/composer.phar'
  mode '0777'
  action :create_if_missing
  only_if 'which php'
end