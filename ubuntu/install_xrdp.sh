#!/bin/bash
#XRDP -- Remote Desktop

sudo apt-get install -y xrdp

for USER in /home/*
    do
        echo xfce4-session > $USER/.xsession
done

for DIR in /etc/xdg/xfce4/xfconf/xfce-perchannel-xml /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml /home/*/.config/xfce4/xfconf/xfce-perchannel-xml
    do
        FILE=$DIR/xfce4-keyboard-shortcuts.xml
        sudo cp $FILE $FILE.original
        sudo sed -i -e 's/<property name="\&lt;Super\&gt;Tab" type="string" value="switch_window_key"\/>/<property name="\&lt;Super\&gt;Tab" type="empty"\/>/' $FILE
done

sudo service xrdp restart

sudo sed -i -e 's/port=-1/port=ask-1/g' /etc/xrdp/xrdp.ini #fun with regex
