#!/bin/bash

# cf doc : https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/

#creation du namespace grafana
kubectl create namespace my-grafana


kubectl apply -f grafana.yaml --namespace=my-grafana

