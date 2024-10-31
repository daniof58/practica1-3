#!/bin/bash

## Muestra los comandos y para cuando hay un error
set -ex

## Actualización  de repositorios
apt update

## Instalación del servidor apache
apt install apache2 -y


## Reiniciar apache
sudo systemctl restart apache2

##habilitamos el modulo
a2enmod rewrite

## Copiamos archivo de configuración
cp ../conf/000-default.conf /etc/apache2/sites-available

## instalacióin php y modulos
apt install php libapache2-mod-php php-mysql -y

## Instalación de MySQL Server
apt install mysql-server -y

## Reiniciar apache
sudo systemctl restart apache2

## Copiamos el script de prueba de php en /var/www/html
cp ../php/index.php /var/www/html

## Modificamos el propietario
chown -R www-data:www-data /var/www/html
