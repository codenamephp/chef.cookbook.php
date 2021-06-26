# frozen_string_literal: true

unified_mode true

property :binary_path, String, default: '/usr/bin/composer', description: 'Path to where the composer binary will be saved'
property :source, String, default: 'stable', description: 'URL from where the composer binary (phar) will be downloaded'

action :install do
  remote_file new_resource.binary_path do
    source source_url(new_resource.source)
    mode '0777'
    action :create_if_missing
    only_if 'which php'
  end
end

action_class do
  def source_url(source_string)
    {
      'stable' => 'https://getcomposer.org/composer-stable.phar',
      'preview' => 'https://getcomposer.org/composer-preview.phar',
      'snapshot' => 'https://getcomposer.org/composer.phar',
      '1' => 'https://getcomposer.org/composer-1.phar',
      '2' => 'https://getcomposer.org/composer-2.phar',
    }.fetch(source_string, source_string)
  end
end
