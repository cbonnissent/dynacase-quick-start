# Mise en place des structures  {#quickstart:3b64d38f-81aa-4c02-aad5-77271247bf15}

Ce chapitre va vous permettre d'initier vos premières familles.

## Objectifs {#quickstart:a17c7d35-e9ba-47a4-9b0f-2919d6926966}

* Créer une famille de base,
* Créer les familles en utilisant l'héritage,
* Initier les attributs,
* Initier les stubs,
* Faire une première traduction,
* Déployer votre module.

## Cadre {#quickstart:c77a23ec-d38d-4ada-8a99-8b5124297770}

L'analyse des besoins a montré que votre application nécessite les familles suivantes :

* Référentiel qualité : Elle représente un référentiel qualité et contient :
    * la référence d'un référentiel qualité,
* Chapitre de référentiel : Elle représente un chapitre et contient:
    * un lien vers la référence à un référentiel, 
    * un titre,
+ Audit : Elle représente un audit et contient :
    + le titre de l'audit,
    + sa date de début,
    + le site audité,
    + un champ de descriptif,
    + le responsable d'audit,
    + la liste des auditeurs,
    + une liste de référentiels,
    + une liste de points forts, avec pour chacun :
        + un encart de texte,
    + une liste de points faibles,
        + un encart de texte,
    + une liste de fiche de non conformité,
    + une liste de fichier associée.
+ Fiche de non conformité : Elle représente une non conformité et contient :
    + le titre de la non conformité,
    + un lien vers la fiche d'audit,
    + une liste de liens vers des chapitres de référentiel, avec pour chacun :
        + un lien vers le chapitre,
        + un lien vers le référentiel,
        + un texte explicitant le manquement
    + une liste d'actions, avec pour chacune :
        + un descriptif,
        + un responsable,
        + une date de prise en compte

## Partie théorique {#quickstart:75dc2bf5-ae31-434e-a538-96ad9c52967f}

### Structure de famille {#quickstart:652fd302-fef6-4335-bea8-e26a60759537}

La structure d'une famille est définie par deux éléments :

* le fichier de structure : il contient la liste des attributs (type de donnée) que les documents de la famille contiennent, 
* l'héritage : si une famille hérite d'une autre, elle hérite de manière dynamique de tous les éléments de ses familles parentes.

La structure de la famille est utilisée en interne par Dynacase pour :

* créer la table de la base de donnée permettant de stocker les données,
* générer les formulaires de saisie des données,
* générer les formulaires de recherche de documents,
* générer les matrices de gestion de droits,
* etc.

## Création de votre première famille : Famille de base {#quickstart:d16313a5-1ae6-422a-9f45-8d721aafcd18}

Il est considéré comme une bonne pratique de commencer un projet Dynacase par une famille abstraite qui est mère de toutes les autres familles.  
Ceci permet de propager plus facilement des comportements spécifiques entre toutes les familles d'un projet. Par exemple, si vous souhaitez empêcher la duplication de tous les documents au sein de votre projet, vous pouvez le spécifier au niveau de la famille mère et le comportement est transmis à toutes les familles filles.

Ouvrez le **developper toolkit** et cliquez sur **Template** et ensuite **Create a family**, l'outil vous demande ensuite :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

et cliquer sur `generate`.

Les fichiers suivants sont générés :

    ./COGIP_AUDIT
    ├── COGIP_AUDIT_BASE__CLASS.php
    ├── COGIP_AUDIT_BASE__PARAM.csv
    ├── COGIP_AUDIT_BASE__STRUCT.csv

Les fichiers ci-dessus sont pré-rempli et prêt à être utilisés. Leur nomenclature est explicitée dans l'[annexe][annexe].

Vous devez maintenant indiquer dans le fichier `info.xml` que cette famille doit être importée à lors de l'initialisation et de la mise à jour. Vous allez ajouter les lignes suivantes :

    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>

dans la partie d'initialisation, après l'import des utilisateurs, dans la partie d'upgrade après le `record_application`. 

Vous devez avoir un fichier `info.xml` semblable à :

    <post-install>
        <process command="programs/record_application COGIP_AUDIT" />
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
        <process command="programs/update_catalog" />
    </post-install>
    
    <post-upgrade>
        <process command="programs/pre_migration COGIP_AUDIT" />
        <process command="programs/record_application COGIP_AUDIT" />
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
        <process command="programs/post_migration COGIP_AUDIT" />
        <process command="programs/update_catalog" />
    </post-upgrade>

## Création des fichiers de familles {#quickstart:72980b93-3f1f-4aa0-b12d-756e072f2029}

Vous allez maintenant créer les autres familles, reprenez l'outil **developper toolkit** et cliquez sur **Template** et ensuite **Create a family**. Ajoutez les options suivantes :

Ensuite, la famille `Référentiel qualité` :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COGIP_AUDIT_REFERENTIEL`,
* parent name : `COGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

Ensuite, la famille `Chapitre` :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_CHAPITRE`,
* parent name : `COGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

Ensuite, la famille `Audit` :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_AUDIT`,
* parent name : `COGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

Ensuite, la famille `Fiche de Non conformité` :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_FNC`,
* parent name : `COGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

Vous avez créé l'ensemble des fichiers qui vont héberger vos familles. 

Il faut maintenant les référencer dans le fichier `info.xml`. Pour ce faire, vous devez respecter l'ordre de l'héritage et importer en premier les familles mères et ensuite les familles filles. Si vous ne suivez pas un ordre adéquat, l'installeur refusera d'installer le paquet et vous indiquera le problème.

Votre `info.xml` contient les lignes suivantes :

    <post-install>
        <process command="programs/record_application COGIP_AUDIT" />
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv"/>
        <process command="programs/update_catalog" />
    </post-install>
    
    <post-upgrade>
        <process command="programs/pre_migration COGIP_AUDIT" />
        <process command="programs/record_application COGIP_AUDIT" />
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv"/>
        <process command="programs/post_migration COGIP_AUDIT" />
        <process command="programs/update_catalog" />
    </post-upgrade>

## Ajout des attributs {#quickstart:dfb226d3-2b6d-45a2-b5de-7a671186247b}

Vous allez maintenant définir les [attributs][DocAttribut] contenus dans vos familles.

### Référentiel qualité {#quickstart:f8d481f6-4be2-457c-a7e3-96165fbf4cf9}

Vous allez commencer par la famille `Référentiel qualité`. Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv`.

Le fichier se présente sous cette forme :

![ Contenu structure site ](30-20-structure-referentiel.png "Contenu structure site")

NB : Vous pouvez installer les scripts permettant de faire la coloration syntaxique en suivant l'[annexe][annexeColor]. Ces scripts permettent de colorer les fichiers, numéroter automatiquement les attributs et remplir un  quelques éléments avec des valeurs par défaut. Dans la suite du tutoriel, nous allons considérer que vous avez installé ces scripts.

NB : **Attention** : un attribut non-structurant (texte, relation, numérique, ...) doit obligatoirement être contenu dans un attribut structurant (frame ou array).

Pour définir un attribut, vous devez :

1. dans la colonne A, indiquez le mot clef `ATTR`,
2. dans la colonne B, indiquez l'identifiant de l'attribut, celui-ci est alphanumérique et écrit de préférence en minuscules,
3. dans la colonne C, indiquez l'attribut encadrant de l'attribut en cours (cet élément est nécessaire pour les attributs non-structurants, c'est à dire les attributs qui contiennent des données, text, int, etc.). NB : le script `setParent` rempli automatiquement les parents des attributs n'en ayant pas,
4. dans la colonne D, la valeur de traduction par défaut du label de l'attribut,
5. dans la colonne E, Y ou N cela indique si l'attribut est utilisé pour composer le titre,
6. dans la colonne G, le type de l'attribut,
7. dans la colonne H, l'ordre d'affichage des attributs. Cet élément est utile dans le cas d'héritage entre famille, il permet de dire dans quel ordre doivent être affichés les attributs. NB : Le script `setOrder` calcul automatiquement l'ordre d'affichage, vous pouvez indiquez que la numérotation doit reprendre à un numéro en l'indiquant colonne R,
8. la colonne `I` indique la [visibilité][DocVisibilite] par défaut de l'attribut.

Dans le cas des `Référentiel qualité`, vous devez obtenir une structure similaire à :

![ Contenu structure référentiel ](30-20-structure-referentiel-done.png "Contenu structure référentiel")

Quelques astuces pour faciliter l'écriture des familles :

* il est préférable de composer les noms d'attributs de la manière suivante : un préfixe pour indiquer leur famille de provenance (utile dans le cas d'un héritage), une lettre pour indiquer le type d'encadrant lorsque l'attribut est en encadrant (f pour frame, a pour array, t pour tab), un nom logique explicite indiquant le contenu de l'attribut,
* vous pouvez commencer en complétant les colonnes `A`, `B`, `D` et `G` et en exécutant ensuite les scripts :
    * `autonum` : il se charge de numéroter les attributs,
    * `color` : il applique une coloration suivant le type d'attribut,
    * `setDefaultOption` : il remplit les valeurs par défaut des colonnes `E`, `F`, `H`, `I` et `O`.
    * `setParent` : il complète la colonne `C` en reprenant le dernier encadrant rencontré comme parent.

![ Exemple de construction ](30-20-structure-completion.gif "Exemple de construction")

### Chapitre {#quickstart:db00ea11-3c9a-4a99-8879-af61e8ad2745}

Vous allez maintenant compléter la famille `chapitre`. Cette famille contient un lien vers son référentiel, de manière a pouvoir retrouver facilement tous les chapitres d'un référentiel.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv`. Et complétez le pour obtenir une structure similaire à :

![ Contenu structure Chapitre ](30-20-structure-chapitre.png "Contenu structure Chapitre")

Vous pouvez remarquer la présence d'un nouveau type d'attribut [docid][DocDocid]. Ce type d'attribut permet de créer des liens entre les fiches, il se présente :

* en édition sous la forme d'une liste déroulante ou vous pouvez choisir un document pour compléter la valeur, 
* en consultation sous la forme d'un lien hypertext pointant vers le document référencé par sa valeur.

Dans sa définition, vous pouvez voir une référence vers la famille `Référentiel`, cela indique la nature du lien et permet de n'afficher que les documents provenant de cette famille en édition.

### Fiche de non conformité {#quickstart:6bc0b33f-c7a9-4b20-b940-8d939c3b97ec}

Vous allez maintenant compléter la `Fiche de non conformité`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv`. Et complétez le pour obtenir une structure similaire à :

![ Contenu structure FNC ](30-20-structure-fnc.png "Contenu structure FNC")

Vous pouvez remarquer la présence de deux nouveaux éléments structurants :

* [array][DocArray] : un array permet de gérer la multiplicité de certaines informations, sous la forme d'un tableau ou chaque élément contenu est une colonne et chaque valeur est stockée sur une ligne,
* [tab][DocTab] : une tab est représentée sous la forme d'onglet dans le formulaire, elle permet d'éviter d'avoir des formulaires trop long et d'avoir une présentation plus lisible.

NB : Pour faciliter la lecture des noms d'attribut, il est conseillé pour les attributs contenus dans un array de préfixer leur nom avec le nom de l'array. Par exemple, pour le chapitre qui est contenu dans le tableau `ecart`, on obtient `caf_ecart_chapitre`.

### Audit {#quickstart:b2eccdab-bbda-4d80-86a7-dd5e6cdb22dc}

Vous allez maintenant compléter votre dernière famille, la `Fiche d'audit`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv`. Et complétez le pour obtenir une structure similaire à :

![ Contenu structure Audit ](30-20-structure-audit.png "Contenu structure Audit")

Bravo ! Vous avez initialisé l'ensemble des familles.

## Génération des stubs {#quickstart:df9b59b1-3a7f-420b-a89d-36cd6894edb9}

Vous allez maintenant générer les stubs. Les stubs sont des fichiers PHP qui sont générés pour aider au développement de l'application.

Si vous ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php`, vous avez le contenu suivant :

    [php]
    namespace Cogip;
    use \Dcp\AttributeIdentifiers\COGIP_AUDIT_AUDIT as MyAttributes;
    
    Class COGIP_AUDIT_AUDIT extends \Dcp\Family\COGIP_AUDIT_BASE
    {
    }

Les deux classes référencées dans ce fichier n'existent pas encore, elles sont générées automatiquement sur le serveur à l'importation des familles.

Vous pouvez générer des classes de référence qui permettent d'utiliser la complétion sur votre IDE. Ces classes ne contiennent que les éléments qui vous serons utiles lors du développement et ne sont pas tout à fait semblables à celles générées sur le serveur.

Pour générer les stubs, veuillez ouvrir le **developper toolkit** et cliquez sur **Stubs** l'outil vous demande ensuite :

* path : le path vers les sources

Cliquez ensuite sur `Generate`.

L'outil a créé un répertoire `stubs` dans vos sources, ce répertoire contient un mock des classes générées contenant les éléments utiles pour la phase de développement.

Une fois les stubs généré, un nouveau répertoire est présent dans les sources, ce répertoire contient :

    stubs
    ├── COGIP_AUDIT_AUDIT__STUB.php
    ├── COGIP_AUDIT_BASE__STUB.php
    ├── COGIP_AUDIT_CHAPITRE__STUB.php
    ├── COGIP_AUDIT_FNC__STUB.php
    └── COGIP_AUDIT_REFERENTIEL__STUB.php

Les fichiers stubs contiennent :

* les classes intermédiaires générées sur le serveur (`\Dcp\Family\COGIP_AUDIT_BASE`) qui permettent d'avoir la chaîne d'héritage complète et la complétion,
* les classes en `\Dcp\AttributeIdentifiers\COGIP_AUDIT_AUDIT` qui contiennent la liste des attributs défini dans les fichiers `__STRUCT.csv` et permettent de référencer les attributs en utilisant la complétion de votre IDE.

## Internationalisation {#quickstart:989b4a9e-e3d8-475e-9dcf-9a158605eab6}

Vous allez maintenant extraire les clefs permettant de traduire vos familles.

Reprenez le **developper toolkit** et cliquez sur le bouton `internationalisation`, vous indiquez alors le path vers vos sources et cliquer sur le bouton `extraction`.

Des nouveaux fichiers de po sont ajoutés, il en existe un par famille et par langue.

    ./locale
    ├── en
    │   └── LC_MESSAGES
    │       └── src
    │           ├── COGIP_AUDIT.po
    │           ├── family_COGIP_AUDIT_AUDIT.po
    │           ├── family_COGIP_AUDIT_BASE.po
    │           ├── family_COGIP_AUDIT_CHAPITRE.po
    │           ├── family_COGIP_AUDIT_FNC.po
    │           └── family_COGIP_AUDIT_REFERENTIEL.po
    └── fr
        └── LC_MESSAGES
            └── src
                ├── COGIP_AUDIT.po
                ├── family_COGIP_AUDIT_AUDIT.po
                ├── family_COGIP_AUDIT_BASE.po
                ├── family_COGIP_AUDIT_CHAPITRE.po
                ├── family_COGIP_AUDIT_FNC.po
                └── family_COGIP_AUDIT_REFERENTIEL.po

Chacun de ces fichiers contient l'ensemble des clefs permettant de traduire les labels des attributs et des énumérés de la famille qu'il référence.

Pour chaque attribut est généré le bloc suivant :

    #: COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
    #, fuzzy
    msgid "COGIP_AUDIT_AUDIT#caa_titre"
    msgstr "Titre"

NB : Par défaut la traduction ajoutée est celle par défaut que vous avez noté dans le fichier CSV. Et qu'elle est en `fuzzy`, les traductions en fuzzy sont des propositions pour aider le traducteur.

    #: COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
    msgid "COGIP_AUDIT_AUDIT#caa_titre"
    msgstr "Titre"

Pour le fichier `fr`, vous pouvez enlever les fuzzy car les propositions sont les bonnes traductions, pour le fichier `en` il vous faudra traduire.

## Production du paquet {#quickstart:62bc3a4e-9b6c-4da2-9fb0-145ecee0f281}

Vous allez maintenant produire le paquet en utilisant le **developper toolkit**.

Déployez le paquet en passant par Dynacase Control, en utilisant le scénario upgrade.

Vos familles sont maintenant installées sur le contexte, vous allez pouvoir consulter vos premiers formulaires.

## Consultation des familles {#quickstart:21559978-8fea-4376-8b77-f0de73437efe}

Vous pouvez consulter les familles en utilisant l'interface open source de consultation par défaut `OneFam`. Cette interface est un exemple d'interface possible de consultation/création de documents, il est simple à configurer et permet d'accéder à la création de rapport et de recherche.

Pour accéder à cette interface, connectez vous sur le contexte.

Vous arrivez sur l'interface suivante :

![ AppSwitcher ](30-20-appswitcher.png "AppSwitcher")

Utilisez le menu en haut à gauche et sélectionnez l'application `Une famille`. Vous arrivez sur l'interface suivante :

![ Onefam ](30-20-onefam.png "Onefam")

Les deux boutons `+` vous permettent de choisir les familles présentées :

* le premier permet de choisir les familles présentées à tous les utilisateurs,
* le deuxième permet de choisir les familles qui vous sont présentées.

Cliquez sur le deuxième bouton et vous obtenez l'interface suivante :

![ Choisissez vos familles ](30-20-onefam-choose-family.png "Choisissez vos familles")

Veuillez sélectionner les familles `COGIP_AUDIT`.

![ Choisissez vos familles ](30-20-onefam-choose-family2.png "Choisissez vos familles")

Cliquez sur valider et confirmez.

Vous obtenez l'interface suivante :

![ Onefam ](30-20-onefam2.png "Onefam")

Pour l'instant toutes les familles sont semblables car vous n'avez pas configuré les icônes, vous pouvez les identifier en survolant l'icône.

Vous pouvez créer quelques formulaires en utilisant l'interface.

1. Cliquez sur une des icônes,
2. Cliquez sur création,
3. Cliquez sur le nom de la famille.

![ Onefam ](30-20-onefam_audit.png "Onefam")

## Conclusion {#quickstart:1f4af8a5-d83c-443d-a41d-cbc1e5677af4}

Vous savez maintenant créer des familles, paramétrer la structure et les traduire.

Dans les autres tutoriaux de ce chapitre vous allez apprendre à les paramétrer, en paramétrer la sécurité, en modifier les interfaces.

## Voir aussi {#quickstart:226443c7-a82f-4edd-b8e1-430892fcf030}

* [Définition CSV d'une famille][DocFamCSV],
* [Liste des attributs][DocAttribut],
* [Liste des visibilités][DocVisibilite].

<!-- links -->

[php_namespace]: http://www.php.net/manual/en/language.namespaces.rationale.php "Doc PHP : namespace"
[DocFamCSV]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html "Documentation : structure du fichier de définition"
[DocAttribut]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4e167170-33ed-11e2-8134-a7f43955d6f3.html "Documentation : attribut"
[annexe]:   #quickstart:69f091b6-34ef-47b0-a453-8e00676b7dcd
[annexeColor]: #quickstart:c35b47c9-22d0-44c9-9bdd-0ddde39af53c
[DocVisibilite]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3e67d45e-1fed-446d-82b5-ba941addc7e8.html "Documentation : visibilité"
[DocDocid]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:d461d5f5-b635-47a0-944d-473c227587ab.html#core-ref:d461d5f5-b635-47a0-944d-473c227587ab "Documentation : Docid"
[DocArray]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:dd400581-8896-4eec-9b9e-f1e5669cf180.html "Documentation : Array"
[DocTab]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:5b236ce8-ad99-4e21-ae8a-cbea6942c3e4.html "Documentation : Tab"