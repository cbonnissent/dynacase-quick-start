# Mise en place de l'environnement de développement {#quickstart:5b0e5ec5-1f8d-49ea-9953-42727cdc1b2b}

Ce chapitre va vous permettre d'initialiser le module contenant le code source de 
votre application Dynacase.

## Objectifs {#quickstart:04e53353-fe9b-4b51-8097-fdc8b60ea166}

-   Télécharger le template de module
-   Initialiser le module
-   Faire un tour des différents répertoires, fichiers et de leur utilité,
-   Faire une première traduction
-   Déployer votre module

## Partie théorique {#quickstart:88db7990-155d-4f96-95e1-57406b2b493b}

Comme nous l'avons vu au [chapitre précédent](#quickstart:b4e5f7b4-de08-4890-8401-440f335e90fe),
Dynacase Control utilise le concept de module pour gérer les différents éléments constituants un
contexte.

Un module est composé de :

-   un fichier `info.xml` contenant les instructions d'installation ou de mise à jour du module,
-   des fichiers de *code source* et de *paramétrage* du module,
-   de manière optionnelle :
    -   une ou plusieurs applications,
    -   une ou plusieurs familles
    -   un ou plusieurs styles,
    -   etc.

Dynacase Control utilise des modules au format **webinst**.
Ce format permet de transporter le module sous la forme d'un seul fichier.
Ce fichier, nommé *paquet*, est composé de la manière suivante :

-   une archive [**tar.gz**][tar] contenant :
    -   le fichier `info.xml`
    -   une archive compressée [**content.tar.gz**][tar] contenant le code source du module tel qu'il est déployé sur le serveur

Une fois le module fourni à Dynacase Control, celui-ci lit le fichier `info.xml`, décompresse le contenu du content.tar.gz dans
le contexte et exécute les éventuelles instructions d'installation ou mise à jour.

## Mise en place {#quickstart:6207b157-95a4-4a53-b112-fbb5c2b58741}

Il vous faut tout d'abord télécharger le **developper toolkit**, cet outil vous permet :

-   d’initialiser les sources d'un module Dynacase,
-   d'ajouter des applications, des familles, des workflow à votre projet,
-   de faire les traductions,
-   de produire le fichier webinst.

L'installation du toolkit et de ses dépendances est décrite dans [l'annexe toolkit][annexe_toolkit], merci de vous y référer.

Pour l'exécuter les devtool, la procédure diffère si vous êtes sous un système linux ou window :

* window : lancer la console et appeler le fichier dynacase-devtool.bat,
* linux : lancer la console et appeler le fichier dynacase-devtool.phar (ou php dynacase-devtool.phar si vous n'avez pas associé les .phar à php).

Une fois l'outil téléchargé et installé, lancez, via la console, la commande :

    <devtool> createModule

L'invite vous proposer les choix suivants :

    You need to set the name of the application -n or --name
    You need to set the output path for the file -o or --output
    Usage: /usr/local/bin/devtool [options] [operands]
    Options:
      -o, --output <arg>      output Path (needed)
      -n, --name <arg>        name of the module (needed)
      -a, --application <arg> associated application (list of app name separeted by ,)
      -l, --lang <arg>        list of locale (list of locale separeted by ,) default (fr,en)
      -x, --external          with external file
      -s, --style             with style directory
      -p, --api               with api directory
      -e, --enclosure [<arg>] enclosure of the CSV generated (default : " )
      -d, --delimiter <arg>   delimiter of the CSV generated (default : ; )
      -h, --help              show the usage message


Cette commande va intialiser pour vous une structure de module Dynacase type pré-paramétrée.

Dans notre cas, vous rentrez les options suivantes :

    <devtool> createModule  -o . -n cogip-audit -a COGIP_AUDIT -xsp -e

Cela créer dans le répertoire courant la structure de fichiers suivante :

    ┊
    ├─ API/
    ├─ COGIP_AUDIT
    │  ├─ COGIP_AUDIT.app
    │  ├─ COGIP_AUDIT_init.php
    │  ├─ Images/
    │  └─ Layout/
    ├─ EXTERNALS/
    ├─ STYLE/
    ├─ locale/
    ├─ Images/
    ├─ build.json
    ├─ info.xml
    ┊

La structure générée contient les éléments suivants :

-   **build.json** : ce fichier contient les instructions qui permettent au developper toolkit de builder le module et d'extraire les chaînes à traduire, vous pouvez en lire une description détaillée dans [l'annexe][annexe_buildjson]
-   **info.xml** : ce fichier décrit les actions à effectuer lors de
l'installation et de la mise à jour du module. Il est initialisé avec les instructions pour enregistrer l'application `COGIP_AUDIT`
-   **COGIP_AUDIT** : Ce répertoire contient les sources de l'application `COGIP_AUDIT` sur laquelle vous allez travailler.
    C'est dans ce répertoire que vous allez mettre les définitions des familles, les actions et les assets (fichiers images, CSS, JS) de cette application,
-   **COGIP_AUDIT/COGIP_AUDIT.app** : Ce fichier contient la définition de l'application `COGIP_AUDIT`,
-   **COGIP_AUDIT/COGIP_AUDIT_init.php** : Ce fichier contient les paramètres 
applicatifs associés à l'application `COGIP_AUDIT` par défaut il contient le 
numéro de version de l'application.

Ouvrez le fichier `COGIP_AUDIT/COGIP_AUDIT.app`

    [php]
    $app_desc = array(
        "name" => "COGIP_AUDIT",
        "short_name" => N_("COGIP_AUDIT:COGIP_AUDIT"),
        "description" => N_("COGIP_AUDIT:COGIP_AUDIT"),
        "icon" => "COGIP_AUDIT.png",
        "displayable" => "N",
        "childof" => ""
    );

Nous voyons que par défaut une référence est ajoutée vers un fichier `COGIP_AUDIT.png` ce fichier est à déposer dans le répertoire `Images` à la racine du module. Cette image est utilisée pour représenter l'application dans les différentes interfaces Dynacase -menus, administration, etc-.

Toutes les chaînes de caractères qui sont inclues dans les fonction `_` et `N_` sont traduisibles, ce qui est ici le cas pour
`short_name` et `description`.

Vous pouvez ajouter l'image au répertoire, toutes les images du tutoriel peuvent-être trouvées [ici][tuto_images].

## Traduction {#quickstart:bec85337-36e8-4289-a938-f48b361e125e}

Vous allez lancer la procédure permettant l'extraction des clefs de traduction et compléter celles-ci.

Une première version des fichiers de traductions a été initialisée lors de la création du module.

La commande pour rafraîchir les po est :

    <devtool> extractPo -s .

Le -i indique le path où se trouve les sources, dans l'exemple ci-dessus elles sont dans le path courant.

Les po sont dans la structure suivante.

    ┊
    ├─┬─ locale
    ┊ ├─ en
      │  └─ LC_MESSAGES
      │     └─ src
      │        └─ COGIP_AUDIT_en.po
      └─ fr
          └─ LC_MESSAGES
             └─ src
                └─ COGIP_AUDIT_fr.po

Ces fichiers sont les dictionnaires de traductions et ils contiennent les clefs que nous avons identifiées ci-dessus
ainsi que leurs traductions.

Il est créé les fichiers PO suivants :

* un fichier po par application,
* un fichier po pour le module (si besoin est),
* un fichier po par famille,
* un fichier po par contrôle de vue.

Le fichier `COGIP_AUDIT_fr.po` contient :

    [gettext]
    # French translations for PACKAGE package.
    # Copyright (C) 2014 THE PACKAGE'S COPYRIGHT HOLDER
    # This file is distributed under the same license as the PACKAGE package.
    # Automatically generated, 2014.
    #
    msgid ""
    msgstr ""
    "Project-Id-Version: COGIP_AUDIT_fr\n"
    "Report-Msgid-Bugs-To: \n"
    "POT-Creation-Date: 2014-09-22 12:08+0200\n"
    "PO-Revision-Date: 2014-09-22 11:44+0200\n"
    "Last-Translator: Automatically generated\n"
    "Language-Team: none\n"
    "Language: fr\n"
    "MIME-Version: 1.0\n"
    "Content-Type: text/plain; charset=UTF-8\n"
    "Content-Transfer-Encoding: 8bit\n"
    "Plural-Forms: nplurals=2; plural=(n > 1);\n"
    
    msgid "COGIP_AUDIT:COGIP_AUDIT"
    msgstr ""


Vous allez compléter la clef `Cogip_audit`, ceci peut-être fait à l'aide votre [IDE][wikiIDE] ou d'un logiciel
spécialisé tel que *[poedit][wpoedit]* ([téléchargement][upoedit]).

Complétez avec `Application d'audit de la cogip`.

Ce qui donne :

    [...]
    msgid "COGIP_AUDIT:COGIP_AUDIT"
    msgstr "Application d'audit de la cogip"

Une fois les modifications faites, vous obtenez le fichier suivant :

    [gettext]
    # French translations for PACKAGE package.
    # Copyright (C) 2014 THE PACKAGE'S COPYRIGHT HOLDER
    # This file is distributed under the same license as the PACKAGE package.
    # Automatically generated, 2014.
    #
    msgid ""
    msgstr ""
    "Project-Id-Version: COGIP_AUDIT_fr\n"
    "Report-Msgid-Bugs-To: \n"
    "POT-Creation-Date: 2014-09-22 12:08+0200\n"
    "PO-Revision-Date: 2014-09-22 11:44+0200\n"
    "Last-Translator: Automatically generated\n"
    "Language-Team: none\n"
    "Language: fr\n"
    "MIME-Version: 1.0\n"
    "Content-Type: text/plain; charset=UTF-8\n"
    "Content-Transfer-Encoding: 8bit\n"
    "Plural-Forms: nplurals=2; plural=(n > 1);\n"
    
    msgid "COGIP_AUDIT:COGIP_AUDIT"
    msgstr "Application d'audit de la cogip"


## Production du paquet {#quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e}

Vous allez maintenant conclure ce chapitre en produisant le fichier contenant le paquet et en le déployant à l'aide de l'interface web.

Exécutez la commande :

    <devtool> generateWebinst -s .

Un paquet `cogip-audit-1.0.0-0.webinst` est alors produit dans le répertoire des sources.

Vous devez ensuite accéder à `Dynacase control` pour le déployer.

![ Deploy webinst ](01-02-module.png "Deploy webinst")

Veuillez cliquer sur le bouton `Import Module` et à l'aide du sélecteur de fichier sélectionnez le paquet `cogip-audit-1.0.0-0.webinst`.

L'installeur vous demande le scénario que vous souhaitez utiliser.

![ Deploy webinst ](01-02-module2.png "Deploy webinst")

Le module n'ayant pas encore été installé, veuillez cliquer sur `Install`.

Dynacase control vous indique les différentes actions qu'il va exécuter.

![ Deploy webinst ](01-02-module3.png "Deploy webinst")

Veuillez valider, l’installation se déroule et votre application est en place.

Vous pouvez ensuite vérifier que celle-ci est bien installée et que la traduction est en place. Pour cela, allez sur
`http://<nomDeDomaine>/dynacase/admin.php` dans la catégorie `Gestion des applications`, `Les applications`.

![ Show application ](01-02-module_verify.png "Show application")

Vous pouvez retrouver votre application dans la liste. En outre, la traduction est appliquée dans la colonne description.

## Conclusion {#quickstart:12b5141e-7400-467b-87c0-458e487c9da3}

Vous connaissez maintenant la structure des sources Dynacase, vous savez construire et déployer un module
et avez abordé les principes des traductions.

## Voir aussi {#quickstart:bbe5ad1c-1aa3-4ae4-ba5d-a16b60999bed}

-   [Les sources après le tutoriel][githubSource]
-   [Le format des paquets webinst][webinst]
-   [Internationalisation et traduction][manref_internationalisation]

[wikiIDE]: https://fr.wikipedia.org/wiki/Environnement_de_d%C3%A9veloppement_int%C3%A9gr%C3%A9
[githubSource]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-10-30.zip "Github : source après le tutoriel"
[tar]: https://fr.wikipedia.org/wiki/Tar_(informatique) "Définition du TAR : Wikipedia"
[wpoedit]: https://en.wikipedia.org/wiki/Poedit "Description de Poedit : Wikipedia"
[upoedit]: http://www.poedit.net/download.php "Téléchargement de Poedit"
[webinst]: http://docs.anakeen.com/dynacase/3.2/dynacase-doc-platform-operating-manual/website/book/module.html "Le format des paquets webinst"
[manref_internationalisation]: http://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1de9ba03-a3b6-4b56-bfbe-62ce991f8ca1.html#core-ref:1de9ba03-a3b6-4b56-bfbe-62ce991f8ca1 "Internationalisation et traduction"
[manref_internationalisation_php]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:ca73ff9e-ceb8-456b-bdd4-9b9056f1543d.html#core-ref:967cd878-e068-4c99-8266-adaed3f700ff "Utiliser une traduction dans un programme PHP"
[url_toolkit]: https://github.com/cbonnissent/dynacase-devTools/raw/master/dynacase-devtool.phar
[annexe_toolkit]: #quickstart:afe5e4fc-97c4-46d6-9583-94daa33919f1
[annexe_buildjson]: #quickstart:f0fb9907-44e1-4956-aea1-14beb5cc077c
[tuto_images]: https://github.com/Anakeen/dynacase-quick-start-code/tree/master/Images