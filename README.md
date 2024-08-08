# install_K8S (en construction)

# Présentation
Ce dépot est un exemple simpliste de ce qui peut etre fait pour créer un cluster Kubernetes (K8S).

# Pré-requis

Avant de vous lancer dans l'installation de votre cluster, voici quelques pré-requis :

- Avoir un minimum de connaissance dans les domaines suivants :
  - Réseau ()
  - Cloud (containerisation, virtualisation)
  - Développement logiciel (bash, ansible, ....)
- Disposer de 1 ou plusieurs machines qui serviront à l'expérimentation (noeuds), il est préférable d'avoir un minimum de 2 machines pour comprendre les notions de noeud et de répartition d'éxecution de process.
- disposer d'une connexion internet via un routeur (ex : Livebox)
- avoir un réseau local derriere ce routeur (prevoir un switch pour connecter les machines entre elles)
- le contenu de ces machines sera effacé définitivement (pensez a vos sauvegardes)
- une des machine sera considérée comme le maitre du cluster (master) et les autres comme esclaves (slaves)

# Etapes a réaliser avant de commencer a executer les scripts d'installation

Sur chacunes des machines :

- installer Linux (Ubuntu)
  - recuperer la distribution [ici](https://www.ubuntu-fr.org/download/) - flasher clé USB avec la distribution ; doc [ici](https://doc.ubuntu-fr.org/live_usb)  
  - brancher la machine cible sur le secteur  
  - raccorder 1 câble réseau sur le switch  
  - sélectionner boot sur clé USB dans le setup de la machine au démarrage  
  - démarrer ou redémarrer  
  - lancer l'installation  


paramètres à renseigner pour l'installation de linux :  

- sélectionner la langue (français)  
- sélectionner installer Ubuntu (écraser toute autre installation)
- valider clavier français (continuer)  
- pas de connexion réseau sans fil  
- mise à jour et autres logiciels : sélectionner installation minimale, avec téléchargement des mise à jour en cours d'installation  
- si une autre version était déjà installée la remplacer par la nouvelle  
- si demande changement sur les disques, valider  
- valider fuseau horaire sur Paris  
- renseignement "qui êtes-vous"
	- nom : exemple **master** ou **slave** suivant role de la machine  
  - nom ordinateur : exemple **K8Smaster** ou **K8SslaveXX** (XX numéro de la machine)  
  - nom utilisateur : exemple **master** ou **slave** 
  - password : exemple **K8S&master** ou **K8S&slave** 
- Lors du message installation terminée, retirer la clé USB et lancer le redémarrage.

Si lors de votre première connexion, la machine ne vous demande pas de mettre a jour le système ; 
il faudra forcer cette mise a jour globale après l'installation.
Pour cela ouvrez un terminal sur la machine et tapez les commandes suivantes :

```
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y openssh-server
```

creation de la cle ssh pour pouvoir se connecter a distance sur votre machine

A executer sur la machine cible

```
mkdir .ssh
cd .ssh
ssh-keygen -N "" -f id_rsa
service sshd restart
```

Executer ensuite sur la machine distante la commande suivante : ``ssh-copy-id <username>@<nomMachine.local>``

vous pouvez verifier que l'échange st opération si lorsque vous essayer de vous connecter en ssh depuis la machine distante sur votre noeud on ne vous demande plus de mot de passe (commande de connexion ``ssh <user>@<machine>``

# post-install

Pensez a verifier que la mise en veille de votre machine n'est pas activée (sinon, elle ne serait plus joignable) 

# Installation Kubernetes

Ces étapes peuvent etres faites en local sur la machine ou via une machine distante connectée en ssh
Vous pouvez alors récupérer les scripts d'installation en téléchargant la derniere release du projet :

```
cd ~
mkdir -p projets/install_K8S
cd projets/install_K8S
wget https://github.com/BrunoFroger/install_K8S/archive/tags/<version>.zip
unzip <version>>.zip
cd install_K8S-<version>.zip
```
ci dessus remplacer version par la version que vous voulez télécharger

# execution de l'installation 

Pour lancer l'installatipn de kubernetes sur votre/vos machine(s) vous devez executer les commandes suivantes 


```
cd ~/projets/install_K8S
. ./00install-kubernetes.bash
```

ce script vous demandera quelques informations :

- installation du master ou d'un esclave
- si installation d'un esclave il demandera le nom (ou adresse IP du master) si vous etes dans un reseau local derriere une livebox ou autre routeur du même genre, le nom devra peut etre complété par '.local' (ex master.local)
- entre chaque module, le script s'arrete pour vous demander de valider la suite

A la fin de l'execution de ces scripts, vus pouvez retrouver le resultat de l'excution dans les fichiers suivants :

- install_K8S.out.log => resultats des commandes executées
- install_K8S.err.log => erreurs rencontrées durant l'installation
