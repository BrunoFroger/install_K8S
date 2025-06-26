#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       desinstallation de nginx ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INSTALL_NGINX" == "X-OK" ]]; then
else 
  echo "docker n'est pas installé"

  echo "-------------------------------------------------"
  echo "arrêt de nginx ...."
  sudo systemctl stop nginx
  
  echo "-------------------------------------------------"
  echo " A FINALISER"


  echo "-------------------------------------------------"
  source set-bash-variable.bash K8S_SCRIPT_INSTALL_NGINX=""
  echo "deinstallation de nginx => fin"
fi