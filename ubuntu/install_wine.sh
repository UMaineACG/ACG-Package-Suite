#!/bin/bash
# Install WINE (Windows emulator)    
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install --install-recommends -y -f wine32 wine64 winetricks 
    winetricks
