#!/bin/bash
#USB IP (Connect USB to server)
sudo apt-get update
sudo apt-get install -y linux-image-generic
sudo apt-get install -y  linux-image-extra-$(uname -r)
sudo apt-get install -y linux-tools-common
sudo apt-get install -y linux-tools-$(uname -r)

