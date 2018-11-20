property :uri, String, default: 'https://packages.sury.org/php/', description: 'The uri of the repository'
property :repo_name, String, default: 'sury_php', description: 'The name of the repo (the name in the sources.list.d folder)'
property :distribution, String, default: 'stretch', description: 'The distribution the repo is for'
property :components, Array, default: ['main']
property :key, String, default: 'https://packages.sury.org/php/apt.gpg', description: 'The URL from wehre the key will be downloaded'

action :add do
  apt_repository new_resource.repo_name do
    uri new_resource.uri
    repo_name new_resource.repo_name
    distribution new_resource.distribution
    components new_resource.components
    key new_resource.key
  end
end
