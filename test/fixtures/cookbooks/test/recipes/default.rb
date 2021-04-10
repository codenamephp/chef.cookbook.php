# frozen_string_literal: true

codenamephp_php_sury_repository 'sury-php'

codenamephp_php_package 'install php 5.6' do
  package_name 'php5.6-cli'
end

codenamephp_php_package 'install php 7.4' do
  package_name 'php7.4-cli'
  additional_packages %w(php7.4-fpm php7.4-curl php7.4-gd)
end

codenamephp_php_package 'install php 8.0' do
  package_name 'php8.0-cli'
end

codenamephp_php_composer 'install composer'

codenamephp_php_xdebug 'install xdebug' do
  php_versions %w(5.6 7.4 8.0)
  services %w(cli fpm)
end

codenamephp_php_phive 'install phive' do
  php_version '8.0'
end
