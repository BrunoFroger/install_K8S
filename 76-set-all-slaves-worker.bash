#!/bin/bash


slaves=$(kubectl get node | grep -v NAME | grep -v control-plane | cut -d ' ' -f 1 )
echo "liste des esclaves : ${slaves}"

for  slave in ${slaves} ; do

    echo "set ${slave} worker"
    kubectl label node ${slave} node-role.kubernetes.io/worker=worker

done
