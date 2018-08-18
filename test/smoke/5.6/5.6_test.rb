# Inspec test for recipe codenamephp_php::5.6

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'php-5.6-1.0' do
  title 'Make sure php5.6 is intsalled'
  desc 'Install php5.6 and apache2'

  describe package('php5.6') do
    it { should be_installed }
  end

  describe package('apache2') do
    it { should be_installed }
  end
end
