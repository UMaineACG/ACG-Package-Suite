#!/bin/bash
#Google Chrome

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y ./google-chrome-stable_current_*.rpm
sudo rm google-chrome-stable_current_*.rpm