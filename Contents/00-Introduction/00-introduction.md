# Introduction {#quickstart:744282c8-96a2-44da-8daf-e68ae60b5960}

## Présentation et objectif {#quickstart:a11031ce-6591-46fa-b005-fb757717dd53}

Ce document présente un quick start pour la plateforme Dynacase. 

Il contient un projet fictif contenant les principales fonctionnalités de la plateforme.

Une fois le tutoriel complété, vous saurez :

* Gérer des utilisateurs via la plateforme :
    * Ajouter/ Désactiver des utilisateurs,
    * Mettre en place une structure de groupe,
    * Créer des rôles applicatifs
+ Construire des familles Dynacase qui permettent de mettre en place un système de formulaires et de persistances riche et évolutif :
    + Créer des familles et utiliser le mécanisme d'héritage,
    + Paramétrer les formulaires et customiser leur mise en forme,
    + Ajouter du code métier au formulaire,
    + Gérer la sécurité (CRUD) par document et les visibilités par élément de formulaire,
    + Utiliser les documents pour produire des sorties bureautique,
    + Internationaliser les formulaires.
* Construire des cycles de vie
    - Mettre en forme un cycle de vie,
    - Mettre en place des droits par étapes,
    - Ajouter des alertes et des relances,
    - Internationaliser les cycles de vie.
* Construire des applications :
    - Mettre en place une application d'export de données,
    - Créer une interface de consultation spécifique,
    - Gérer la sécurité des applications/actions,
    - Internationaliser les applications.
* Packager
    - Créer des package pour faciliter le déploiement,
    - Créer des scripts pour gérer les mise à jour.

De plus, [Anakeen](http://anakeen.com/#services) propose des prestations de formation à l'utilisation de la plateforme Dynacase.  
Ces formations d'une durée de 5 jours permettent d'aborder les points de ce quick start ou des points avancés non présentés dans ce document.  
Elles peuvent prendre pour thème un projet que vous désirez réaliser ou un projet standard et se dérouler en région parisienne ou sur site.

## Organisation {#quickstart:f6b3c074-0249-4a60-bbb2-0778b6a8778b}

Ce quick start est organisé en quelques chapitres principaux :

* Mise en place du contexte de développement,
* Utilisateurs,
* Famille/Document,
* Cycle de vie,
* Application/Action,
* Déploiement.

Il permet d'avoir une vue d'ensemble des fonctionnalités de Dynacase Platform.

Chaque chapitre est composé de sous chapitres, un sous chapitre est écrit pour pouvoir être parcouru et compris en **2 heures**.

De plus, les chapitres sont rédigés de manière à réduire les dépendances entre eux de façon à ce que l'ordre d'exécution du tutoriel ne soit pas imposé, toutefois nous vous conseillons de suivre l'ordre du sommaire.

## Contexte Fonctionnel {#quickstart:1b340f92-085a-4bbe-a866-47e17444ca51}

Vous êtes nouvellement embauché au sein du service informatique de la société [COGIP](http://fr.wikipedia.org/wiki/COGIP).  

Dans le cadre de son activité la COGIP a mis en place une démarche qualité.  
Cette démarche consiste en l'expertise annuelle de ses différents sites de production par un ensemble d'auditeurs internes dans le but de vérifier que 
les processus qualités sont bien appliqués.  

L'année précédente la COGIP a connu une très forte croissance qui a aboutit à l'ouverture de 42 nouvelles usines de production en complément des 48 existantes.  
La mise en place et le suivi des audits qualité est devenu une tâche 
plus importante et plus complexe que précédemment. L'équipe du service qualité est arrivé au constat que l'espace partagé contenant quelques tableaux excel et l'envoi de mail ne permet plus comme auparavant de suivre efficacement le déroulement des audits.
Le responsable du service qualité a donc demandé à la DSI de mettre en place rapidement une solution permettant de planifier et de suivre le déroulement de la phase d'audit.

Suite à une phase d'analyse menée conjointement par la DSI et le service qualité, plusieurs éléments sont apparus :

* l'outil doit être sur le réseau interne pour pouvoir être accessible en temps réel à partir du siège et de toutes les usines,
* l'outil doit être intuitif les auditeurs ne réalisant que 2 ou 3 audits par an,
* l'outil doit apporter en temps réel un suivi des audits planifiés, faits, en cours ainsi que des non conformités,
* l'outil doit produire par audit un PDF résumant l'audit.

La DSI a donc audité quelques outils existant sur le marché et a décidé de sélectionner Dynacase Platform et de développer en interne la logique métier propre au service qualité.

Votre responsable hiérarchique vous a donc assigné la tâche de mener à bien ce développement, vous avez 1 mois pour réaliser et mettre en production l'outil.