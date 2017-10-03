# Chef Cookbook Apache2

Cookbook to install apache2 as a wrapper coockbook for [Apache2][apache2_github]

## Requirements

### Supported Platforms

- Debian Stretch

### Chef

- Chef 13.0+

### Cookbook Depdendencies

## Usage

Add the cookbook to your Berksfile:

```
cookbook 'chef.cookbook.apache2', :github 'codenamephp/chef.cookbook.apache2'
```

Add the cookbook to your runlist, e.g. in a role:

To install additional modules, you can either set/extend the `default['apache']['default_modules']`attribute or just
add the corresponding `apache2::*` cookbooks for that module

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
	  "recipe[chef.cookbook.apache2]"
  ]
}
```

### Attributes

#### Overwrites

By default, the `default['apache']['listen']` is set to `['*:80', '*:443']` to listen to both http and https
and therefore `default['apache']['default_modules']` is extend with `['ssl']` so mod_ssl module is activated by default.

[apache2_github]: https://github.com/sous-chefs/apache2