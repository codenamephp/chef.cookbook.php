# Chef Cookbook PHP
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.php.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.php)

Cookbook to install php and apache2

## Requirements

### Supported Platforms

- Debian Buster (probably works for previous versions and ubuntu too)

### Chef

- Chef 13.0+

### Cookbook Depdendencies

- [apt][apt_github]

## Deprecation

The recicpies are now depcracted and will be removed with the next major release. Just create a wrapper cookbook and use the resources as needed. This is more stable while reducing the amount of "guesswork" that is needed in the first place when creating the recipies.

This also means that the attributes will be removed as well since they are only used in the recipies.

## Usage

Create a wrapper cookbook and add this cookbook to your Berksfile/Metadata.

In your recipie you can use the existing resources, e.g.

```ruby
codenamephp_php_sury_repository 'sury-php'

codenamephp_php_package 'install php 5.6' do
  package_name "php5.6-cli"
end

codenamephp_php_package 'install php 7.4' do
  package_name "php7.4-cli"
  additional_packages %w[php7.4-fpm php7.4-curl php7.4-gd]
end

codenamephp_php_composer 'install composer'

codenamephp_php_xdebug 'install xdebug' do
  php_versions %w[5.6 7.4]
  services %w[cli fpm]
end
```

## Resources

### Composer
This resource can be used to install composer globally.

#### Actions
- `:install`: Install the composer binary (phar) by downloading it from composer homepage and putting it to a folder that is in the path.

#### Properties
- `binary_path`: The path where the binary will be placed, default: `/usr/bin/composer`
- `source`: The source url from where the binary will be downloaded, default: `https://getcomposer.org/composer.phar`

#### Examples
```ruby
# Minmal parameters
codenamephp_php_composer 'install composer'

# Custom source and path
codenamephp_php_composer 'install composer' do
  binary_path '/my/custom/executable/path'
  source 'https://my-self-hosted.composer/binary'
end
```

### Config
This config can be used to create and manage configurations.

#### Actions
- `enable`: Creates or updates the config and enables it by symlinking it for the given services
- `create`: Creates or updates the config without enabling it
- `disable`: Removes the symlink from the given services but does not delete the config
- `delete`: Disables and delete the config

#### Properties
- `cookbook_file`: The file from the cookbook that will be used as config
- `php_versions`: The php versions the config will be managed for as string array
- `config_name`: The name the config will get in the mods-available folder
- `priority`: The prefix the symlink will get to determine the sequence the config is loaded in, default: `30` (after default configs which have 20)
- `services`: The services the config should be managed for, default: `['cli', 'apache2', 'fpm']`
- `cookbook_file_cookbook`: The cookbook the cookfile_file will be taken from, default: `codenamephp_php`

#### Examples
```ruby
# Minimal config
codenamephp_php_config 'configure xdebug' do
  cookbook_file 'xdebug.ini'
  php_versions %w[5.6 7.2]
  config_name 'xdebug-custom.ini'
end

# Custom config
codenamephp_php_config 'configure xdebug' do
  cookbook_file 'super-xdebug.ini'
  php_versions %w[5.6 7.2]
  config_name 'super-xdebug-custom.ini'
  priority 40
  services %w[cli]
  cookbook_file_cookbook 'my_cookbook'
end
```

### Package
This package is used to install php and additional extensions from package

#### Actions
- `install`: Installs php and additional extensions

#### Properties
- `package_name`: The name of the base package, default: `php`
- `additional_packages`: Additional packages to install, default: `[]`

#### Examples
```ruby
# Minimal
codenamephp_php_package 'install php'

# Custom package and extensions
codenamephp_php_package 'install php' do
  package_name 'php7.2-cli'
  additional_packages %w[php7.2-json php7.2-xml]
end
```
### Sury Repository
This resource is used to install the repository from [Ondřej Surý][sury_url] to apt.

#### Actions
- `add`: Adds the repository to apt sources

#### Properties
- `uri`: The uri of the repository, default: `https://packages.sury.org/php/`
- `repo_name`: The name the repository will get, default: `sury_php`
- `components`: The components that will be used, default: `main`
- `key`: The source of the key the repo is signed with, default: `https://packages.sury.org/php/apt.gpg`

#### Examples
```ruby
# Minimal
codenamephp_php_sury_repository 'add sury repository'
```

### XDebug
This resource can be used to install xdebug with a default configuraiton.

#### Actions
- `install`: Installs the xdebug extension and configuration for the given php versions
- `remove`: Removes the extensionand configuration

#### Properties
- `php_versions`: The php versions the config will be managed for as string array
- `package_name`: The name of the package that will be installed, default: `php-xdebug`
- `config_name`: The name of the custom config that will be created, default: `xdebug-custom.ini`
- `config_cookbook_file`: The cookbook file that will be used as config, default: `xdebug.ini`
- `config_cookbook_file_cookbook`: The cookbook the cookbook file will be taken from, default: `codenamephp_php`
- `add_sury_repository`: If the sury repository should be added, default: `true`
- `services`: The services the config should be managed for, default: `['cli', 'apache2', 'fpm']`

#### Examples
```ruby
# Minimal config
codenamephp_php_xdebug 'install xdebug' do
  php_versions %w[5.6 7.2]
end
```

## Default
The default cookbook is a No-Op since you want to choose your PHP version and stick to it. Having the default cookbook to install some "random" version could lead
to unexpected updates and would cause more breaking changes.

[apache2_github]: https://github.com/sous-chefs/apache2
[apt_github]: https://github.com/chef-cookbooks/apt
[chef.cookbook.apache2_github]: https://github.com/codenamephp/chef.cookbook.apache2
[sury_url]: https://deb.sury.org/
