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
echo "Enter Database Name: "
read DB_NAME
echo "Enter DB username: "
read DB_USER_NAME
echo "Enter DB password: "
read DB_PASSWORD

sudo -u postgres psql -d postgres -c "CREATE DATABASE $DB_NAME"
sudo -u postgres psql -d postgres -c "CREATE ROLE $DB_USER_NAME LOGIN" 
sudo -u postgres psql -d postgres -c "ALTER ROLE $DB_USER_NAME WITH PASSWORD '$DB_PASSWORD'"
sudo -u postgres psql -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $DB_PASSWORD to $DB_USER_NAME"