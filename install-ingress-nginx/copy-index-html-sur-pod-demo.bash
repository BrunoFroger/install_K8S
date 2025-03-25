#!/bin/bash

nomPod=$(kubectl get pods | grep "demo-" | cut -d " " -f1)
kubectl -n ingress-nginx cp index.html $nomPod:htdocs/index.html 