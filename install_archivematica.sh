#!/bin/bash
sudo apt-get update
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:archivematica/1.4
sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y archivematica-storage-service
sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage
sudo ln -s /etc/uwsgi/apps-available/storage.ini /etc/uwsgi/apps-enabled/storage.ini
sudo service uwsgi restart
sudo service nginx restart

# Add repo for jhove dependency
sudo add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
sudo add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
sudo apt-get update

sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y jhove
sudo apt-get install -y archivematica-mcp-server
sudo apt-get install -y archivematica-mcp-client
sudo apt-get install -y archivematica-dashboard

sudo apt-get install -y elasticsearch
sudo update-rc.d elasticsearch defaults 95 10
sudo /etc/init.d/elasticsearch start

sudo rm -f /etc/apache2/sites-enabled/*default*
sudo wget -q https://raw.githubusercontent.com/artefactual/archivematica/stable/1.4.x/localDevSetup/apache/apache.default -O /etc/apache2/sites-available/default.conf
sudo ln -s /etc/apache2/sites-available/default.conf /etc/apache2/sites-enabled/default.conf
sudo /etc/init.d/apache2 restart
sudo freshclam
sudo /etc/init.d/clamav-daemon start
sudo /etc/init.d/elasticsearch restart
sudo /etc/init.d/gearman-job-server restart
sudo start archivematica-mcp-server
sudo start archivematica-mcp-client
sudo start fits

sudo restart gearman-job-server
