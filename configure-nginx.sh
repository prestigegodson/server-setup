#!/bin/bash

echo "****************************************"
echo "  ENTER NGINX SERVER BLOCK CREDENTIALS  "
echo "****************************************"
echo ''
echo 'Enter domain name. eg: example.com : '
read DOMAIN_NAME
echo 'Enter BASE URL. eg: /test/api/ :  '
read BASE_URL
echo 'Enter dev server port e.g 8081: '
read SERVER_PORT

sudo mkdir -p "/var/www/$DOMAIN_NAME/html"
sudo chmod -R 755 "/var/www/$DOMAIN_NAME/html"
sudo cp index.html "/var/www/$DOMAIN_NAME/html/index.html"

#Replaces all occurance of SERVER_PORT, DOMMAIN_NAME, AND BASE_URL in the nginx config file
sudo sed -e "s/server_port/$SERVER_PORT/g" -e "s/example.com/$DOMAIN_NAME/g" -e "s|base_url|$BASE_URL|g" nginx.conf > "/etc/nginx/sites-available/$DOMAIN_NAME"

if [ ! -f "/etc/nginx/sites-enabled/$DOMAIN_NAME" ]
then
    sudo ln -s "/etc/nginx/sites-available/$DOMAIN_NAME" /etc/nginx/sites-enabled/
fi

if [ -f "/etc/nginx/sites-enabled/default" ]
then
    sudo rm /etc/nginx/sites-enabled/default
fi

# Next, test to make sure that there are no syntax errors in any of your Nginx files:
sudo nginx -t

sudo systemctl restart nginx