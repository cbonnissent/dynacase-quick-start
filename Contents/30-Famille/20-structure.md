# Mise en place des structures {#quickstart:3b64d38f-81aa-4c02-aad5-77271247bf15}

Ce chapitre va vous permettre d'initialiser vos premières familles.

## Objectifs {#quickstart:a17c7d35-e9ba-47a4-9b0f-2919d6926966}

* Créer une famille de base,
* Créer les familles en utilisant l'héritage,
* Initialiser les attributs,
* Initialiser les [stubs][Method_stub],
* Faire une première traduction,
* Déployer votre module.

## Cadre {#quickstart:c77a23ec-d38d-4ada-8a99-8b5124297770}

L'analyse des besoins a montré que votre application nécessite les familles suivantes :

Référentiel qualité
:   elle représente un référentiel qualité et contient :
    
    -   la désignation d'un référentiel qualité.

Chapitre de référentiel
:   elle représente un chapitre et contient :
    
    -   un lien à un référentiel,
    -   un titre.

Audit
:   elle représente un audit et contient :
    
    -   le titre de l'audit,
    -   sa date de début,
    -   sa durée en jours,
    -   sa date de fin,
    -   le site audité,
    -   un champ descriptif,
    -   le responsable de l'audit,
    -   la liste des auditeurs,
    -   une liste de référentiels,
    -   une liste de points forts, avec pour chacun :
        -   un encart de texte,
    -   une liste de points faibles, avec pour chacun :
        -   un encart de texte,
    -   une liste de fiches de non-conformité,
    -   une liste de fichiers associés.

Fiche de non-conformité
: elle représente une non-conformité et contient :
    
    -   le titre de la non-conformité,
    -   un lien vers la fiche d'audit,
    -   un rédacteur,
    -   une liste de liens vers des chapitres de référentiel, avec pour chacun :
        -   un lien vers le référentiel,
        -   un lien vers le chapitre,
        -   un texte explicitant le manquement,
    -   une liste d'actions, avec pour chacune :
        -   un descriptif,
        -   un responsable,
        -   une date de prise en compte.

## Partie théorique {#quickstart:75dc2bf5-ae31-434e-a538-96ad9c52967f}

### Structure de famille {#quickstart:652fd302-fef6-4335-bea8-e26a60759537}

La structure d'une famille est définie par deux éléments :

le fichier de structure
: il contient la liste des attributs (type de données) que les documents de la famille contiennent,

l'héritage
: si une famille hérite d'une autre, elle hérite de manière dynamique de tous les éléments de ses familles parentes.

La structure de la famille est utilisée en interne par Dynacase pour :

* créer la table de la base de données permettant de stocker les données,
* générer les formulaires de saisie des données,
* générer les formulaires de recherche de documents,
* générer les matrices de gestion de droits,
* générer les stubs,
* etc.

## Création de votre première famille : Famille de base {#quickstart:d16313a5-1ae6-422a-9f45-8d721aafcd18}

À la liste des familles identifiées de manière fonctionnelle, nous allons ajouter une famille dite _de base_,
dont toutes les familles de l'application hériteront.
Cette méthode est  une bonne pratique pour débuter un projet Dynacase.
Ceci permet de propager plus facilement des comportements spécifiques entre toutes les familles d'un projet.

Par exemple, si vous souhaitez empêcher la duplication de tous les documents au sein de votre projet,
vous pouvez le spécifier au niveau de la famille mère et le comportement est transmis à toutes les familles filles.  
De même, comme nous le verrons plus tard, cela permet de mettre en place une vue commune à toutes ces familles.

Ouvrez une console et rendez vous dans le répertoire de votre application et lancez la commande suivante :

    <devtool> createFamily -s . -n COGIP_AUDIT_BASE -m COGIP -a COGIP_AUDIT

La commande createFamily permet de créer des familles Dynacase. La liste de ses options est accessibles avec l'option --help.

Les options utilisées ci dessus sont :

* `-s` : emplacement des sources (dans notre exemple le répertoire courant),
* `-n` : nom logique de la famille,
* `-m` : namespace de la famille,
* `-a` : application contenant la famille.

Les fichiers suivants sont générés :

    ├ COGIP_AUDIT
      ├─ COGIP_AUDIT_BASE__CLASS.php
      ├─ COGIP_AUDIT_BASE__PARAM.csv
      └─ COGIP_AUDIT_BASE__STRUCT.csv

Les fichiers ci-dessus sont pré-remplis et prêts à être utilisés. Leur nomenclature est explicitée dans l'[annexe][annexe].

Vous devez maintenant indiquer dans le fichier `info.xml` que cette famille doit être importée lors de l'initialisation
et la mise à jour. Vous allez ajouter les lignes suivantes :

    [xml]
    <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
    <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__PARAM.csv --csv-separator=&apos;;&apos; '/>

<span class="flag inline nota-bene"></span> Ces deux lignes vous sont retournées par la commande de création des fichiers.

à 2 endroits :

* dans la partie d'initialisation, après l'import des utilisateurs
* dans la partie d'upgrade, après le `record_application`. 

Vous devez avoir un fichier `info.xml` semblable à :

    [xml]
    <post-install>
        <process command="programs/record_application COGIP_AUDIT" />
        <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/ROLE__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IGROUP__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IUSER__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__PARAM.csv --csv-separator=&apos;;&apos;'/>
        <process command="programs/update_catalog" />
    </post-install>
    
    <post-upgrade>
        <process command="programs/pre_migration COGIP_AUDIT" />
        <process command="programs/record_application COGIP_AUDIT" />
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COPGIP_AUDIT_BASE__PARAM.csv --csv-separator=&apos;;&apos;'/>
        <process command="programs/post_migration COGIP_AUDIT" />
        <process command="programs/update_catalog" />
    </post-upgrade>

## Création des fichiers de familles {#quickstart:72980b93-3f1f-4aa0-b12d-756e072f2029}

Vous allez maintenant créer les autres familles, reprenez la ligne de commande ci-dessus pour chacune des familles présentées ci-dessous.

-   `Référentiel qualité` : `<devtool> createFamily -s . -n COGIP_AUDIT_REFERENTIEL -p COGIP_AUDIT_BASE -m COGIP -a COGIP_AUDIT`
-   `Chapitre` : `<devtool> createFamily -s . -n COGIP_AUDIT_CHAPITRE -p COGIP_AUDIT_BASE -m COGIP -a COGIP_AUDIT`
-   `Audit` : `<devtool> createFamily -s . -n COGIP_AUDIT_AUDIT -p COGIP_AUDIT_BASE -m COGIP -a COGIP_AUDIT`
-   `Fiche de non-conformité` : `<devtool> createFamily -s . -n COGIP_AUDIT_FNC -p COGIP_AUDIT_BASE -m COGIP -a COGIP_AUDIT`

Vous avez créé l'ensemble des fichiers qui vont définir vos familles. 

Il faut maintenant les référencer dans le fichier `info.xml`. Pour ce faire, vous devez respecter l'ordre de l'héritage
et importer les familles mères puis les familles filles.
Si vous ne suivez pas un ordre adéquat, l'installeur refusera d'installer le paquet et vous indiquera le problème.

Votre `info.xml` contient les lignes suivantes :

    [xml]
    <post-install>
        <process command="programs/record_application COGIP_AUDIT"/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command="programs/update_catalog"/>
    </post-install>
    <post-upgrade>
        <process command="programs/pre_migration COGIP_AUDIT"/>
        <process command="programs/record_application COGIP_AUDIT"/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv --csv-separator=&apos;;&apos; '/>
        <process command='./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv --csv-separator=&apos;;&apos; '/>
        <process command="programs/post_migration COGIP_AUDIT"/>
        <process command="programs/update_catalog"/>
    </post-upgrade>

Vous pouvez retrouver l'ensemble de ces fichiers initialisés dans les [sources du chapitre complété][tuto_after_30_20].

## Ajout des attributs {#quickstart:dfb226d3-2b6d-45a2-b5de-7a671186247b}

Vous allez maintenant définir les [attributs][DocAttribut] contenus dans vos familles.

### Référentiel qualité {#quickstart:f8d481f6-4be2-457c-a7e3-96165fbf4cf9}

Vous allez commencer par la famille `Référentiel qualité`. Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv`.

Le fichier se présente sous cette forme :

![ Contenu structure site ](30-20-structure-referentiel.png "Contenu structure site")

<span class="flag inline nota-bene"></span> Dans cette capture d'écran, vous remarquez que le fichier est coloré.
Vous pouvez obtenir ce comportement (ainsi que d'autres aides) en suivant l'[annexe][annexeColor].
Dans la suite du tutoriel, ces scripts sont considérés comme installés.

<span class="flag inline nota-bene"></span> **Attention** : un attribut non-structurant (_texte_, _relation_, _numérique_, …)
doit obligatoirement être contenu dans un attribut structurant _frame_ ou _array_.

Pour définir un attribut, vous devez saisir :

1.  dans la colonne `A` : le mot clef `ATTR` ;
2.  dans la colonne `B` : l'identifiant unique de l'attribut,
    celui-ci est alphanumérique et écrit de préférence en minuscules ;
3.  dans la colonne `C` : l'attribut encadrant de l'attribut en cours
    (cet élément est nécessaire pour les attributs non-structurants,
    c'est à dire les attributs qui contiennent des données, text, int, etc.) ;
4.  dans la colonne `D` : la valeur de traduction par défaut du label de l'attribut,
5.  dans la colonne `E` : `Y` ou `N` selon que l'attribut est utilisé pour composer le titre ou non
6.  dans la colonne `G` : le [type][DocAttribut] de l'attribut,
7.  dans la colonne `H` : l'ordre d'affichage des attributs.
    Cet élément est utile dans le cas d'héritage entre famille,
    il permet de dire dans quel ordre doivent être affichés les attributs ;
8.  dans la colonne `I` : la [visibilité][DocVisibilite] par défaut de l'attribut.

Dans le cas des `Référentiel qualité`, vous devez obtenir une structure similaire à :

![ Contenu structure référentiel ](30-20-structure-referentiel-done.png "Contenu structure référentiel")

<span class="flag inline nota-bene"></span> Quelques astuces pour faciliter l'écriture des familles :

-   il est préférable de composer les noms d'attributs de la manière suivante :
    -   un préfixe pour indiquer leur famille de provenance (utile dans le cas d'un héritage),
    -   une lettre pour indiquer le type d'encadrant lorsque l'attribut est en encadrant (`f` pour frame, `a` pour array, `t` pour tab),
    -   un nom explicitant l'information portée par l'attribut.
    
    Ce qui donne, par exemple : `fam_f_general`

-   dans le cas particulier des tableaux, la composition suivante est conseillée :
    -   le nom du tableau (sans le `a`),
    -   un nom explicitant l'information portée par l'attribut.
    
    Ce qui donne, par exemple : `fam_a_fichiers`, puis `fam_fichiers_file` et `fam_fichiers_commentaire`

-   vous pouvez commencer en complétant uniquement les colonnes `A`, `B`, `D`, `G` puis au moyen des scripts décrits en [annexe][annexeColor].

Vous pouvez voir ci-dessous un exemple de construction sur la famille chapitre.

![ Exemple de construction ](30-20-structure-completion.gif "Exemple de construction")

Vous pouvez retrouver le [fichier complété dans les sources][tuto_audit_ref].

### Chapitre {#quickstart:db00ea11-3c9a-4a99-8879-af61e8ad2745}

Vous allez maintenant compléter la famille `chapitre`.
Cette famille contient un lien vers son référentiel, de manière a pouvoir retrouver facilement tous les chapitres d'un référentiel.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv`, et complétez-le pour obtenir une structure similaire à :

![ Contenu structure Chapitre ](30-20-structure-chapitre.png "Contenu structure Chapitre")

Vous pouvez remarquer la présence d'un nouveau type d'attribut [docid][DocDocid].
Ce type d'attribut référence un document et permet de créer des liens entre les fiches. Il est présenté :

-   en édition : sous la forme d'une liste déroulante qui vous permet de choisir le document à lier,
-   en consultation : sous la forme d'un lien hypertext pointant vers le document lié.

Dans la définition du `docid`, la référence à la famille `Référentiel` indique la nature du lien,
et permet de n'afficher en édition que les documents issus de cette famille.

Vous pouvez retrouver le [fichier complété dans les sources][tuto_audit_chapitre].

### Fiche de non-conformité {#quickstart:6bc0b33f-c7a9-4b20-b940-8d939c3b97ec}

Vous allez maintenant compléter la `Fiche de non-conformité`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv`, et complétez le pour obtenir une structure similaire à :

![ Contenu structure FNC ](30-20-structure-fnc.png "Contenu structure FNC")

Vous pouvez remarquer la présence de deux nouveaux éléments structurants :

-   [array][DocArray] : un `array` permet de gérer la multiplicité d'une liste d'attributs (un n-uplet) :
    chaque attribut est matérialisé par une colonne, et chaque ligne porte une valeur du n-uplet (liste des valeurs unitaires des attributs),
-   [tab][DocTab] : un `tab` est représenté sous la forme d'un onglet dans le formulaire.
    Il permet d'organiser les informations à présenter, d'avoir une présentation plus lisible et éviter des formulaires trop long.

Vous pouvez retrouver le [fichier complété dans les sources][tuto_audit_fnc].

### Audit {#quickstart:b2eccdab-bbda-4d80-86a7-dd5e6cdb22dc}

Vous allez maintenant compléter votre dernière famille, la `Fiche d'audit`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv`, et complétez le pour obtenir une structure similaire à :

![ Contenu structure Audit ](30-20-structure-audit.png "Contenu structure Audit")

**Attention** : Dans la spécification, il est indiqué que l'audit porte plusieurs référentiels. Vous devez donc ajouter
dans la colonnes `options` (`P`), l'option `multiple=yes`. 

Vous pouvez retrouver le [fichier complété dans les sources][tuto_audit_audit].

Bravo ! Vous avez initialisé l'ensemble des familles.

## Génération des stubs {#quickstart:df9b59b1-3a7f-420b-a89d-36cd6894edb9}

Vous allez maintenant produire les stubs. Ce sont des fichiers PHP qui sont générés pour aider au développement de l'application.

Si vous ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php`, vous avez le contenu suivant :

    [php]
    namespace Cogip;
    use \Dcp\AttributeIdentifiers\COGIP_AUDIT_AUDIT as MyAttributes;
    
    Class COGIP_AUDIT_AUDIT extends \Dcp\Family\COGIP_AUDIT_BASE
    {
    }

Les deux classes référencées dans ce fichier n'existent pas encore :
elles sont générées automatiquement sur le serveur lors de l'importation des familles.

Vous pouvez générer des classes de référence, les _stubs_, qui permettent d'utiliser la complétion sur votre IDE.
Ces classes ne contiennent que les éléments qui vous seront utiles lors du développement et ne sont pas tout à fait semblables à celles générées sur le serveur.

Ouvrez une console et rendez vous dans le répertoire de votre application et lancez la commande suivante :

`<devtool> generateStub -s . -o ./stubs/`

L'outil a généré les stubs dans le nouveau sous-répertoire `stubs` dans le répertoire de vos sources :

    ├ stubs
      ├─ cogip_audit_audit__STUB.php
      ├─ cogip_audit_base__STUB.php
      ├─ cogip_audit_chapitre__STUB.php
      ├─ cogip_audit_fnc__STUB.php
      └─ cogip_audit_referentiel__STUB.php

Les fichiers stubs contiennent :

-   les classes intermédiaires générées sur le serveur (une classe par famille, sous le namespace `\Dcp\Family`)
    qui permettent d'avoir la chaîne d'héritage complète et la complétion via les IDE,
-   les classes d'attributs (une classe par famille, sous le namespace `\Dcp\AttributeIdentifiers`)
    qui contiennent la liste des attributs définis dans les fichiers `__STRUCT.csv`
    et permettent de référencer les attributs en utilisant la complétion.

Vous pouvez retrouver les stubs sur [github][tuto_stub].

Exemple de complétion d'attribut à l'aide des stubs :

![ Complétion d'attribut ](30-20-structure-stub-completion.png "Complétion d'attribut dans PhpStorm")

## Internationalisation {#quickstart:989b4a9e-e3d8-475e-9dcf-9a158605eab6}

Vous allez maintenant extraire les clefs permettant de traduire vos familles.

Ouvrez une console et rendez vous dans le répertoire de votre application et lancez la commande suivante :

`<devtool> extractPo -s .`

Des nouveaux fichiers de po sont ajoutés, il en existe un par famille et par langue.

    ./locale
    ├── en
    │   └── LC_MESSAGES
    │       └── src
    │           ├── COGIP_AUDIT_AUDIT_en.po
    │           ├── COGIP_AUDIT_BASE_en.po
    │           ├── COGIP_AUDIT_CHAPITRE_en.po
    │           ├── COGIP_AUDIT_en.po
    │           ├── COGIP_AUDIT_FNC_en.po
    │           └── COGIP_AUDIT_REFERENTIEL_en.po
    └── fr
        └── LC_MESSAGES
            └── src
                ├── COGIP_AUDIT_AUDIT_fr.po
                ├── COGIP_AUDIT_BASE_fr.po
                ├── COGIP_AUDIT_CHAPITRE_fr.po
                ├── COGIP_AUDIT_FNC_fr.po
                ├── COGIP_AUDIT_fr.po
                └── COGIP_AUDIT_REFERENTIEL_fr.po

Chacun de ces fichiers contient l'ensemble des clefs permettant de traduire les labels des attributs et des énumérés de la famille qu'il référence.

Pour chaque attribut est généré le bloc suivant :

    [gettext]
    #: COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
    #, fuzzy
    msgid "COGIP_AUDIT_AUDIT#caa_titre"
    msgstr "Titre"

La traduction présente est celle que vous avez notée dans le fichier CSV.  
La notation `fuzzy` indique que la traduction est une proposition pour aider le traducteur.

    [gettext]
    #: COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
    msgid "COGIP_AUDIT_AUDIT#caa_titre"
    msgstr "Titre"

Pour le fichier `fr`, vous pouvez enlever les fuzzy car les propositions sont correctes, par contre il vous faudra traduire fichier `en`.

## Production du paquet {#quickstart:62bc3a4e-9b6c-4da2-9fb0-145ecee0f281}

Vous allez maintenant produire le paquet.

    <devtool> generateWebinst -s .

Déployez le paquet en passant par Dynacase Control (`http://<nomDeDomaine>/dynacase-control/`) en utilisant le scénario *upgrade* 
(en cas de besoin, n'hésitez pas à consulter les instruction de [déploiement][deploy_instruct]).

<span class="flag inline nota-bene"></span> Vous utilisez maintenant le scénario *upgrade* car vous avez fait l'initialisation
dans le chapitre précédent. L'initialisation apporte l'import des comptes (utilisateurs, groupes, rôles), or ceux-ci
sont déjà importés, il est donc inutile (et coûteux en temps) de le faire à nouveau.

Vos familles sont installées sur le contexte, vous allez pouvoir consulter vos premiers formulaires.

## Consultation des familles {#quickstart:21559978-8fea-4376-8b77-f0de73437efe}

Vous pouvez consulter les familles en utilisant l'interface open source de consultation par défaut `OneFam`.  
Cette interface est un exemple d'interface possible de consultation/création de documents.
Elle est simple à configurer et permet d'accéder à la création de rapport et de recherche.

Pour accéder à cette interface, connectez vous sur le contexte.

Vous arrivez sur l'interface suivante :

![ AppSwitcher ](30-20-appswitcher.png "AppSwitcher")

Utilisez le menu en haut à gauche et sélectionnez l'application `Une famille`. Vous arrivez sur l'interface suivante :

![ Onefam ](30-20-onefam.png "Onefam")

Les deux boutons `+` vous permettent de choisir les familles présentées :

-   le premier permet de choisir les familles présentées à tous les utilisateurs,
-   le deuxième permet de choisir les familles qui vous sont présentées.

Cliquez sur le deuxième bouton et vous obtenez l'interface suivante :

![ Choisissez vos familles ](30-20-onefam-choose-family.png "Choisissez vos familles")

Veuillez sélectionner la famille `COGIP_AUDIT`.

![ Choisissez vos familles ](30-20-onefam-choose-family2.png "Choisissez vos familles")

Cliquez sur valider et confirmez.

Vous obtenez l'interface suivante :

![ Onefam ](30-20-onefam2.png "Onefam")

Pour l'instant toutes les familles sont semblables car vous n'avez pas configuré les icônes, vous pouvez les identifier en survolant l'icône.

Vous pouvez créer quelques formulaires en utilisant l'interface.

1. Cliquez sur une des icônes,
2. Cliquez sur `création > ...nom de la famille... `.

![ Onefam ](30-20-onefam_audit.png "Onefam : Création")

## Conclusion {#quickstart:1f4af8a5-d83c-443d-a41d-cbc1e5677af4}

Vous savez maintenant créer des familles, paramétrer la structure et les traduire.

Dans les autres tutoriaux de ce chapitre vous allez apprendre à les paramétrer, en paramétrer la sécurité, en modifier les interfaces.

## Voir aussi {#quickstart:226443c7-a82f-4edd-b8e1-430892fcf030}

* [Les sources après ce chapitre][tuto_after_30_20],
* [Définition CSV d'une famille][DocFamCSV],
* [Liste des attributs][DocAttribut],
* [Liste des visibilités][DocVisibilite],
* [Internationalisation][Internationalisation].

<!-- links -->
[Method_stub]: http://en.wikipedia.org/wiki/Method_stub "Wikipedia: Method stub"
[php_namespace]: http://www.php.net/manual/en/language.namespaces.rationale.php "Doc PHP : namespace"
[DocFamCSV]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html "Documentation : structure du fichier de définition"
[DocAttribut]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4e167170-33ed-11e2-8134-a7f43955d6f3.html "Documentation : attribut"
[annexe]:   #quickstart:69f091b6-34ef-47b0-a453-8e00676b7dcd
[annexeColor]: #quickstart:c35b47c9-22d0-44c9-9bdd-0ddde39af53c
[DocVisibilite]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3e67d45e-1fed-446d-82b5-ba941addc7e8.html "Documentation : visibilité"
[DocDocid]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:d461d5f5-b635-47a0-944d-473c227587ab.html#core-ref:d461d5f5-b635-47a0-944d-473c227587ab "Documentation : Docid"
[DocArray]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:dd400581-8896-4eec-9b9e-f1e5669cf180.html "Documentation : Array"
[DocTab]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:5b236ce8-ad99-4e21-ae8a-cbea6942c3e4.html "Documentation : Tab"
[Internationalisation]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:8f3ad20a-4630-4e86-937b-da3fa26ba423.html "Documentation : Internationalisation"
[tuto_after_30_20]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-30-20.zip
[tuto_audit_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-20/COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
[tuto_audit_chapitre]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-20/COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv
[tuto_audit_ref]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-20/COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv
[tuto_audit_fnc]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-20/COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv
[tuto_stub]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-30-20/stubs
[deploy_instruct]: #quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e
