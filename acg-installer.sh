#!/bin/bash

# while-menu-dialog: a menu driven system information program

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

add_user() {
  exec 3>&1;
  username=$(dialog --inputbox "Please enter a username" 0 0 2>&1 1>&3);
  password=$(dialog --passwordbox "Please enter a password" 0 0 2>&1 1>&3);
  exec 3>&-;
  sudo useradd $username;
  echo "$username:$password" | sudo chpasswd;
  echo "startxfce4"| sudo tee /home/$USERNAME/.chrome-remote-desktop-session
  echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768"|sudo tee -a /home/$USERNAME/.bashrc
  echo "export TZ=America/New_York" | sudo tee -a /home/$USERNAME/.bashrc
}

install_software() {
  exec 3>&1;
  toInstall=$(dialog --checklist "Choose software:" 10 60 4 \
              "1" "Window Manager (xfce)" off \
              "2" "Remote Desktop (Chrome Remote Desktop)" off \
              "3" "Office Suite (Libreoffice)" off \
              "4" "USB IP (Connect USB devices to server)" off 2>&1 1>&3);
  exec 3>&-;
  for prog in $toInstall; do
    case $prog in
      1)
        sh /usr/local/bin/ACG-Package-Suite/install_xfce4_desktop.sh;;
      2)
        sh /usr/local/bin/ACG-Package-Suite/install_chrome_and_remote_desktop.sh;;
      3)
        sh /usr/local/bin/ACG-Package-Suite/install_usbip.sh;;
    esac
  done
}

while true; do
  exec 3>&1
  selection=$(dialog \
    --backtitle "UMaine ACG System Configurator of DOOM" \
    --title "Menu" \
    --clear \
    --cancel-label "Exit" \
    --menu "Please select:" $HEIGHT $WIDTH 4 \
    "1" "Add a user" \
    "2" "Install new software" \
    "3" "Update ACG Suite" \
    "4" "Reboot system" \
    2>&1 1>&3)
  exit_status=$?
  exec 3>&-
  case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
  case $selection in
    0 )
      clear
      echo "Program terminated."
      ;;
    1 )
      add_user;;
    2 )
      install_software;;
    3 )
      sh /usr/local/bin/ACG-Package-Suite/update_suite.sh;;
    4 )
      sudo reboot -i;;
  esac
done
