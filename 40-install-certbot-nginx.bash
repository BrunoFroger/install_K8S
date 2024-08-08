#!/bin/bash -e

echo "*************************************************"
echo "*"
echo "*       installation des certificats https (certbot) pour nginx"
echo "*"
echo "*************************************************"

echo "-------------------------------------------------"
echo "docker => Configuration mode sécurisé https"
sudo apt-get install certbot python3-certbot-nginx -y
sudo certbot --nginx -d popote.zapto.org