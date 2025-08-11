#!/bin/bash
#exec > >(tee ./install_K8S.out.log) 2>./install_K8S.err.log

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================

if [[ ! -d ~/bin ]]; then
    mkdir ~/bin
fi

if [[ $(env | grep PATH | grep ${HOME}/bin | wc -l ) -ne 1 ]]; then
    export PATH=${PATH}:${HOME}/bin
fi

cd tools
./cree-liens-tools.bash
cd ..

source ~/.bashrc

set-bash-variable.bash PATH=${PATH}:${HOME}/bin

#-------------------------------------------------
echo "kubernetes => initialisations debut"
source ./01-initialisations.bash -e
echo "kubernetes => initialisations fin"
#-------------------------------------------------

# echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => post-install linux"
source ./03-post-install-linux.bash -e
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => install nginx"
source ./15-install-nginx.bash -e
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => installation de docker"
source ./10-install-docker.bash
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
source ./12-install-kubeadm.bash
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => installation des runner github"
# source ./16-install-runners-github.bash
#-------------------------------------------------

#-------------------------------------------------
#echo "kubernetes => installation de l'Ingress-nginx-controler"
if [[ "X-$K8S_TYPE_NOEUD" == "master" ]]; then
    source ./18-install-ingress-nginx-controler.bash
fi
#-------------------------------------------------

#-------------------------------------------------
#echo "kubernetes => installation des applications"
if [[ "X-$K8S_TYPE_NOEUD" == "master" ]]; then
    source ./19-install-applications.bash
fi
#-------------------------------------------------


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
