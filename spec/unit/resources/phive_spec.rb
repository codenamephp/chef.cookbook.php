# frozen_string_literal: true

#
# Cookbook:: codenamephp_php
# Spec:: composer
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_php_phive' do
  step_into :codenamephp_php_phive

  before(:example) do
    stub_command('which php').and_return('php')
  end

  context 'Install with minimal properties when not installed' do
    before(:example) do
      stub_command('test -e /usr/bin/phive').and_return(false)
      stub_command('test -e /tmp/phive.phar').and_return(true)
      stub_command('true').and_return(true) # yeah, I don't know either ...
    end

    recipe do
      codenamephp_php_phive 'phive'
    end

    it {
      is_expected.to install_codenamephp_php_package('install needed extensions').with(
        additional_packages: %w[php-xml php-mbstring]
      )

      is_expected.to create_remote_file('/tmp/phive.phar').with(
        source: 'https://phar.io/releases/phive.phar',
        mode: '0775'
      )

      is_expected.to create_remote_file('/tmp/phive.phar.asc').with(
        source: 'https://phar.io/releases/phive.phar.asc',
        mode: '0775'
      )

      expect(chef_run.remote_file('/tmp/phive.phar.asc')).to notify('execute[verify downloaded phar]').to(:run).immediately

      is_expected.to nothing_execute('verify downloaded phar').with(
        command: 'gpg --keyserver pool.sks-keyservers.net --recv-keys 0x9D8A98B29B2D5D79 && gpg --verify /tmp/phive.phar.asc /tmp/phive.phar'
      )

      expect(chef_run.execute('verify downloaded phar')).to notify('file[move binary from tmp to final path]').to(:create).immediately

      is_expected.to nothing_file('move binary from tmp to final path').with(
        path: '/usr/bin/phive',
        owner: 'root',
        group: 'root',
        mode: 0o755
      )

      is_expected.to delete_file('delete tmp binary').with(
        path: '/tmp/phive.phar'
      )

      is_expected.to delete_file('delete tmp key').with(
        path: '/tmp/phive.phar.asc'
      )
    }
  end

  context 'Install with all properties when not installed' do
    before(:example) do
      stub_command('test -e /some/path').and_return(false)
      stub_command('test -e /some/temp/path').and_return(true)
      stub_command('true').and_return(true) # yeah, I don't know either ...
      stub_command('false').and_return(false) # I guess ruby bools are somehow tied to the system?
    end

    recipe do
      codenamephp_php_phive 'phive' do
        binary_path '/some/path'
        binary_tmp_path '/some/temp/path'
        source 'https://some/source/uri'
        key_uri 'https://some/key/uri'
        key_path '/some/key/path'
      end
    end

    it {
      is_expected.to create_remote_file('/some/temp/path').with(
        source: 'https://some/source/uri'
      )

      is_expected.to create_remote_file('/some/key/path').with(
        source: 'https://some/key/uri'
      )

      is_expected.to nothing_execute('verify downloaded phar').with(
        command: 'gpg --keyserver pool.sks-keyservers.net --recv-keys 0x9D8A98B29B2D5D79 && gpg --verify /some/key/path /some/temp/path'
      )

      is_expected.to nothing_file('move binary from tmp to final path').with(
        path: '/some/path'
      )

      is_expected.to delete_file('delete tmp binary').with(
        path: '/some/temp/path'
      )

      is_expected.to delete_file('delete tmp key').with(
        path: '/some/key/path'
      )
    }
  end

  context 'Dont install dependencies' do
    before(:example) do
      stub_command('test -e /usr/bin/phive').and_return(false)
      stub_command('test -e /tmp/phive.phar').and_return(true)
      stub_command('false').and_return(false) # I guess ruby bools are somehow tied to the system?
    end

    recipe do
      codenamephp_php_phive 'phive' do
        install_php_dependencies false
      end
    end

    it {
      is_expected.to_not install_codenamephp_php_package('install needed extensions').with(
        additional_packages: %w[php-xml php-mbstring]
      )
    }
  end

  context 'Uninstall minimal properties' do
    recipe do
      codenamephp_php_phive 'phive' do
        action :uninstall
      end
    end

    it {
      is_expected.to delete_file('delete phive.phar from binary path')
    }
  end
end
