#!/bin/bash -e

#creation du namespace popote
kubectl create namespace popote

# deployment du pod multicontaineur de popote
kubectl create deployment deployment-monopod.yaml -n popote

