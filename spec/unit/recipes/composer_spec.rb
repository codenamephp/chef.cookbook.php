#
# Cookbook:: chef.cookbook.php
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef.cookbook.php::composer' do
  targetFile = '/usr/bin/composer'

  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which php").and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'wont install composer since php is not installed' do
      expect(chef_run).to_not create_remote_file_if_missing(targetFile)
    end
  end

  context 'When all attributes are default and php is installed' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which php").and_return(true)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'will install composer since php installed' do
      expect(chef_run).to create_remote_file_if_missing(targetFile).with(
          source: 'http://getcomposer.org/composer.phar',
          mode: '0777',
      )
    end
  end
end
