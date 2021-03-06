# Parent-Image festlegen
FROM leibnizrz/wheezy-base
MAINTAINER Christian Simon <simonc@campus.lmu.de>

## Docker Verwaltungsdir
RUN mkdir -p /.docker/ && mkdir -p /.docker/init
# Füge Startskript hinzu
ADD run.sh /.docker/run.sh
RUN chmod +x /.docker/run.sh
# Docker Data Volume
VOLUME ["/.docker/data"]

## Apache & PHP
# Installiere Apache und PHP 5.4
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client apache2 libapache2-mod-php5 php5-mysql php5-gd php5-mcrypt && apt-get clean
# Apache Startskript
ADD ./apache.foreground.sh /etc/apache2/foreground.sh
# Apache Startkonfig
ADD ./supervisord.apache.conf /etc/supervisor/conf.d/apache.conf
# Apache Standard vHost Konfiguration
ADD ./apache.sites.default.conf /etc/apache2/sites-available/default
# Clear Webroot
RUN rm -rf /var/www/*
# Webroot als Volume
VOLUME ["/var/www"] 

## MySQL
# Füge MySQL User/Group hinzu um stabile uid/gid zu erhalten
RUN addgroup --gid 200 mysql
RUN adduser --gid 200 --uid 200 mysql
# Installiere MySQL und PHPMyAdmin
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server phpmyadmin && apt-get clean
# Volume für MySQL
VOLUME ["/var/lib/mysql"]
# MySQL Startkonfig
ADD ./supervisord.mysql.conf /etc/supervisor/conf.d/mysql.conf
# MySQL Initialisierung (Ändert root Passwort)
ADD init_050-mysql.sh /.docker/init/050-mysql
RUN chmod +x /.docker/init/050-mysql
# Entferne bereits bestehende MySQL Datenbanken 
RUN rm -rf /var/lib/mysql/*
# Aktiviere phpmyadmin
RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections -v && dpkg-reconfigure -f noninteractive phpmyadmin
# phpmyadminL Initialisierung (Ändert MySQL-Passwort / legt Datenbankschema an)
ADD init_025-phpmyadmin.sh /.docker/init/025-phpmyadmin
RUN chmod +x /.docker/init/025-phpmyadmin

# Port 80 soll veröffentlicht werden
EXPOSE 80

# Standardmäßig run.sh ausführen
CMD    ["/.docker/run.sh"]

