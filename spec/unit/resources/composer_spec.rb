# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Spec:: composer
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_composer' do
  step_into :codenamephp_php_composer

  before(:example) do
    stub_command('which php').and_return('php')
  end

  context 'With minimal properties' do
    recipe do
      codenamephp_php_composer 'composer'
    end

    it {
      is_expected.to create_if_missing_remote_file('/usr/bin/composer').with(
        source: 'https://getcomposer.org/composer-stable.phar'
      )
    }
  end

  context 'With custom source and binary path' do
    recipe do
      codenamephp_php_composer 'composer' do
        binary_path '/some/path'
        source 'http://localhost'
      end
    end

    it {
      is_expected.to create_if_missing_remote_file('/some/path').with(
        source: 'http://localhost'
      )
    }
  end

  context 'With custom source alias and binary path' do
    recipe do
      codenamephp_php_composer 'composer' do
        binary_path '/some/path'
        source '1'
      end
    end

    it {
      is_expected.to create_if_missing_remote_file('/some/path').with(
        source: 'https://getcomposer.org/composer-1.phar'
      )
    }
  end
end
