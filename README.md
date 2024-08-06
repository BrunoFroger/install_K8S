# install_K8S

# Présentation
Ce dépot est un exemple simpliste de ce qui peut etre fait pour créer un cluster Kubernetes (K8S)

# Pré-requis

Avant de vous lancer dans l'installation de votre cluster, voici quelques pré-requis :

- Disposer de 1 ou plusieurs machines qui serviront à l'expérimentation (noeuds).
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
- sélectionner installer Ubuntu  
- valider clavier français (continuer)  
- pas de connexion réseau sans fil  
- mise à jour et autres logiciels : sélectionner installation minimale, avec téléchargement des mise à jour en cours d'installation  
- si une autre version était déjà installée la remplacer par la nouvelle  
- si demande changement sur les disques, valider  
- valider fuseau horaire sur Paris  
- renseignement "qui êtes-vous"
	- nom : exemple Bruno  
    - nom ordinateur : exemple master ou machineXX (XX numéro de la machine)  
    - nom utilisateur : exemple bruno  
    - password : exemple K8Smaster ou K8S&machineXX  (XX numéro de la machine)
- Lors du message installation terminée, retirer la clé USB et lancer le redémarrage.

Si lors de votre première connexion, la machine ne vous demande pas de mettre a jour le système ; 
il faudra forcer cette mise a jour globale après l'installation.
Pour cela ouvrez un terminal sur la machine et tapez lzq commandes suivantes :

```
sudo apt-get update
sudo apt-get -y upgrade
```

# Chargement des scripts d'installation


```
sudo apt-get install -y git
cd ~~
mkdir -p projets
cd projets
git clone git@github.com:BrunoFroger/install_K8S.git
```

Il vous faudra peut etre demander l'autorisation pour acceder a ce repo git (cle ssh publique a renseigner dans github)

# execution de l'installation 

Pour lancer l'installatipn de kubernetes sur votre/vos machine(s) vous devez executer les commandes suivantes 


```
cd ~/projets/install_K8S
. ./00install-kubernetes.bash
```

ce script vous demandera quelques informations :

- installation du master ou d'un esclave
- si installation d'un esclave il demandera le nom (ou adresse IP du master) si vous etes dans un reseau local derriere une livebox ou autre routeur du même genre, le nom devra etre complété par '.local' (ex master.local)
- entre chaque module, le script s'arrete pour vous demander de valider la suite


