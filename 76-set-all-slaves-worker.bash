#!/bin/bash


slaves=$(kubectl get node | grep -v NAME | grep -v control-plane | cut -d ' ' -f 1 )
echo "liste des esclaves : ${slaves}"