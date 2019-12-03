# frozen_string_literal: true

# Inspec test for recipe codenamephp_php::add_sury_repository

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'sury-repo-1.0' do
  title 'Make sure sury repository is added'
  desc 'Add the sury php repo to apt'

  describe apt('https://packages.sury.org/php/') do
    it { should exist }
    it { should be_enabled }
  end
end
