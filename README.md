# Wordpress CMS Setup for Debian

## About:
- This script will install required packages for a local Wordpress installation.
- Packages installed:
    - Apache 2
    - MariaDB-Client
    - MariaDB-Server
    - PHP
    - PHP-MySQL
- This script will also setup ``MYSQL_SECURE_CONNECTION``. WIll prompt user for a password
- Will automatically download Wordpress Latest Version, unpack the ``tar.gz`` and move the folder to ``/var/www/html`` and change the ownership of the folder.
- Will create ``/var/www/html/wordpress/wp-content/upload`` and change the folder's ownership as well.
- MySQL DB setup has to be completed manually. Will automate the process in a future release. 

## How to:
- Make the script an executable ```chmod +x WordpressSetup.sh```
- Run the script with ``SUDO`` permission
