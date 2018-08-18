# Inspec test for recipe codenamephp_php::xdebug

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'xdebug-1.0' do
  title 'Make sure xdebug is installed'
  desc 'Add composer executable to path via the installer script'

  describe package('php-xdebug') do
    it { should be_installed }
  end
end
