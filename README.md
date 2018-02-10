# Chef Cookbook PHP

Cookbook to install php and apache2

## Requirements

### Supported Platforms

- Debian Stretch

### Supported PHP versions

- 7.1

### Chef

- Chef 13.0+

### Cookbook Depdendencies

- [apt][apt_github]
- [chef.cookbook.apache2][chef.cookbook.apache2_github]

## Usage

Add the cookbook to your Berksfile:

```
cookbook 'codename_php', :github 'codenamephp/codename_php'
```

Add the cookbook to your runlist of the php version you want, e.g. in a role:

Keep in mind that the default recipe is a No-Op!

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
	  "recipe[codename_php::7.1]"
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