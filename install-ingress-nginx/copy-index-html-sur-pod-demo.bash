#!/bin/bash

nomPod=$(kubectl get pods | grep "demo-" | cut -d " " -f1)
kubectl cp index.html ingress-nginx/$nomPod:htdocs/index.html 