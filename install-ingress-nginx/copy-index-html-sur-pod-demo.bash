#!/bin/bash

nomPod=$(kubectl get pods | grep "demo-" | cut -d " " -f1)
kubectl cp index.html $nomPod:httdocs/index.html