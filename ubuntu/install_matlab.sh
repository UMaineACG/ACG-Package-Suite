#!/bin/bash
#Matlab

check_for_key() {
  read -s -n 1 key
}

echo "This script was created based on the install procedure here"
echo "https://umaine.edu/it/software/"
printf "\nIf you have trouble you should check it out\n"
echo "Press any key to continue"
check_for_key
clear

echo "To install Matlab you must have an account with the mathworks."
echo "A web browser will take you to the site."
echo "You may either log in with an existing account or create a new one. When you are done, please close the window."
echo "Press any key to continue"
check_for_key
firefox https://www.mathworks.com/login
clear

echo "Now you must download Matlab. A web browser will open up to the download page. You need to download the Linux (64-bit) version, and make sure to click 'Save File'"
echo "You must sign in with your newly created account to download the installer. Once you have downloaded it, please close the browser window."
echo "Press any key to continue"
check_for_key
firefox http://www.mathworks.com/downloads/
clear

echo "The installer will now automatically install Matlab. When it completes, it will open up and you will have to sign in to complete the install."
echo "Press any key to continue"
check_for_key
mkdir ~/Downloads/matlab
unzip ~/Downloads/matlab*.zip -d ~/Downloads/matlab
sudo ~/Downloads/matlab/install
sudo apt-get install matlab-support
dialog --msgbox "Matlab installed" 5 20