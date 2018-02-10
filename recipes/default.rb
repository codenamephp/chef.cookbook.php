#
# Cookbook:: codenamephp_php
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe '::add_sury_repository'
include_recipe node['codenamephp_php']['php_recipe']
include_recipe '::composer'
