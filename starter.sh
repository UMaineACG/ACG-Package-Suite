#!/bin/bash

# Stores the user who's password will be changed (based on OS)
user_to_change_pw="ubuntu"

# Check OS type and install git package
. /etc/lsb-release
OS=$DISTRIB_ID
if [ "$OS" == "Ubuntu" ]; then
  sudo apt-get update
  sudo apt-get install -f -y git
  #Fix /etc/hosts entry for sudo to stop complaining
  newline="127.0.0.1 localhost $HOSTNAME"
  sudo sed -i.bak "1s/.*/$newline/" /etc/hosts
else
  user_to_change_pw="centos"
  sed -i.bak '/Defaults    requiretty/d' /etc/sudoers # Remove the requiretty flag so that sudo works
  sudo yum update -y
  sudo yum install -y git
fi

cd /usr/local/bin
sudo git clone https://github.com/UMaineACG/ACG-Package-Suite.git
export PATH=$PATH:/usr/local/bin/ACG-Package-Suite:/usr/local/bin/ACG-Package-Suite/$user_to_change_pw:/usr/games:/usr/local/games

cd ACG-Package-Suite
echo PATH=\"$PATH\" | sudo tee /etc/environment
for SCRIPT in *.sh
   do sudo chmod 755 $SCRIPT;
done
echo -e "0 0 * * * /usr/local/bin/ACG-Package-Suite/update_suite.sh\n@reboot /usr/local/bin/ACG-Package-Suite/update_suite.sh &" | sudo crontab -


# Delete the default ubuntu user
if [ "$OS" == "Ubuntu" ]; then
  killall -9 -u $user_to_change_pw
  deluser --remove-home $user_to_change_pw
else
  sudo yum install -y psmisc
  killall -9 -u $user_to_change_pw
  userdel --remove $user_to_change_pw
fi
printf "acg\nacgrocks" | /usr/local/bin/ACG-Package-Suite/$user_to_change_pw/add_a_user.sh
export PASSWORD=$(date +%s | sha256sum | base64 | head -c 8 ; echo)
echo "acg:$PASSWORD" | sudo chpasswd
echo "Password for acg has been set to $PASSWORD"

cp /usr/local/bin/ACG-Package-Suite/ubuntu/services/acg_password_change.service /etc/systemd/system
systemctl enable acg_password_change.service

