#!/bin/bash

#=================================================
echo "script d'installation de kubernetes => debut"
echo "(c) B.FROGER 2024"
#=================================================


#-------------------------------------------------
#echo "kubernetes => initialisations"
. ./01-initialisations.bash
#-------------------------------------------------

exit

#-------------------------------------------------
#echo "kubernetes => post-install linux"
. ./03-post-install-linux.bash
#-------------------------------------------------

exit

#-------------------------------------------------
#echo "kubernetes => installation de docker"
. ./10-install-docker.bash
#-------------------------------------------------

#-------------------------------------------------
#echo "kubernetes => installation de kubeadm"
. ./12-install-kubadm.bash
#-------------------------------------------------




#=================================================
echo "script d'installation de kubernetes => fin"
#=================================================
