#!/bin/bash

echo "****************************************"
echo "  ENTER NGINX SERVER BLOCK CREDENTIALS  "
echo "****************************************"
echo ''
echo 'Enter domain name: '
read DOMAIN_NAME
echo 'Enter BASE URL: '
read BASE_URL
echo 'Enter production server port: '
read PROD_SERVER_PORT
echo 'Enter dev server port: '
read DEV_SERVER_PORT

sudo mkdir -p "/var/www/$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/$DOMAIN_NAME/html"
sudo cp index.html "/var/www/$DOMAIN_NAME/html/index.html"

sudo mkdir -p "/var/www/staging.$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/staging.$DOMAIN_NAME/html"
sudo cp index.html "/var/www/staging.$DOMAIN_NAME/html/index.html"

#Replaces all occurance of SERVER_PORT, DOMMAIN_NAME, AND BASE_URL in the nginx config file
sudo sed -e "s/server_port/$PROD_SERVER_PORT/g" -e "s/example.com/$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/$DOMAIN_NAME"
sudo sed -e "s/server_port/$DEV_SERVER_PORT/g" -e "s/example.com/staging.$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/staging.$DOMAIN_NAME"

sudo ln -s "/etc/nginx/sites-available/$DOMAIN_NAME" /etc/nginx/sites-enabled/
sudo ln -s "/etc/nginx/sites-available/staging.$DOMAIN_NAME" /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default