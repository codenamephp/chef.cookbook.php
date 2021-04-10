# frozen_string_literal: true

control 'php-1.0' do
  title 'Make sure php is intsalled'
  desc 'Install php5.6 with cli and 7.4 with cli and fpm, composer and xdebug'

  describe package('php5.6-cli') do
    it { should be_installed }
  end

  describe package('php7.4-cli') do
    it { should be_installed }
  end

  describe package('php7.4-fpm') do
    it { should be_installed }
  end

  describe package('php7.4-curl') do
    it { should be_installed }
  end

  describe package('php7.4-gd') do
    it { should be_installed }
  end

  describe package('php8.0-cli') do
    it { should be_installed }
  end
end
