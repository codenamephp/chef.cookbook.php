# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Spec:: config_file
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_config' do
  step_into :codenamephp_php_config

  before(:example) do
    allow(Dir).to receive(:exist?).and_return(true)
  end

  context 'With minimal properties' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
      end
    end

    it {
      is_expected.to create_cookbook_file('/etc/php/99.99/mods-available/my great config').with(source: 'some/file')
      is_expected.to create_link('/etc/php/99.99/cli/conf.d/30-my great config').with(to: '/etc/php/99.99/mods-available/my great config')
      is_expected.to create_link('/etc/php/99.99/apache2/conf.d/30-my great config').with(to: '/etc/php/99.99/mods-available/my great config')
    }
  end

  context 'With minimal properties and multiple php versions' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99 88.88 77.77]
        config_name 'my great config'
      end
    end

    it {
      is_expected.to create_cookbook_file('/etc/php/99.99/mods-available/my great config').with(source: 'some/file')
      is_expected.to create_cookbook_file('/etc/php/88.88/mods-available/my great config').with(source: 'some/file')
      is_expected.to create_cookbook_file('/etc/php/77.77/mods-available/my great config').with(source: 'some/file')

      is_expected.to create_link('/etc/php/99.99/cli/conf.d/30-my great config').with(to: '/etc/php/99.99/mods-available/my great config')
      is_expected.to create_link('/etc/php/99.99/apache2/conf.d/30-my great config').with(to: '/etc/php/99.99/mods-available/my great config')

      is_expected.to create_link('/etc/php/88.88/cli/conf.d/30-my great config').with(to: '/etc/php/88.88/mods-available/my great config')
      is_expected.to create_link('/etc/php/88.88/apache2/conf.d/30-my great config').with(to: '/etc/php/88.88/mods-available/my great config')

      is_expected.to create_link('/etc/php/77.77/cli/conf.d/30-my great config').with(to: '/etc/php/77.77/mods-available/my great config')
      is_expected.to create_link('/etc/php/77.77/apache2/conf.d/30-my great config').with(to: '/etc/php/77.77/mods-available/my great config')
    }
  end

  context 'With attributes' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
        priority 99
        services %w[service1 service2]
      end
    end

    it {
      is_expected.to create_cookbook_file('/etc/php/99.99/mods-available/my great config').with(source: 'some/file')
      is_expected.to create_link('/etc/php/99.99/service1/conf.d/99-my great config').with(to: '/etc/php/99.99/mods-available/my great config')
      is_expected.to create_link('/etc/php/99.99/service2/conf.d/99-my great config').with(to: '/etc/php/99.99/mods-available/my great config')
    }
  end

  context 'With create action' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
        priority 99
        services %w[service1 service2]
        action :create
      end
    end

    it {
      is_expected.to create_cookbook_file('/etc/php/99.99/mods-available/my great config').with(source: 'some/file')
      is_expected.to_not create_link('/etc/php/99.99/service1/conf.d/99-my great config')
      is_expected.to_not create_link('/etc/php/99.99/service2/conf.d/99-my great config')
    }
  end

  context 'With disable action' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
        priority 99
        services %w[service1 service2]
        action :disable
      end
    end

    it {
      is_expected.to_not create_cookbook_file('/etc/php/99.99/mods-available/my great config')
      is_expected.to delete_link('/etc/php/99.99/service1/conf.d/99-my great config')
      is_expected.to delete_link('/etc/php/99.99/service2/conf.d/99-my great config')
    }
  end

  context 'With delete action' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
        priority 99
        services %w[service1 service2]
        action :delete
      end
    end

    it {
      is_expected.to delete_cookbook_file('/etc/php/99.99/mods-available/my great config')
      is_expected.to delete_link('/etc/php/99.99/service1/conf.d/99-my great config')
      is_expected.to delete_link('/etc/php/99.99/service2/conf.d/99-my great config')
    }
  end

  context 'When folder does not exist' do
    recipe do
      codenamephp_php_config 'my config' do
        cookbook_file 'some/file'
        php_versions %w[99.99]
        config_name 'my great config'
        priority 99
        services %w[service1 service2]
      end
    end

    it {
      allow(Dir).to receive(:exist?).with('/etc/php/99.99/service1/conf.d').and_return(true)
      allow(Dir).to receive(:exist?).with('/etc/php/99.99/service2/conf.d').and_return(false)

      is_expected.to create_link('/etc/php/99.99/service1/conf.d/99-my great config')
      is_expected.to_not create_link('/etc/php/99.99/service2/conf.d/99-my great config')
    }
  end
end
