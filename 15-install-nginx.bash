#!/bin/bash -e


echo "*************************************************"
echo "*"
echo "*       installation de nginx ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INSTALL_NGINX" == "X-OK" ]]; then
  echo "installation nginx déjà réalisées"
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


  echo "-------------------------------------------------"
  echo "creation page par defaut nginx ...."
  sudo mkdir /var/www/k8sbfr.zapto.org
  sudo chmod 755 /var/www/k8sbfr.zapto.org

  sudo -- sh -c 'echo "<html>
        <head></head>
        <body>
        <h1>Bienvenue surle cluster Kubernetes k8sbfr </h1>
        </body>
        </html>
        " > /var/www/k8sbfr.zapto.org/html/index.html'
  sudo chown -R www-data:www-data /var/www/k8sbfr.zapto.org

  sudo -- sh -c 'echo "server {

        listen 80;
        listen [::]:80;

        root /var/www/k8sbfr.zapto.org/html;

        index index.html;
        server_name k8sbfr.zapto.org localhost;

        location / {
            try_files $uri $uri/ =404;
    }
    }" \
    > /etc/nginx/sites-available/k8sbfr.zapto.org'
  sudo ln -s /etc/nginx/sites-available/k8sbfr.zapto.org /etc/nginx/sites-enabled/

  echo "-------------------------------------------------"
  echo "redemmarage nginx post config"
  sudo systemctl restart nginx
  
  echo "-------------------------------------------------"
  source set-bash-variable.bash K8S_SCRIPT_INSTALL_NGINX="OK"
  echo "installation de nginx => fin"
fi