# Parent-Image festlegen
FROM leibnizrz/lamp
MAINTAINER Christian Simon <simonc@campus.lmu.de>

## Wordpress

# Empty /var/www
RUN rm -rf /var/www/*

# Download/Install Wordpress 3.8.1
RUN mkdir -p /usr/local/share/wordpress
RUN wget --progress=dot:mega http://de.wordpress.org/wordpress-3.8.1-de_DE.tar.gz -O - | tar xfz - -C /usr/local/share/wordpress --strip-component=1
RUN chown -cR root:root /usr/local/share/wordpress
RUN chmod -cR o-w,g-w /usr/local/share/wordpress
RUN ln -s ../../../../var/www/wp-config.php /usr/local/share/wordpress/wp-config.php

# Enable mod_rewrite
RUN a2enmod rewrite

# Install init script (Number < 050 root == '')
ADD init_025-wordpress.sh /.docker/init/25-wordpress
RUN chmod +x /.docker/init/25-wordpress

