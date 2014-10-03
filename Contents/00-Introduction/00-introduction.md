# Introduction {#quickstart:744282c8-96a2-44da-8daf-e68ae60b5960}

## Présentation et objectif {#quickstart:a11031ce-6591-46fa-b005-fb757717dd53}

Ce document est le tutoriel de la plateforme Dynacase. 

Il contient un projet fictif mettant en œuvre les principales fonctionnalités de la plateforme.

Une fois le tutoriel complété, vous saurez :

-   Gérer des utilisateurs via la plateforme :
    -   Ajouter / Désactiver des utilisateurs,
    -   Mettre en place une structure de groupe,
    -   Créer des rôles applicatifs.
-   Construire des familles Dynacase qui permettent de mettre en place un système riche et évolutif pour la génération de formulaire et la persistance des données :
    -   Créer des familles et utiliser le mécanisme d'héritage,
    -   Paramétrer les formulaires et customiser leur mise en forme,
    -   Ajouter du code métier au formulaire,
    -   Gérer la sécurité par document et les visibilités par élément de formulaire,
    -   Utiliser les documents pour produire des sorties bureautique,
    -   Internationaliser les formulaires.
-   Construire des cycles de vie
    - Mettre en forme un cycle de vie,
    - Mettre en place des droits par étapes,
    - Ajouter des alertes et des relances,
    - Internationaliser les cycles de vie.
-   Construire des applications :
    - Mettre en place une application d'export de données,
    - Créer une interface de consultation spécifique,
    - Gérer la sécurité des applications / actions,
    - Internationaliser les applications.
-   Packager
    - Créer des packages pour faciliter le déploiement,
    - Créer des scripts pour gérer les mises à jour.

[Anakeen][anakeen_services] propose des prestations de formation à l'utilisation de la plateforme Dynacase.  
Ces formations, d'une durée de 5 jours en standard, permettent d'aborder les points de ce tutoriel.  
Elles peuvent aussi être adaptées pour aborder des thèmes non présentés dans ce document.
Elles alternent parties théoriques et applications pratiques. Les parties pratiques s'appuient sur un projet standard
ou peuvent être basées sur votre propre projet.  
Elles se déroulent en inter entreprise sur Paris ou Toulouse ou en intra sur votre site.

## Organisation {#quickstart:f6b3c074-0249-4a60-bbb2-0778b6a8778b}

Ce tutoriel est organisé en 5 chapitres principaux :

-   [Mise en place du contexte de développement][chapter_dev],
-   [Comptes (Utilisateur, Rôles et Groupes)][chapter_account],
-   [Familles / Documents][chapter_fam],
-   [Cycles de vie][chapter_wfl],
-   [Applications / Actions][chapter_action].

Il permet d'avoir une vue d'ensemble des fonctionnalités de Dynacase.

Chaque chapitre est composé de sous chapitres. Un sous chapitre est écrit pour pouvoir être parcouru et compris en **2 heures**.

L'[annexe][chapter_annexe] résume quelques points clefs.

## Au secours

Pour trouver des aides sur la réalisation du tutorial vous pouvez utiliser le [forum Dynacase][forum_dynacase].
Le forum **Quick Start** a été créé à cet effet.

D'autre part, si vous avez des remarques ou si vous souhaitez compléter ce tutorial, vous pouvez les soumettre via [Github][quickstart_repo].

## Contexte Fonctionnel {#quickstart:1b340f92-085a-4bbe-a866-47e17444ca51}

Vous êtes nouvellement embauché au sein du service informatique de la société [COGIP][COGIP].

Dans le cadre de son activité la COGIP a mis en place une démarche qualité.  
Cette démarche consiste en l'expertise annuelle de ses différents sites de production par une équipe
d'auditeurs internes dans le but de vérifier que les processus qualité sont bien appliqués.  

L'année précédente la COGIP a connu une très forte croissance qui a abouti à l'ouverture de 42 nouvelles usines de
production en complément des 48 existantes.  
La mise en place et le suivi des audits qualité est devenu une tâche plus importante et plus complexe que précédemment.
L'équipe du service qualité est arrivée au constat que l'espace partagé contenant quelques tableaux Excel et l'envoi de
mail ne permettent plus de suivre efficacement le déroulement des audits.
Le responsable du service qualité a donc demandé à la DSI de mettre en place rapidement une solution permettant de
planifier et de suivre le déroulement de la phase d'audit.

Suite à une phase d'analyse menée conjointement par la DSI et le service qualité, plusieurs éléments sont apparus :

-   l'outil doit être sur le réseau interne pour pouvoir être accessible en temps réel à partir du siège et de toutes les usines,
-   l'outil doit être intuitif, les auditeurs ne réalisant que 2 ou 3 audits par an,
-   l'outil doit apporter en temps réel un suivi des audits planifiés, réalisés, en cours ainsi qu'un suivi du traitement des non conformités,
-   l'outil doit produire pour chaque audit un rapport (fichier PDF).

La DSI a donc comparé quelques outils existants sur le marché et a décidé d'utiliser Dynacase pour développer
en interne la logique métier propre au service qualité.

Votre responsable hiérarchique vous a donc confié ce développement. Vous avez 1 mois pour réaliser et mettre en production l'outil.

<!-- links -->
[anakeen_services]: http://anakeen.com/#services
[COGIP]: http://fr.wikipedia.org/wiki/COGIP
[chapter_dev]: #quickstart:354d4c0e-3386-47fb-b79c-4ea19e3cd5d9
[chapter_account]: #quickstart:7c5b312e-42cf-44e2-b68f-9ddce9b48d71
[chapter_fam]: #quickstart:f43b95f5-71d4-4c40-bd28-3fff24a3261f
[chapter_wfl]: #quickstart:64fac308-94ce-4717-96c7-56e2336c7791
[chapter_action]: #quickstart:3e7da180-3454-4344-a8a1-73f958365aa5
[chapter_annexe]: #quickstart:f032dd5b-a7dc-47f7-b216-6a973a447dfd
[forum_dynacase]: http://forum.dynacase.org/
[quickstart_repo]: https://github.com/Anakeen/dynacase-quick-start