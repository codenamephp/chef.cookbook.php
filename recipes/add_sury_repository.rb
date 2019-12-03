# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Recipe:: add_sury_repository
#
# Copyright:: 2017, The Authors, All Rights Reserved.

codenamephp_php_sury_repository 'sury-php' do
  only_if { node['codenamephp_php']['add_sury_repository'] }
end
