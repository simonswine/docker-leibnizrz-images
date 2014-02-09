#!/bin/bash

pw_mysql_wordpress=$(pwgen -s 12 1)


echo "New MySQL account passwords:"
echo ""
echo "user:     wordpress"
echo "password: ${pw_mysql_wordpress}"
echo ""
echo "Please create an admin account for this WordPress installation immedatatly!"
echo ""


# MySQL: Create database, add user and grant rights 
mysql -u root -e "
    create database wordpress;
    grant usage on *.* to wordpress@localhost identified by '${pw_mysql_wordpress}';
    grant all privileges on wordpress.* to wordpress@localhost;"

# Wordpress Symlink everything to /var/www
find /usr/local/share/wordpress/ -mindepth 1 -maxdepth 1 ! -name wp-content -type f -exec ln -s ../..{} /var/www/ \;
find /usr/local/share/wordpress/ -mindepth 1 -maxdepth 1 ! -name wp-content -type d -exec ln -s ../..{} /var/www/ \;

# Copy wp-content to /var/www
rsync -a /usr/local/share/wordpress/wp-content/ /var/www/wp-content/

# Write htaccess
cat > /var/www/.htaccess <<EOF
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
EOF


# Wordpress Write config file
cat > /var/www/wp-config.php <<EOF
<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', '${pw_mysql_wordpress}');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '$(pwgen -s 64 1)');
define('SECURE_AUTH_KEY',  '$(pwgen -s 64 1)');
define('LOGGED_IN_KEY',    '$(pwgen -s 64 1)');
define('NONCE_KEY',        '$(pwgen -s 64 1)');
define('AUTH_SALT',        '$(pwgen -s 64 1)');
define('SECURE_AUTH_SALT', '$(pwgen -s 64 1)');
define('LOGGED_IN_SALT',   '$(pwgen -s 64 1)');
define('NONCE_SALT',       '$(pwgen -s 64 1)');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
\$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', 'de_DE');

/**
 * Set dir for contents
 */
define('WP_CONTENT_DIR', dirname( __FILE__ ) . '/wp-content' );

/**
 * Disable auto updates
 */
define('AUTOMATIC_UPDATER_DISABLED', true);

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

EOF

# Setting right for wp-content
chown www-data:www-data -R /var/www/wp-content
chown root:www-data /var/www
chmod 750 /var/www
