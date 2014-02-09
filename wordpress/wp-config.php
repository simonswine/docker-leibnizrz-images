<?php
/**
 *
 * Secret-Keys, Sprache und ABSPATH. Mehr Informationen zur wp-config.php gibt es auf der {@link http://codex.wordpress.org/Editing_wp-config.php
 *
 * und die Installationsroutine (/wp-admin/install.php) aufgerufen wird.
 * Man kann aber auch direkt in dieser Datei alle Eingaben vornehmen und sie von wp-config-sample.php in wp-config.php umbenennen und die Installation starten.
 *
 * @package WordPress
 */

/**  MySQL Einstellungen - diese Angaben bekommst du von deinem Webhoster. */
define('DB_NAME', 'wordpress');

/** Ersetze username_here mit deinem MySQL-Datenbank-Benutzernamen */
define('DB_USER', 'wordpress');

/** Ersetze password_here mit deinem MySQL-Passwort */
define('DB_PASSWORD', 'alW1THtFOoBK');

/** Ersetze localhost mit der MySQL-Serveradresse */
define('DB_HOST', 'localhost');

/** Der Datenbankzeichensatz der beim Erstellen der Datenbanktabellen verwendet werden soll */
define('DB_CHARSET', 'utf8');

define('DB_COLLATE', '');

/**#@+
 *
 * Auf der Seite {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service} kannst du dir alle KEYS generieren lassen.
 *
 * @seit 2.6.0
 */
define('AUTH_KEY',         'tm(!5E`bg1yxj?Y![G-fggAe7y@M${6+;(h4+%a5hyv8K=kdiL<XrWxb=9[PDT&I');
define('SECURE_AUTH_KEY',  'i]mM~}/x0V.]pd.mAqAcjlQLis6j2vqRU1fWc!Y{eC+Wgv-qqh @-;nTg7E)KS!+');
define('LOGGED_IN_KEY',    'mmh/3q/dTi<_|~R`+ao=-^Y&`g`qgaB1nu}:4PN*&v5515.:6H$XA`viD9:G_Pkv');
define('NONCE_KEY',        '-oEaMKa*+B$iAq#JmYZFJacKd#xg5(~+?`:sCjrg[*@S*:X!rP$j|]eEM0].fl{,');
define('AUTH_SALT',        'J!Nc}`-M]Q;0*,$#O){R`X(Z&52YI=Lg]45-a2lJ:EVZ64>-HE#CqAybyy0+Pq|C');
define('SECURE_AUTH_SALT', '~K<E]{hDqv})uCD511+6N2N,Q:FVALTUWUdoue3^ U`=TY!#0Ha;yLUy]PW?4ntj');
define('LOGGED_IN_SALT',   '0!A}h|7c|g|@W)+^~ucNQJ$.KXt;IGMr,^)sV?q+&G,Q-<2}bB^~O@-Numu-)SNb');
define('NONCE_SALT',       'eX:&1+ (us.%^> C{rw1B?m-;wN0xG}b!?sk1Kz]`pfj|+])p<uz&f|@ysfbHvw+');

/**#@-*/

/**
 *
 *  verschiedene WordPress-Installationen betreiben. Nur Zahlen, Buchstaben und Unterstriche bitte!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Sprachdatei
 *
 * Hier kannst du einstellen, welche Sprachdatei benutzt werden soll. Die entsprechende
 * Sprachdatei muss im Ordner wp-content/languages vorhanden sein, beispielsweise de_DE.mo
 */
define('WPLANG', 'de_DE');

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
