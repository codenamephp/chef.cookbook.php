# Chef Cookbook PHP
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.php.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.php)

Cookbook to install php and apache2

## Requirements

### Supported Platforms

- Debian Stretch

### Supported PHP versions

- 5.6
- 7.1

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

Add the cookbook to your runlist. By default, the recipe specified in `default['codename_php']['php_recipe']` will be included. You can add additional 
php version by adding the recipe to your runlist.

This example will install the default version and php5.6

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
    "recipe[codename_php::5.6]"
	  "recipe[codename_php]"
  ]
}
```

### Attributes

#### Overwrites

##### Common
 
- `default['codename_php']['install_apache'] = true` Set to false if you only want php as cli 
- `default['codename_php']['install_composer'] = true` Set to false if you don't want composer installed 
- `default['codename_php']['php_recipe'] = '::7.1'` Which php recipe will be used. This recipe will be included by the default recipe. Can either be one from this cookbook or a completely different one
 
##### Sury Repository

By default, the repository from [Ondřej Surý][sury_url] is used as it provides the most recent and some older versions.

- `default['codename_php']['add_sury_repository'] = true` Set to false if you want to use the OS default channels. 
  Be aware that not all PHP versions might be available.

[apache2_github]: https://github.com/sous-chefs/apache2
[apt_github]: https://github.com/chef-cookbooks/apt
[chef.cookbook.apache2_github]: https://github.com/codenamephp/chef.cookbook.apache2
[sury_url]: https://deb.sury.org/
