#
# Cookbook:: codenamephp_php
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php::add_sury_repository' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs sury repository using resource' do
      expect(chef_run).to add_codenamephp_php_sury_repository('sury-php')
    end
  end

  context 'When add_sury_repository was set to false' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['codenamephp_php']['add_sury_repository'] = false
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'will not install sury repository using resource due to only_if guard' do
      expect(chef_run).to_not add_codenamephp_php_sury_repository('sury-php')
    end
  end
end
