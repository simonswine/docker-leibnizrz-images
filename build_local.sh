#!/bin/bash

# Wheezy Base
docker build --rm -t leibnizrz/wheezy-base wheezy-base/

# LAMP
docker build --rm -t leibnizrz/lamp lamp/

# Wordpress
docker build --rm -t leibnizrz/wordpress wordpress/
