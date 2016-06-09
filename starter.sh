#!/bin/bash

# Stores the user who's password will be changed (based on OS)
user_to_change_pw="ubuntu"

# Check OS type and install git package
. /etc/lsb-release
OS=$DISTRIB_ID
if [ "$OS" == "Ubuntu" ]; then
  sudo apt-get update
  sudo apt-get install -f -y git
else
  user_to_change_pw="centos"
  sed -i.bak '/Defaults    requiretty/d' /etc/sudoers # Remove the requiretty flag so that sudo works
  sudo yum update -y
  sudo yum install -y git
fi


cd /usr/local/bin
sudo git clone https://github.com/UMaineACG/ACG-Package-Suite.git
export PATH=$PATH:/usr/local/bin/ACG-Package-Suite:/usr/local/bin/ACG-Package-Suite/$user_to_change_pw:/usr/games:/usr/local/games

# Randomly generate password across distro's
export PASSWORD=$(date +%s | sha256sum | base64 | head -c 15 ; echo)
echo "$user_to_change_pw:$PASSWORD" | sudo chpasswd
echo "Password for $user_to_change_pw has been set to $PASSWORD"

cd ACG-Package-Suite
echo PATH=\"$PATH\" | sudo tee /etc/environment
for SCRIPT in *.sh
   do sudo chmod 755 $SCRIPT;
done
echo "0 0 * * * /usr/local/bin/ACG-Package-Suite/update_suite.sh" | sudo crontab -
