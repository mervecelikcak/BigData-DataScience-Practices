#!/bin/bash

# EJERCICIO 1

# 2)
# a) Download the mariadb image with docker pull
docker pull mariadb


# b) Create a database container with docker run
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=wordpress -d mysql:5.7
docker run --detach --name some-mariadb --env MARIADB_USER=wordpress --env MARIADB_PASSWORD=wordpress --env MARIADB_DATABASE=wordpress --env MARIADB_ROOT_PASSWORD=password mariadb:latest



# c) Create another mariadb container and connect to the mysql client in command line
docker network create wordpress
docker run --detach --name my-mariadb --env MARIADB_USER=wordpress --env MARIADB_PASSWORD=wordpress --env MARIADB_DATABASE=wordpress --env MARIADB_ROOT_PASSWORD=password --network wordpress mariadb:latest

docker run --name some-wordpress --network wordpress -p 8080:80 -d wordpress

# docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=wordpress --network wordpress -d mysql:5.7


# 3) Add persistence by associating the directory with the database to a directory on the host
docker run --volume=/home/merve/Desktop/Infraestructura_para_big_data/Practica_5:/var/lib/mysql --env MARIADB_ROOT_PASSWORD=password mariadb

docker ps

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



# EJERCICIO 2

# Create the docker-compose definition for wordpress, along with a database, phpmyadmin, and a data volume (add elements incrementally)
# 1) Create the database, mysql or mariadb, and a container for the database data.
# 2) Add the phpmyadmin administration tool
# 3) Add wordpress


# Define docker-compose.yml
version: "3.8"  # Specify the docker-compose version

services:
  db:
    image: mariadb:latest  # Use the latest MariaDB image
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw  # Set the root password (replace with a strong password)
      MYSQL_DATABASE: wordpress  # Database name for WordPress
      MYSQL_USER: wordpress  # Database user for WordPress
      MYSQL_PASSWORD: wordpress  # Password for the WordPress user (replace with a strong password)
    volumes:
      - db_data:/var/lib/mysql  # Mount a volume named db_data to persist database data

  phpmyadmin:
    image: phpmyadmin
    ports:
      - "8080:80"  # Map container port 80 to host port 8080
    environment:
      PMA_ARBITRARY: 1 
    depends_on:
      - db

  wordpress:
    image: wordpress
    ports:
      - 8081:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress:/var/www/html  # Mount a volume named wordpress for persistent data
    deploy:
      replicas: 3

volumes:
  wordpress:
  db_data:





docker-compose up -d


# EJERCICIO 3

# Add the deployment configuration to exercise 2, so that wordpress is replicated on the three nodes.

# Test that it works correctly by connecting to any node in the cluster.

docker swarm init --advertise-addr 192.168.56.104

docker swarm join --token SWMTKN-1-3k7g3usdnck6e2f00c17svk6j1qety6giiq5julx131a4lh8r6-9sckn743ku8d7kl1nxx0zt0ar 192.168.56.104:2377

docker node ls


# Define docker-compose.yml
version: '3'
services:
  web:
    image: httpd_2.4-alpine
    ports:
      - "80:80"
    deploy:
      replicas: 3


