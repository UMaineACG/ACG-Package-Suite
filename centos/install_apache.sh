#!/bin/bash
#Apache Web Server
sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
# Start apache at boot
sudo chkconfig httpd on