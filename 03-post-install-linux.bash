#!/bin/bash -e

echo "*************************************************"
echo "*"
echo "*       post installation linux"
echo "*"
echo "*************************************************"
if [[ "X-$K8S_SCRIPT_POST_INSTALL_LINUX" == "X-OK" ]]; then
    echo "post installation linux déjà réalisée"
else 
    echo "-------------------------------------------------"
    echo "update/upgrade"
    sudo apt-get update | whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Mise à jours du système en cours ... " 15 90 0
    sudo apt-get -y upgrade| whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Mise à jours du système en cours ... " 15 90 0

    echo "-------------------------------------------------"
    echo "install tools"
    sudo apt install -y net-tools | whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Minstallation net-tools ... " 15 90 0
    sudo apt install -y inetutils-ping | whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Minstallation inetutils-ping ... " 15 90 0
    sudo apt install -y openssh-server | whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Minstallation openssh-server ... " 15 90 0
    sudo apt install -y wget | whiptail --clear --title "$titre" --backtitle "$titrearriere" --gauge "Minstallation wget ... " 15 90 0

    echo "-------------------------------------------------"
    source set-bash-variable.bash K8S_SCRIPT_POST_INSTALL_LINUX="OK"
    echo "post installation de linux => fin"
fi