#!/bin/bash

# Pfad zur Init Markierung
INIT_FILE=/.docker/data/.docker_init

# Aktiviere Job monitoring
set -m

# Initialisiere Datenbank fals nötig


# Prüfe ob Container bereits initialisiert, falls nein initialisiere zuerst
if [ ! -f $INIT_FILE ]; then

    # Initialisiere MySQL-Server
    dpkg-reconfigure -f noninteractive mysql-server-5.5
  
    # Warte bis mysql-server getstartet ist
    sleep 1

    # Führe Initialisierung durch 
    echo -e "\e[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! \e[0m\n"
    echo -e "\e[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! \e[0m\n"
    echo -e "\e[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! \e[0m\n\n"
    echo "Please store the following information at a safe place,"
    echo -e "as it is only shown once\n"
    run-parts -v --report /.docker/init

    # MySQL stoppen
    service mysql stop

    touch $INIT_FILE
fi

# Starte supervisord 
supervisord -n
