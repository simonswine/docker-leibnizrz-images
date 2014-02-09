#!/bin/bash

pw_mysql_root=$(pwgen -s 12 1)

echo ""
echo "New MySQL account password:"
echo "user:     root"
echo "password: ${pw_mysql_root}"
echo ""

# Change root pw
mysqladmin -u root password ${pw_mysql_root}

