#!/bin/bash

pw_mysql_phpmyadmin=$(pwgen -s 12 1)

echo ""
echo "New MySQL account passwords"
echo "user:     phpmyadmin"
echo "password: ${pw_mysql_phpmyadmin}"
echo ""

## Set password in debconf
echo "phpmyadmin phpmyadmin/mysql/app-pass password ${pw_mysql_phpmyadmin}" | debconf-set-selections -v
dpkg-reconfigure -f noninteractive phpmyadmin

# Upgrade Passwords in MySQL
mysql -u root -e "SET PASSWORD FOR 'phpmyadmin'@'localhost' = PASSWORD('${pw_mysql_phpmyadmin}');"
