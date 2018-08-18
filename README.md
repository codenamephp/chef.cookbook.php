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

### Chef

- Chef 13.0+

### Cookbook Depdendencies

- [apt][apt_github]
- [codenamephp_apache2][chef.cookbook.apache2_github]

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

### Attributes

#### Overwrites

##### Common
 
- `default['codename_php']['install_apache'] = true` Set to false if you only want php as cli 
- `default['codename_php']['install_composer'] = true` Set to false if you don't want composer installed 
 
##### Sury Repository

By default, the repository from [Ondřej Surý][sury_url] is used as it provides the most recent and some older versions.

- `default['codename_php']['add_sury_repository'] = true` Set to false if you want to use the OS default channels. 
  Be aware that not all PHP versions might be available.

## Recipes

### 5.6

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default). The installs the CLI package and if install_apache is set to true (which it is by default) the apache package is installed as well. Then the additional packages from the attributes are installed one by one. Finally, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally.

### 7.1

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default). The installs the CLI package and if install_apache is set to true (which it is by default) the apache package is installed as well. Then the additional packages from the attributes are installed one by one. Finally, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally.

### 7.2

Includes the add_sury_repository add the APT repo if the attribute is set to true (which it is by default). The installs the CLI package and if install_apache is set to true (which it is by default) the apache package is installed as well. Then the additional packages from the attributes are installed one by one. Finally, composer.phar is downloaded and placed in the path if the install attribute is set to true so composer is available globally.

### add_sury_repositroy

Adds the repository from [Ondřej Surý][sury_url] to apt.

### Composer

Downloads the composer.phar directly from composer and places it in /usr/bin/composer so composer will be available globally. This is skipped if the file already exists.

### Default
The default cookbook is a No-Op since you want to choose your PHP version and stick to it. Having the default cookbook to install some "random" version could lead
to unexpected updates and would cause more breaking changes.

[apache2_github]: https://github.com/sous-chefs/apache2
[apt_github]: https://github.com/chef-cookbooks/apt
[chef.cookbook.apache2_github]: https://github.com/codenamephp/chef.cookbook.apache2
[sury_url]: https://deb.sury.org/
