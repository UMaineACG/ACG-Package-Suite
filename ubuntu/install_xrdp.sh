#!/bin/bash
#XRDP -- Remote Desktop

sudo apt-get install -y xrdp

for USER in /home/*
    do
        echo xfce4-session > $USER/.xsession
done

sudo service xrdp restart

sudo sed -i -e 's/port=-1/port=ask-1/g' /etc/xrdp/xrdp.ini #fun with regex
