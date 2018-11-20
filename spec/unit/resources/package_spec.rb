#
# Cookbook:: codenamephp_php
# Spec:: package
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_package' do
  step_into :codenamephp_php_package

  context 'With minimal properties' do
    recipe do
      codenamephp_php_package 'install php'
    end

    it {
      is_expected.to install_package('install php from package').with(
        package_name: 'php'
      )

      is_expected.to install_package('install additional packages').with(
        package_name: []
      )
    }
  end

  context 'With custom package name and additional packages' do
    recipe do
      codenamephp_php_package 'install php' do
        package_name 'some package'
        additional_packages %w[package1 package2]
      end
    end

    it {
      is_expected.to install_package('install php from package').with(
        package_name: 'some package'
      )

      is_expected.to install_package('install additional packages package1, package2').with(
        package_name: %w[package1 package2]
      )
    }
  end
end
