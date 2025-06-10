#!/bin/bash 

echo "*************************************************"
echo "*"
echo "*       installation des applications"
echo "*"
echo "*************************************************"

echo "Test installation de Wiptail necessaire (interface graphique pour bash)"
testWhiptail=$(whiptail -v | cut -d " " -f 2)
if [[ "X-$testWhiptail" != "X-(newt):" ]]; then 
    sudo apt install -y whiptail
fi
applicationHelloNode=""
if [[ "X-$K8S_HELLO_NODE_INSTALLED" != "X-" ]] then 
    applicationHelloNode="installée"
fi 
applicationPopote=""
if [[ "X-$K8S_POPOTE_INSTALLED" != "X-" ]] then 
    applicationPopote="installée"
fi 

while :
do
    nomApplication=$(whiptail --menu "choisissez quelle application vous voulez installer : " 15 60 3 \
        "hello node" "$applicationHelloNode " \
        "popote" "$applicationPopote " \
        "quitter" "" \
        3>&1 1>&2 2>&3)

    if [[ "X-$nomApplication" != "X-" ]]; then
        if [[ "$nomApplication" == "quitter" ]]; then
            break;
        elif [[ "$nomApplication" == "hello node" ]]; then
            echo "installation de hello-node"
            applicationHelloNode="installée"
            source set-bash-variable.bash K8S_HELLO_NODE_INSTALLED="OK"
            slep 2

        elif [[ "$nomApplication" == "popote" ]]; then
            echo "installation de popote"
            applicationPopote="installée"
            source set-bash-variable.bash K8S_POPOTE_INSTALLED="OK"
            slep 2
        else
            echo "saisie incorrecte !"
        fi
    fi
done

source set-bash-variable.bash K8S_SCRIPT_INITIALISATION="OK"
echo "installation des applications => fin"

