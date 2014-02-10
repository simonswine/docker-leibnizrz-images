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

# MySQL: Create database, add user and grant rights 
mysql -u root -e "
    create database phpmyadmin;
    grant usage on *.* to phpmyadmin@localhost identified by '${pw_mysql_phpmyadmin}';
    grant all privileges on phpmyadmin.* to phpmyadmin@localhost;"

# Install tables
cat /usr/share/dbconfig-common/data/phpmyadmin/install/mysql | mysql -u root phpmyadmin
