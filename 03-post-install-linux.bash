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
    sudo apt-get update 
    sudo apt-get -y upgrade

    echo "-------------------------------------------------"
    echo "install tools"
    sudo apt install -y net-tools
    sudo apt install -y inetutils-ping
    sudo apt install -y openssh-server
    sudo apt install -y wget

    echo "-------------------------------------------------"
    source set-bash-variable.bash K8S_SCRIPT_POST_INSTALL_LINUX="OK"
    echo "post installation de linux => fin"
fi