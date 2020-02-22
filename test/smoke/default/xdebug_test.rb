# frozen_string_literal: true

# Inspec test for recipe codenamephp_php::xdebug

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'xdebug-1.0' do
  title 'Make sure xdebug is installed'
  desc 'Add composer executable to path via the installer script'

  describe package('php-xdebug') do
    it { should be_installed }
  end

  describe bash('php -i | grep 30-xdebug-custom.ini') do
    its('exit_status') { should eq 0 }
  end

  describe file('/etc/php/5.6/cli/conf.d/30-xdebug-custom.ini') do
    it { should exist }
    its('link_path') { should eq '/etc/php/5.6/mods-available/xdebug-custom.ini' }
  end

  describe file('/etc/php/5.6/fpm/conf.d/30-xdebug-custom.ini') do
    it { should_not exist }
  end

  describe file('/etc/php/7.4/cli/conf.d/30-xdebug-custom.ini') do
    it { should exist }
    its('link_path') { should eq '/etc/php/7.4/mods-available/xdebug-custom.ini' }
  end

  describe file('/etc/php/7.4/fpm/conf.d/30-xdebug-custom.ini') do
    it { should exist }
    its('link_path') { should eq '/etc/php/7.4/mods-available/xdebug-custom.ini' }
  end
end
