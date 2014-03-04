# Mise en place de votre module

Ce chapitre va vous permettre d'initier le module contenant le code source de 
votre application Dynacase.

## Objectifs

* Télécharger le template de module
* Initialiser le module
* Faire un tour des différents répertoires, fichiers et de leur utilité,
* Faire une première traduction
* Déployer votre module

## Partie théorique

Dynacase Control utilise le concept de module pour gérer les différents 
éléments composants un contexte.

Un module est composé de :

* un fichier info.xml contenant les instructions d'installation/mise à jour du module,
* des fichiers de code source et de paramétrage du module,
* de manière optionnel :
    * une ou plusieurs applications,
    * une ou plusieurs familles
    * un ou plusieurs styles,
    * etc.

Pour que Dynacase Control puisse l'utiliser le module doit lui être fournit au format **webinst**. Ce format permet de transporter le module sous la forme 
d'un seul fichier, le format est composé de la manière suivante :

* un [**tar**][tar] contenant :
    * le fichier **info.xml**
    * un **tar.gz** contenant le code source du module tel qu'il est déployé sur le serveur

Une fois le module envoyé à Dynacase Control, celui-ci lit le fichier info.xml et décompresse le contenu du tar.gz dans le contexte.

## Mise en place

Il vous faut tout d'abord télécharger le **developper toolkit**, cet outil vous permet :

* d’initialiser les sources d'un module Dynacase,
* d'ajouter des applications, des familles, des workflow à votre projet,
* de faire les traductions,
* de produire le fichier webinst.

Une fois l'outil téléchargé, vous cliquez sur l'exécutable qui vous demande l'action à effectuer dans notre cas **Create a new module**, vous complétez les quelques questions qui vous sont posées :

* **module logical name** : `COGIP_AUDIT`,
* **application logical name** : `COGIP_AUDIT`,
* **path** : chemin où vous souhaitez créer le module.

Et vous cliquez sur **Initialize**.

Vous obtenez la structure de fichiers suivante :

    ├── API/
    ├── COGIP_AUDIT
    │   ├── COGIP_AUDIT.app
    │   ├── COGIP_AUDIT_init.php
    │   ├── Images/
    │   ├── Layout/
    ├── EXTERNALS/
    ├── STYLE/
    ├── info.xml

La structure pré-générée contient les éléments suivants :

* **info.xml** : ce fichier décrit les actions à effectuer lors de
l'installation et de la mise à jour du module. Il est pré-intialisé avec les instructions pour enregistrer l'application `COGIP_AUDIT`
* **COGIP_AUDIT** : Ce répertoire contient les sources de l'application `COGIP_AUDIT` sur laquelle vous allez travailler. C'est dans ce répertoire que vous allez mettre les définitions des familles, les actions et les assets de 
cette application,
* **COGIP_AUDIT/COGIP_AUDIT.app** : Ce fichier contient la définition de 
l'application `COGIP_AUDIT`,
* **COGIP_AUDIT/COGIP_AUDIT_init.php** : Ce fichier contient les paramètres 
applicatifs associés à l'application `COGIP_AUDIT` par défaut il contient le 
numéro de version de l'application.

Vous allez reprendre le fichier `COGIP_AUDIT/COGIP_AUDIT.app`

    [php]
    $app_desc = array(
        "name"        => "COGIP_AUDIT",
        "short_name"  => _("Cogip_audit"),
        "description" => _("Cogip_audit"),
        "access_free" => "N",
        "icon"        => "cogip_audit.png",
        "displayable" => "N",
        "with_frame"  => "Y",
        "childof"     => ""
    );

Nous voyons que par défaut une référence est ajoutée vers un fichier `cogip_audit.png` ce fichier est à déposer dans le répertoire `Images` et sert à représenter l'application dans `app_switcher` et dans les interfaces d'administration.

Toutes les chaînes de caractères qui sont inclus dans la fonction `_` sont traduisibles, ce qui est ici le cas pour `short_name` et `description`.

## Traduction

Vous allez lancer la procédure permettant l'extraction des clefs de traduction et compléter celles-ci.

Reprenez le **developper toolkit** et cliquez sur le bouton `internationalisation`, vous indiquez alors le path vers vos sources et cliquer sur le bouton `extraction`.

Les fichiers suivants sont alors ajoutés :

    ├── locale
    │   ├── en
    │   │   └── LC_MESSAGES
    │   │       └── src
    │   │           └── COGIP_AUDIT.po
    │   └── fr
    │       └── LC_MESSAGES
    │           └── src
    │               └── COGIP_AUDIT.po

Ces fichiers sont les dictionnaires de traductions et ils contiennent les clefs que nous avons identifiés ci-dessus ainsi que leur traduction.

**Astuce** : Pour des raisons de performances toutes les clefs sont fusionnées dans un seul dictionnaire sur le serveur, il est donc conseillé de préfixer les clefs avec un trigramme pour éviter des collisions.

Le fichier COGIP_AUDIT.po dans sa version fr contient :

    # French translations for COGIP_AUDIT package
    # Traductions françaises du paquet COGIP_AUDIT.
    # Copyright (C) 2014 THE COGIP_AUDIT'S COPYRIGHT HOLDER
    # This file is distributed under the same license as the COGIP_AUDIT package.
    # Automatically generated, 2014.
    #
    msgid ""
    msgstr ""
    "Project-Id-Version: COGIP_AUDIT\n"
    "Report-Msgid-Bugs-To: \n"
    "POT-Creation-Date: 2014-03-04 17:40+0100\n"
    "PO-Revision-Date: 2014-03-04 17:40+0100\n"
    "Last-Translator: Automatically generated\n"
    "Language-Team: none\n"
    "Language: fr\n"
    "MIME-Version: 1.0\n"
    "Content-Type: text/plain; charset=UTF-8\n"
    "Content-Transfer-Encoding: 8bit\n"
    "Plural-Forms: nplurals=2; plural=(n > 1);\n"
    
    msgid "Cogip_audit"
    msgstr ""

Vous allez compléter la clef `Cogip_audit`, ceci peut-être fait à l'aide votre IDE ou d'un logiciel spécialisé [poedit][wpoedit].

Complétez avec `Application d'audit de la cogip`.

Ce qui donne :

    [...]
    msgid "Cogip_audit"
    msgstr "Application d'audit de la cogip"

## Production du paquet

Vous allez maintenant conclure ce chapitre en produisant le fichier contenant le paquet et en le déployant à l'aide de l'interface web.

Reprenez le **developper toolkit** et cliquez sur le bouton `webinst`vous indiquez alors le path vers vos sources et cliquer sur le bouton `generate`.

Un fichier `COGIP_AUDIT-1.0.0-0.webinst` est alors produit dans le répertoire des sources.

Vous devez ensuite ouvrir `Dynacase control` et déployez le paquet.

![ Deploy webinst ](01-02-module.png "Deploy webinst")

Veuillez cliquer sur le bouton `Import Module`, un sélecteur de fichier apparaît, vous devez sélectionner le fichier `COGIP_AUDIT-1.0.0-0.webinst`.

L'installeur vous demande le scénario que vous souhaitez utiliser.

![ Deploy webinst ](01-02-module2.png "Deploy webinst")

Le module n'ayant pas encore été installé, veuillez cliquer sur `Install`.

Dynacase control vous indiquer les différentes actions qu'il va exécuter.

![ Deploy webinst ](01-02-module3.png "Deploy webinst")

Veuillez valider, l’installation se déroule et votre application est en place.

Vous pouvez ensuite vérifier que celle-ci est bien installée et que la traduction est en place. Pour cela, allez `http://<nomDeDomaine>/admin.php` dans la catégorie `Gestion des applications`, `Les applications`.

![ Show application ](01-02-module_verify.png "Show application")

Vous pouvez retrouver votre application dans la liste. En outre, la traduction est appliquée dans la colonne description.


[tar]: https://fr.wikipedia.org/wiki/Tar_(informatique) "Définition du TAR : Wikipedia"
[wpoedit]: https://en.wikipedia.org/wiki/Poedit "Description de Poedit : Wikipedia"