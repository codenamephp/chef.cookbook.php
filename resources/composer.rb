# frozen_string_literal: true

property :binary_path, String, default: '/usr/bin/composer', description: 'Path to where the composer binary will be saved'
property :source, String, default: 'https://getcomposer.org/composer.phar', description: 'URL from where the composer binary (phar) will be downloaded'

action :install do
  remote_file new_resource.binary_path do
    source new_resource.source
    mode '0777'
    action :create_if_missing
    only_if 'which php'
  end
end
