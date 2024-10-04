#!/bin/bash -e

namespace=$(kubectl config get-contexts |tail -1 | awk -F ' ' '{print $5}')

echo "le namespace actuel est : $namespace"
