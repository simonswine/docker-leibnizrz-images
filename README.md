#Docker Images *leibnizrz/*

You find here the *Dockerfiles* for the *leibnizrz/* Docker images of the official Docker Registry (https://index.docker.io/u/leibnizrz/)

This images help hosting providers to host web application. This work is part of my master thesis at LRZ (http://www.lrz.de)

##Images##

<a name="wheezy-base"></a>
###leibnizrz/wheezy-base 

####leibnizrz/wheezy-base:import

- Base Image for Debian Wheezy
- Generated using debootstrap:
```
> debootstrap wheezy wheezy-base_import http://ftp.de.debian.org/debian/ 
[...]
> tar -C wheezy-base_import -c . | docker import - leibnizrz/wheezy-base:import
[...]
```

####leibnizrz/wheezy-base(:latest)

- Adds security main contrib apt repositires of Debian Wheezy
- Installs available upgrades
- Installs tools like: `vim git procps psmisc wget supervisor nano pwgen tzdata rsync`


<a name="lamp"></a>
###leibnizrz/lamp 

- Installs LAMPP Stack (Linux, Apache 2.2, MySQL 5.5, PHP 5.4, PHPMyAdmin)
- During container runtime Password for MySQL's `root`-user are generated
- Use Volumes for 
 - `/var/www` (WWW-Root)
 - `/var/lib/mysql` (MySQL-Daten)
 - `/.docker/data` (Docker-Verwaltung-Daten)

<a name="lamp_container"></a>
####Running a container 

```
# Fetch images
> docker fetch leibnizrz/lamp
[...]
# Define home dir of files
> export BASE_DIR=/customer/customer1
# Run a container in background
> docker run \                                      
		-d \                                        # Daemonize
		-p 8001:80 \                                # Forward port 8001 of host to container's port 80
		-v ${BASE_DIR}/docker-data:/.docker/data \  # Mount volumes in the host
		-v ${BASE_DIR}/mysql:/var/lib/mysql \      
		-v ${BASE_DIR}/www:/var/www \
		leibnizrz/lamp                              # Name of the image
[Output of Container ID]
# Get generated passwords 
> docker logs <Container ID>
[...]
Please store the following information at a safe place,
as it is only shown once

run-parts: executing /.docker/init/50-mysql
/.docker/init/50-mysql:
New MySQL account passwords:

user:     phpmyadmin
password: *secret*

user:     root
password: *secret*
[...]
```

- Now you should reach the `${BASE_DIR}/www` at http://docker-host:8001/`enter code here`
- PHPMyAdmin is at  `http://docker-host:8001/phpmyadmin

<a name="wordpress"></a>
###leibnizrz/wordpress 

- Wordpress 3.8.1
- Right after container launch, do the wordpress intial setup

####Running a container

- cf. [this](#lamp_container)





