# Migration

This document contains all the info needed for upgrades of Major releases.

# 4.0

XDebug 2 config was removed. If you still need to run XDebug 2 for some reason use the resource to install a custom config. XDebug is now not installed
for CLI anymore since it's easy to enable it if needed and this removes the performance hit when running CLI tools (e.g. composer).

# 3.4
Support for XDebug 3 was added. This just means that `xdebug.mode=debug,develop` is now set in addition to the XDebug2 settings. This should enable
the same behaviour as before. This also means that XDebug is also active on CLI. This will change with the next major release.

The plan is that XDebug3 will only be enabled on CLI with explict env var that can just be prepended to any CLI call and is also set by default
when debugging a script with PHPStorm.

For the actual migration: Just make sure XDebug3 is installed and that PHPStorm is configured correctly (which it should be by default). The XDebug Helper in
chrome should also still work as before.

# 3

## Recipes
Following recipies have been deleted:
  - composer
  - xdebug

These are already installed when installing php so if you don't need them just remove them. If you need them, check the resources to install them again.

## Apache
To reduce the dependencies and since the apache cookbook has trouble with the latest chef version at the time this version was released, apache was removed from the cookbook.

Use the apache cookbook directly or create a wrapper cookbook that combines both cookbooks to install apache as needed.

# 2

Default recipe is now a no-op. Add the desired recipe for the php version instead.