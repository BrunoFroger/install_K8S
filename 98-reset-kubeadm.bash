#!/bin/bash


sudo kubeadm reset --cri-socket=unix:///var/run/cri-dockerd.sock
sudo rm -r /etc/cni/net.d/