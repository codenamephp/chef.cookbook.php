# Inspec test for recipe codenamephp_php::7_1

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'php-7.1-1.0' do
  title 'Make sure php7.1 is intsalled'
  desc 'Install php7.1 and apache2'

  describe package('php7.1-cli') do
    it { should be_installed }
  end
end
