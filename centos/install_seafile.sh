#!/bin/bash
#Seafile Client

sudo cd /etc/yum.repos.d; sudo wget https://copr.fedoraproject.org/coprs/pkerling/seafile/repo/epel-7/pkerling-seafile-epel-7.repo
sudo yum install -y seafile-client-qt