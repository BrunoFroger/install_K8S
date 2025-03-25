#!/bin/bash

nomPod=$(kubectl -n ingress-nginx get pods | grep "demo-" | cut -d " " -f1)
kubectl cp index.html ingress-nginx/$nomPod:htdocs/index.html 