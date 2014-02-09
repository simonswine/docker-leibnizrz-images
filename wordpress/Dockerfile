# Parent-Image festlegen
FROM leibnizrz/lamp
MAINTAINER Christian Simon <simonc@campus.lmu.de>

## Wordpress
# Download und entpacken von Wordpress 3.8.1 (de_DE)
RUN mkdir -p /usr/local/share/wordpress
RUN wget --progress=dot:mega http://de.wordpress.org/wordpress-3.8.1-de_DE.tar.gz -O - | tar xfz - -C /usr/local/share/wordpress --strip-component=1
# Passe Rechte an 
RUN chown -cR root:root /usr/local/share/wordpress
RUN chmod -cR o-w,g-w /usr/local/share/wordpress
# Linke Config Datei
RUN ln -s ../../../../var/www/wp-config.php /usr/local/share/wordpress/wp-config.php
# Aktiviere Apache-Module rewrite
RUN a2enmod rewrite
# Wordpress Initialisierung
ADD init_025-wordpress.sh /.docker/init/025-wordpress
RUN chmod +x /.docker/init/025-wordpress
