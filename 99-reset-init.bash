#!/bin/bash -e

# script install-kubernetes 

# script initialisation 
unset K8S_SCRIPT_INITIALISATION
unset K8S_TYPE_NOEUD
unset K8S_MASTER_KUBERNETES

# script post install linux
unset K8S_SCRIPT_POST_INSTALL_LINUX

# srcipt install docker
unset K8S_SCRIPT_INSTALL_DOCKER

# srcipt install kubeadm
unset K8S_SCRIPT_INSTALL_KUBEADM
. ./98-reset-kubeadm.bash