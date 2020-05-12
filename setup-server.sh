#!/bin/sh

sh ./install-nginx.sh
sh ./configure-nginx.sh
sh ./install-jdk.sh
sh ./install-mvn.sh
sh ./install-postgres.sh