# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Spec:: sury_repository
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_sury_repository' do
  step_into :codenamephp_php_sury_repository

  context 'With minimal properties' do
    recipe do
      codenamephp_php_sury_repository 'add sury repository'
    end

    it {
      is_expected.to add_apt_repository('sury_php').with(
        uri: 'https://packages.sury.org/php/',
        repo_name: 'sury_php',
        components: %w(main),
        key: ['https://packages.sury.org/php/apt.gpg']
      )
    }
  end
end
