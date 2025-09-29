#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       installation de nginx ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_FRONTAL_NGINX_INSTALLED" == "X-OK" ]]; then
  echo "installation nginx déjà réalisée"
else 

  echo "-------------------------------------------------"
  echo "installation de nginx ...."
  sudo apt install -y nginx

  echo "-------------------------------------------------"
  echo "activation firewall ...."
  sudo ufw --force enable

  echo "-------------------------------------------------"
  echo "activation de nginx ...."
  sudo sudo systemctl enable nginx
  sudo ufw allow 'Nginx HTTP'
  sudo ufw allow 'OpenSSH'



  echo "-------------------------------------------------"
  echo "creation page par defaut nginx ...."
  sudo mkdir /var/www/${K8S_DOMAINE}
  sudo chmod 755 /var/www/${K8S_DOMAINE}
  sudo mkdir /var/www/${K8S_DOMAINE}/html
  sudo chmod 755 /var/www/${K8S_DOMAINE}/html

  sudo -- sh -c "echo '<html>
        <head></head>
        <body>
        <h1>Bienvenue sur le cluster Kubernetes ${K8S_DOMAINE} </h1>
        </body>
        </html>
      ' > /var/www/${K8S_DOMAINE}/html/index.html"
  sudo chown -R www-data:www-data /var/www/${K8S_DOMAINE}

  sudo -- sh -c "echo 'server {

        listen 80;
        listen [::]:80;

        root /var/www/${K8S_DOMAINE}/html;

        index index.html;
        server_name ${K8S_DOMAINE} localhost;

        location / {
            try_files $uri $uri/ =404;
    }
    }' \
    > /etc/nginx/sites-available/${K8S_DOMAINE}"
  sudo chown -R www-data:www-data /etc/nginx/sites-available/${K8S_DOMAINE}
  sudo ln -s /etc/nginx/sites-available/${K8S_DOMAINE} /etc/nginx/sites-enabled/

  echo "-------------------------------------------------"
  echo "redemmarage nginx post config"
  sudo systemctl restart nginx
  
  echo "-------------------------------------------------"
  source set-bash-variable.bash K8S_FRONTAL_NGINX_INSTALLED="OK"
  echo "installation de nginx => fin"
fi