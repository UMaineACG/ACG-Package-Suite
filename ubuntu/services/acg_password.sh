#!/bin/bash

#export PASSWORD=$(date +%s | sha256sum | base32 | head -c 8 ; echo)
export PASSWORD=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
echo "acg:$PASSWORD" | sudo chpasswd 
echo "Password for acg has been set to $PASSWORD" 
exit 0

