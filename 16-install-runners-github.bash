#!/bin/bash


echo "*************************************************"
echo "*"
echo "*       installation des runners github ...."
echo "*"
echo "*************************************************"

if [[ "X-$K8S_RUNNERS_GITHUB" == "X-OK" ]]; then
  echo "installation runner github déjà réalisée"
else 
    # Create a folder
    mkdir ~/actions-runner && cd ~/actions-runner
    # Download the latest runner package
    curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz
    # Optional: Validate the hash
    echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | shasum -a 256 -c
    # Extract the installer
    tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz


    # configure runner
    # Create the runner and start the configuration experience
    ./config.sh --url https://github.com/BrunoFroger/popote_vueJS_K8S --token AFZAAFJ2I4AYF7S7OMMHGLTHBVBP4

    sudo ./svc.sh install && sudo ./svc.sh start

    echo "-------------------------------------------------"
    source set-bash-variable.bash K8S_RUNNERS_GITHUB="OK"
    echo "installation des runners github => fin"
fi