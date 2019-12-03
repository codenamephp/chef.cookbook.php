# Chef Cookbook PHP
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.php.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.php)

Cookbook to install php and apache2

## Requirements

### Supported Platforms

- Debian Stretch

### Supported PHP versions

- 5.6
- 7.1
- 7.2
- 7.3

### Chef

- Chef 13.0+

### Cookbook Depdendencies

- [apt][apt_github]

## Usage

Add the cookbook to your Berksfile:

```
cookbook 'codename_php'
```

Don't forget to add the version constraint for the latest version, e.g. "~> 2.0"

Add the cookbook to your runlist. Since the default recipe is a No-Op, you need to add the version you want as recipe.

This example will install php5.6 and php7.1 where php7.1 will be used for apache since it is the last package to install the apache package.

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
    "recipe[codename_php::5.6]"
	  "recipe[codename_php::7.1]"
  ]
}
```
 For more flexiblity, check the resources.
 
### Attributes

#### Overwrites

##### Common
 
- `default['codename_php']['install_composer'] = true` Set to false if you don't want composer installed 
- `default['codename_php']['install_xdebug'] = true` Set to false if you don't want xdebug installed 
 
##### Sury Repository

By default, the repository from [Ondřej Surý][sury_url] is used as it provides the most recent and some older versions.

- `default['codename_php']['add_sury_repository'] = true` Set to false if you want to use the OS default channels. 
  Be aware that not all PHP versions might be available.

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
- `services`: The services the config should be managed for, default: `['cli', 'apache2']`
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

#### Examples
```ruby
# Minimal config
codenamephp_php_xdebug 'install xdebug' do
  php_versions %w[5.6 7.2]
end
```

## Recipes
These recipies are included to install useful default php versions. Use the resources if you need more flexibility.

### 5.6

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default) and installs php cli from package. Then the additional packages from the attributes are installed one by one. Then, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally. Finally, xdebug will be installed from package if the attribute is still set to true.

### 7.1

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default) and installs php cli from package. Then the additional packages from the attributes are installed one by one. Then, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally. Finally, xdebug will be installed from package if the attribute is still set to true.

### 7.2

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default) and installs php cli from package. Then the additional packages from the attributes are installed one by one. Then, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally. Finally, xdebug will be installed from package if the attribute is still set to true.

### 7.3

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default) and installs php cli from package. Then the additional packages from the attributes are installed one by one. Then, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally. Finally, xdebug will be installed from package if the attribute is still set to true.

### add_sury_repositroy

Adds the repository from [Ondřej Surý][sury_url] to apt.

### Default
The default cookbook is a No-Op since you want to choose your PHP version and stick to it. Having the default cookbook to install some "random" version could lead
to unexpected updates and would cause more breaking changes.

[apache2_github]: https://github.com/sous-chefs/apache2
[apt_github]: https://github.com/chef-cookbooks/apt
[chef.cookbook.apache2_github]: https://github.com/codenamephp/chef.cookbook.apache2
[sury_url]: https://deb.sury.org/
