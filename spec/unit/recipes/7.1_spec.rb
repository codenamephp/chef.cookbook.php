#
# Cookbook:: chef.cookbook.php
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chef.cookbook.php::7.1' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("/usr/sbin/apache2 -t").and_return(true)
      stub_command("which php").and_return(0)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes add_sury_repository recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.php::add_sury_repository')
    end

    it 'installs php7.1 cli' do
      expect(chef_run).to install_package('install php7.1 from package').with(package_name: chef_run.node.default['chef.cookbook.php']['7.1']['package_name']['cli'])
    end

    it 'includes apache2 cookbook' do
      expect(chef_run).to include_recipe('chef.cookbook.apache2')
    end

    it 'installs php7.1 apache modules' do
      expect(chef_run).to install_package('install apache php modules').with(package_name: chef_run.node.default['chef.cookbook.php']['7.1']['package_name']['apache'])
    end

    it 'includes composer recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.php::composer')
    end
  end

  context 'When install apache was set to false' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['chef.cookbook.php']['install_apache'] = false
      end.converge(described_recipe)
    end

    before do
      stub_command("which php").and_return(0)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes add_sury_repository recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.php::add_sury_repository')
    end

    it 'installs php7.1 cli' do
      expect(chef_run).to install_package('install php7.1 from package').with(package_name: chef_run.node.default['chef.cookbook.php']['7.1']['package_name']['cli'])
    end

    it 'does not includ apache2 cookbook' do
      expect(chef_run).to_not include_recipe('chef.cookbook.apache2')
    end

    it 'does not install php7.1 apache modules' do
      expect(chef_run).to_not install_package('install apache php modules')
    end

    it 'includes composer recipe' do
      expect(chef_run).to include_recipe('chef.cookbook.php::composer')
    end
  end
end
