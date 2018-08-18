#
# Cookbook:: codenamephp_php
# Spec:: xdebug
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php::xdebug' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes add_sury_repository recipe' do
      expect(chef_run).to include_recipe('codenamephp_php::add_sury_repository')
    end

    it 'installs xdebug' do
      expect(chef_run).to install_package('install xdebug from package').with(
        package_name: 'php-xdebug'
      )
    end
  end
end
