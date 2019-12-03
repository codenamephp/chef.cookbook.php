# frozen_string_literal: true

# Inspec test for recipe codenamephp_php::composer

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'composer-1.0' do
  title 'Make sure composer is installed'
  desc 'Add composer executable to path via the installer script'

  describe command('composer') do
    it { should exist }
  end
end
