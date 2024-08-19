#!/bin/bash -e
#exec > >(tee ./install_K8S.out.log) 2>./install_K8S.err.log

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================


#-------------------------------------------------
echo "kubernetes => initialisations debut"
source ./01-initialisations.bash -e
echo "kubernetes => initialisations fin"
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => post-install linux"
source ./03-post-install-linux.bash -e
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


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
