#!/bin/bash

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================


#-------------------------------------------------
echo "kubernetes => initialisations debut"
. ./01-initialisations.bash
echo "kubernetes => initialisations fin"
#-------------------------------------------------

read "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => post-install linux"
. ./03-post-install-linux.bash
#-------------------------------------------------

read "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => installation de docker"
. ./10-install-docker.bash
#-------------------------------------------------

read "appuyer sur une touche pour continuer"

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
. ./12-install-kubadm.bash
#-------------------------------------------------


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
