#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       desinstallation de nginx ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_FRONTAL_NGINX_INSTALLED" == "X-OK" ]]; then

  echo "-------------------------------------------------"
  echo "arrêt de nginx ...."
  sudo systemctl stop nginx
  
  echo "-------------------------------------------------"
  sudo apt autoremove nginx -y
  echo " A FINALISER"

  echo "-------------------------------------------------"
  echo "desactivation firewall ...."
  sudo ufw disable

  echo "-------------------------------------------------"
  source set-bash-variable.bash K8S_FRONTAL_NGINX_INSTALLED=""
  echo "deinstallation de nginx => fin"
fi