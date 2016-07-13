#!/bin/bash
#MySQL
sudo yum update -y
sudo rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo yum install -y mysql-server