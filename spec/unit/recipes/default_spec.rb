#
# Cookbook:: codenamephp_php
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php::default' do
  context 'When all attributes are default' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
      stub_command('which php').and_return(0)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes add_sury_repository' do
      expect(chef_run).to include_recipe('codenamephp_php::add_sury_repository')
    end

    it 'includes php recipe from attributes' do
      expect(chef_run).to include_recipe('codenamephp_php::7.1')
    end

    it 'includes composer recipe' do
      expect(chef_run).to include_recipe('codenamephp_php::composer')
    end
  end
end
