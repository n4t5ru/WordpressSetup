#!/bin/bash

: '
    Author:         n4t5ru
    Email:          hello@nasru.me
    Version:        1  
    Created:        07/APR/2023
    ScriptName:     WordpressSetup.sh
    Description:    Automated the steps taken to install Wordpress and setup the required dependencies 
    How To:         Run the script as Root
'

function main(){
# Mandatory update and Upgrade process
apt update && upgrade

# Install and check if Apache2 is running correctly
apt install apache2 -y

if systemctl is-active --quiet apache2.service ; then
    echo "Apache2 is running"
else
    echo "Apache2 is not running"
    exit 1
fi

# Install Database for Wordpress
apt install mariadb-server mariadb-client -y

# Takes password for MySQL and runs MYSQL_SECURE_CONNECTION
read -sp "Enter MySQL Root Password: " mysql_password 
mysql_secure_connection << EOF
Y
$mysql_password
Y
Y
Y
Y
EOF

# Install required PHP packages
apt install php php-mysql -y

# Database creation
mysql -u root -p 

# << EOF
# $mysql_password
# CREATE DATABASE wordpress_db;
# CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';
# GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';
# FLUSH PRIVILEGES;
# Exit;
# EOF

# Download, upack, copy and modify permission of Wordpress CMS 
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cp -R wordpress /var/www/html/
chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress/
mkdir /var/www/html/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/

}

if [[ ${UID} == 0 ]]; then
    main

    exit 1
else
    echo "${red}
    This script needs SUDO access......
    Please run using sudo.${normal}
    "
    exit 1
fi
