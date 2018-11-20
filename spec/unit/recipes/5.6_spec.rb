#
# Cookbook:: codenamephp_php
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php::5.6' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'adds sury repository' do
      expect(chef_run).to add_codenamephp_php_sury_repository('sury-php')
    end

    it 'installs php5.6 and additional packages' do
      expect(chef_run).to install_codenamephp_php_package('install php 5.6')
    end

    it 'installs composer' do
      expect(chef_run).to install_codenamephp_php_composer('install composer')
    end

    it 'installs xdebug' do
      expect(chef_run).to install_codenamephp_php_xdebug('install xdebug').with(php_versions: %w[5.6])
    end
  end

  context 'With additional packages and php package' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['codenamephp_php']['5.6']['package_name'] = 'some package'
        node.normal['codenamephp_php']['5.6']['additional_packages'] = %w[package1 package2 package3]
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs php5.6 and additional package using custom values' do
      expect(chef_run).to install_codenamephp_php_package('install php 5.6').with(
        package_name: 'some package',
        additional_packages: %w[package1 package2 package3]
      )
    end
  end
end
