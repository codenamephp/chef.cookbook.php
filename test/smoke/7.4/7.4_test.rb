# frozen_string_literal: true

# Inspec test for recipe codenamephp_php::7_2

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'php-7.4-1.0' do
  title 'Make sure php7.4 is intsalled'
  desc 'Install php7.4 and apache2'

  describe package('php7.4-cli') do
    it { should be_installed }
  end
end
