#!/bin/bash

sudo apt-get install openjdk-11-jre openjdk-11-jdk
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment
source /etc/environment