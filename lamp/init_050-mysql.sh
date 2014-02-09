#!/bin/bash

pw_mysql_phpmyadmin=$(pwgen -s 12 1)
pw_mysql_root=$(pwgen -s 12 1)


echo "New MySQL account passwords:"
echo ""
echo "user:     phpmyadmin"
echo "password: ${pw_mysql_phpmyadmin}"
echo ""
echo "user:     root"
echo "password: ${pw_mysql_root}"

## Set password in debconf
echo "phpmyadmin phpmyadmin/mysql/app-pass password ${pw_mysql_phpmyadmin}" | debconf-set-selections -v
dpkg-reconfigure -f noninteractive phpmyadmin

## Upgrade Passwords in MySQL

# Upgrade phpmyadmin pw
mysql -u root -e "SET PASSWORD FOR 'phpmyadmin'@'localhost' = PASSWORD('${pw_mysql_phpmyadmin}');"

# Change root pw
mysqladmin -u root password ${pw_mysql_root}

