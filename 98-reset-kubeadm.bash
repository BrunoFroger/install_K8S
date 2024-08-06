#!/bin/bash


sudo kubeadm reset --pod-network-cidr=192.168.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock