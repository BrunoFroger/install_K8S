#!/bin/bash

kubectl create namespace contour
change-namespace.bash contour

# Run the following to install Contour:
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml

#Verify the Contour pods are ready by running the following:

kubectl get pods -n projectcontour -o wide
