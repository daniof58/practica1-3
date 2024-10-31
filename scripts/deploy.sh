#!/bin/bash

# Importamos el archivo de variables
source .env

## Muestra los comandos y para cuando hay un error
set -ex


#Eliminamos clonados previos  de la aplicación
rm -rf /tmp/iaw-practica-lamp

#Colanamos el repositorio de la aplicacion
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp

#Movemos el codigo fuente de la aplicación a /var/www/html:
mv /tmp/iaw-practica-lamp/src/* /var/www/html


#Confirmamos el archivo confiphp
sed -i "s/database_name_here/$DB_NAME/" /var/www/html/config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/config.php
sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/config.php

#Importar script
mysql -u root <<<"DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root <<<"CREATE DATABASE $DB_NAME"

# Creamos el usuario en la base de datos
mysql -u root <<< "DROP USER IF EXISTS '$DB_USER'@'%'"
mysql -u root <<< "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%'"

## Configuramos el script de SQL con el nombre de la base de datos
sed -i "s/lamp_db/$DB_NAME/" /tmp/iaw-practica-lamp/db/database.sql

## Creamos una tabla de la base de datos
mysql -u root < /tmp/iaw-practica-lamp/db/database.sql