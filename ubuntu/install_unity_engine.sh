#!/bin/bash
# Unity game engine
# see https://forum.unity.com/threads/unity-on-linux-release-notes-and-known-issues.350256/
# for more info and possibly later versions
mkdir /tmp/ACG
cd /tmp/ACG
#

sudo apt install gconf-service lib32gcc1 lib32stdc++6 libasound2 libc6 libc6-i386 libcairo2 libcap2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libfreetype6 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libgl1-mesa-glx libglib2.0-0 libglu1-mesa libgtk2.0-0 libnspr4 libnss3 libpango1.0-0 libstdc++6 libx11-6 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxtst6 zlib1g debconf npm build-essentials
cd /tmp/ACG
#wget http://beta.unity3d.com/download/2b451a7da81d/unity-editor_amd64-2017.2.0xb6Linux.deb
wget https://beta.unity3d.com/download/dad990bf2728/UnitySetup-2018.2.7f1
chmod 755 UnitySetup*
./UnitySetup*
