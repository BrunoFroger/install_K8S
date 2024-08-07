#!/bin/bash -e

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================


#-------------------------------------------------
echo "kubernetes => initialisations debut"
. ./01-initialisations.bash -e
echo "kubernetes => initialisations fin"
#-------------------------------------------------

read -p "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => post-install linux"
. ./03-post-install-linux.bash -e
#-------------------------------------------------

read -p "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => installation de docker"
. ./10-install-docker.bash
#-------------------------------------------------

read -p "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
. ./12-install-kubeadm.bash
#-------------------------------------------------


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
