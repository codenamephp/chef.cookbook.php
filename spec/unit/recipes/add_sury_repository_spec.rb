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

    it 'includes apt cookbook' do
      expect(chef_run).to include_recipe('apt')
    end

    it 'adds the sury apt repository' do
      expect(chef_run).to add_apt_repository('sury-php').with(
        uri: 'https://packages.sury.org/php/',
        repo_name: 'sury-php',
        distribution: 'stretch',
        components: ['main'],
        key: ['https://packages.sury.org/php/apt.gpg']
      )
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

    it 'adds the sury apt repository' do
      expect(chef_run).to_not add_apt_repository('sury-php')
    end
  end
end
