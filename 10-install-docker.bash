#!/bin/bash


echo "*************************************************"
echo "*"
echo "*       installation de docker ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_SCRIPT_INSTALL_DOCKER" == "X-OK" ]]; then
  echo "installation docker déjà réalisées"
else 

  echo "-------------------------------------------------"
  echo "docker => suppression ancienne version de docker"
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; 
  do 
      sudo apt-get remove $pkg; 
  done

  echo "-------------------------------------------------"
  echo "docker => ajout des cles GPG"
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "-------------------------------------------------"
  echo "docker => ajout des sources de repo pour docker"
  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  echo "-------------------------------------------------"
  echo "docker => installation de docker"
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "-------------------------------------------------"
  echo "docker => installation de cri-dockerd"
  sudo "wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.14/cri-dockerd_0.3.14.3-0.ubuntu-jammy_amd64.deb"
  sudo dpkg -i cri-dockerd_0.3.14.3-0.ubuntu-jammy_amd64.deb

  echo "-------------------------------------------------"
  export K8S_SCRIPT_INSTALL_DOCKER="OK"
  echo "installation de docker => fin"
fi
