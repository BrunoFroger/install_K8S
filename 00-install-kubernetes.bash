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

read

#-------------------------------------------------
#echo "kubernetes => post-install linux"
. ./03-post-install-linux.bash
#-------------------------------------------------

read

#-------------------------------------------------
#echo "kubernetes => installation de docker"
. ./10-install-docker.bash
#-------------------------------------------------

read

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
. ./12-install-kubadm.bash
#-------------------------------------------------


#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
