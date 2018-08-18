# Inspec test for recipe codenamephp_php::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'php-1.0' do
  title 'Make sure default php is intsalled'
  desc 'Install php'

  describe command('php') do
    it { should exist }
  end
end
