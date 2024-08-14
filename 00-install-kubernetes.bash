#!/bin/bash -e
#exec > >(tee ./install_K8S.out.log) 2>./install_K8S.err.log

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================


#-------------------------------------------------
echo "kubernetes => initialisations debut"
. ./01-initialisations.bash -e
echo "kubernetes => initialisations fin"
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => post-install linux"
. ./03-post-install-linux.bash -e
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => installation de docker"
. ./10-install-docker.bash
#-------------------------------------------------

echo -n "appuyer sur une touche pour continuer "; read

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
. ./12-install-kubeadm.bash
#-------------------------------------------------


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
