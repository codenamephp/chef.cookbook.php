#
# Cookbook:: codenamephp_php
# Spec:: xdebug
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_xdebug' do
  step_into :codenamephp_php_xdebug

  context 'Install with minimal properties' do
    recipe do
      codenamephp_php_xdebug 'install xdebug' do
        php_versions %w[99 88]
      end
    end

    it {
      is_expected.to add_codenamephp_php_sury_repository('sury-php')
      is_expected.to install_package('install xdebug from package').with(package_name: 'php-xdebug')
      is_expected.to enable_codenamephp_php_config('xdebug').with(
        cookbook_file: 'xdebug.ini',
        config_name: 'xdebug-custom.ini',
        php_versions: %w[99 88]
      )
    }
  end

  context 'Remove with minimal properties' do
    recipe do
      codenamephp_php_xdebug 'install xdebug' do
        php_versions %w[99 88]
        action :remove
      end
    end

    it {
      is_expected.to add_codenamephp_php_sury_repository('sury-php')
      is_expected.to remove_package('remove xdebug from package').with(package_name: 'php-xdebug')
      is_expected.to delete_codenamephp_php_config('xdebug').with(
        cookbook_file: 'xdebug.ini',
        config_name: 'xdebug-custom.ini',
        php_versions: %w[99 88]
      )
    }
  end
end
