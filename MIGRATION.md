# Migration

This document contains all the info needed for upgrades of Major releases.

# 2

## Recipes
Following recipies have been deleted:
  - composer
  - xdebug

These are already installed when installing php so if you don't need them just remove them. If you need them, check the resources to install them again.

## Apache
To reduce the dependencies and since the apache cookbook has trouble with the latest chef version at the time this version was released, apache was removed from the cookbook.

Use the apache cookbook directly or create a wrapper cookbook that combines both cookbooks to install apache as needed.