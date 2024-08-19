#!/bin/bash -e


if [[ "X-$K8S_TYPE_NOEUD" == "X-master" ]]; then
    echo "installation du noeud master ... "
    sudo kubeadm init --pod-network-cidr=192.168.0.0/16 \
    --cri-socket=unix:///var/run/cri-dockerd.sock \
    > >(tee ./kubeadm-init.out.log) 2>./kubeadm-init.err.log
    echo "*******************************************************"
    echo "                                                      *"
    echo "          A T T E N T I O N                           *"
    echo "                                                      *"
    echo "* les informations pour connecter un noued a ce       *"
    echo "* cluster sont dans le fichier kubeadm-init.out.log   *" 
    echo " ne pas effacer ce fichier .....                      *" 
    echo "*******************************************************"
elif [[ "X-$K8S_TYPE_NOEUD" == "X-slave" ]]; then
    echo "installation d'un noeud esclave ... "
    while :
    do
        echo "saisie de l'adresse et port du master (format xxx.xxx.xxx.xxx:nnnn) (voir avant derniere ligne du fichier kubeadm-init.out.log sur master) : <${addr-master>} "
        read addr-master
        echo "executer la cde 'kubeadm token create' sur le master et copier le token ici (exemple : n8o17f.h4r3qlkfuibkl2gd ): <${option-token}> "
        read option-token
        echo "saisissez l'option '--discovery-token-ca-cert-hash=sha256:......' de kubeadm join donnée lors de la création du master (derniere ligne du fichier kubeadm-init.out.log sur master) : <${option-cert-hash} "
        read option-cert-hash
        cde-join="sudo kubeadm ${addr-master} --token ${option-token} --discovery-token-ca-cert-hash ${option-cert-hash} --cri-socket=unix:///var/run/cri-dockerd.sock"
        echo "Voici la commande qui va etre executer : "
        echo $cdeJoin
        echo "est ce correct ? (o/N)"
        read valid
        if [[ "$X-valid" == "X-o" ]] ; then
            break
        fi
    done
        $(cdeJoin)
else
    echo "type de noeud ($K8S_TYPE_NOEUD) inconnu"
fi

result=$?
#echo "le resultat de la commande est $result"
if [[ "$result" == "0" ]]; then
    echo "commande init/join executée avec succès .... on continue"
else
    echo "commande init/join en erreur .... que faire ?"
    echo -n "Appuyer sur une touche pour continuer ou ^C pour arreter : "; read
fi