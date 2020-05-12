#!/bin/bash

sudo apt-get install postgresql postgresql-contrib

# configure postgres to start on server boot
update-rc.d postgresql enable

# start postgres
service postgresql start

# Create database
echo "**************************************"
echo "        DATABASE CREDENTIALS          "
echo "**************************************"
echo "Enter Production Database Name: "
read PROD_DB_NAME
echo "Enter Development Database Name: "
read DEV_DB_NAME
echo "Enter DB username: "
read DB_USER_NAME
echo "Enter DB password: "
read DB_PASSWORD

sudo -u postgres psql -d postgres -c "CREATE DATABASE $PROD_DB_NAME"
sudo -u postgres psql -d postgres -c "CREATE DATABASE $DEV_DB_NAME" 
sudo -u postgres psql -d postgres -c "CREATE ROLE $DB_USER_NAME LOGIN" 
sudo -u postgres psql -d postgres -c "ALTER ROLE $DB_USER_NAME WITH PASSWORD '$DB_PASSWORD'"
sudo -u postgres psql -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $PROD_DB_NAME to $DB_USER_NAME"
sudo -u postgres psql -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $DEV_DB_NAME to $DB_USER_NAME"