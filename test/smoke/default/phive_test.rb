# frozen_string_literal: true

# Inspec test for recipe codenamephp_php::composer

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'phive-1.0' do
  title 'Make sure phive is installed'
  desc 'Add composer phive to path'

  describe command('phive') do
    it { should exist }
  end

  describe command('phive --version') do
    its('stdout') { should match(/Phive /) }
  end
end
