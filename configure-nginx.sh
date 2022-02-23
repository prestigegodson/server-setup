#!/bin/bash

echo "****************************************"
echo "  ENTER NGINX SERVER BLOCK CREDENTIALS  "
echo "****************************************"
echo ''
echo 'Enter domain name. eg: artandcodes.com : '
read DOMAIN_NAME
echo 'Enter BASE URL. eg: /sell/api/ :  '
read BASE_URL
echo 'Enter production server port e.g 8080: '
read PROD_SERVER_PORT
echo 'Enter dev server port e.g 8081: '
read DEV_SERVER_PORT

sudo mkdir -p "/var/www/$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/$DOMAIN_NAME/html"
sudo cp index.html "/var/www/$DOMAIN_NAME/html/index.html"

sudo mkdir -p "/var/www/sell.$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/sell.$DOMAIN_NAME/html"
sudo cp index.html "/var/www/sell.$DOMAIN_NAME/html/index.html"

sudo mkdir -p "/var/www/sell-portal.$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/sell-portal.$DOMAIN_NAME/html"
sudo cp index.html "/var/www/sell-portal.$DOMAIN_NAME/html/index.html"

# sudo mkdir -p "/var/www/staging-portal.$DOMAIN_NAME/html"
# sudo chmod -R 755 "/var/www/staging-portal.$DOMAIN_NAME/html"
# sudo cp index.html "/var/www/staging-portal.$DOMAIN_NAME/html/index.html"

#Replaces all occurance of SERVER_PORT, DOMMAIN_NAME, AND BASE_URL in the nginx config file
sudo sed -e "s/server_port/$PROD_SERVER_PORT/g" -e "s/example.com/$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/$DOMAIN_NAME"
sudo sed -e "s/server_port/$DEV_SERVER_PORT/g" -e "s/example.com/staging.$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/sell.$DOMAIN_NAME"
sudo sed -e "s/server_port/$PROD_SERVER_PORT/g" -e "s/example.com/portal.$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/sell-portal.$DOMAIN_NAME"
# sudo sed -e "s/server_port/$DEV_SERVER_PORT/g" -e "s/example.com/staging-portal.$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/staging-portal.$DOMAIN_NAME"

if [ ! -f "/etc/nginx/sites-enabled/$DOMAIN_NAME" ]
then
    sudo ln -s "/etc/nginx/sites-available/$DOMAIN_NAME" /etc/nginx/sites-enabled/
fi

if [ ! -f "/etc/nginx/sites-enabled/sell.$DOMAIN_NAME" ]
then
    sudo ln -s "/etc/nginx/sites-available/sell.$DOMAIN_NAME" /etc/nginx/sites-enabled/
fi

if [ ! -f "/etc/nginx/sites-enabled/sell-portal.$DOMAIN_NAME" ]
then
    sudo ln -s "/etc/nginx/sites-available/sell-portal.$DOMAIN_NAME" /etc/nginx/sites-enabled/
fi

# if [ ! -f "/etc/nginx/sites-enabled/staging-portal.$DOMAIN_NAME" ]
# then
#     sudo ln -s "/etc/nginx/sites-available/staging-portal.$DOMAIN_NAME" /etc/nginx/sites-enabled/
# fi

if [ -f "/etc/nginx/sites-enabled/default" ]
then
    sudo rm /etc/nginx/sites-enabled/default
fi

# Next, test to make sure that there are no syntax errors in any of your Nginx files:
sudo nginx -t

sudo systemctl restart nginx