# Developper Toolkit {#quickstart:afe5e4fc-97c4-46d6-9583-94daa33919f1}

## Présentation {#quickstart:ec240a39-07cc-4705-9c64-d1119a066fc8}

Le developper toolkit est une application conçue pour fiabiliser et accélérer 
le développement et la maintenance d'application Dynacase.
C'est un outil en ligne de commande compatible windows et linux.

Les principales fonctionnalité du toolkit sont :

* la production des paquets `webinst`,
* l'extraction des chaînes à traduire,
* la génération de template de code.

## Pré-requis {#quickstart:6e47679b-125b-4cd6-bc8d-806e5500128d}

Pour window, le toolkit est livré dans un package avec toutes ses dépendances : [toolkit window][url_win_toolkit].

Pour linux, les paquets :

* php,
* gettext

sont requis.

## Installation {#quickstart:e9e7fc63-031f-44c7-8443-60787e35d7be}

Pour linux : le developper toolkit est un [phar][php_phar]. Il suffit donc télécharger le [phar][url_linux_toolkit]. 
Et de l’exécuter avec l'interpréteur PHP.

`php dynacase-devtool.phar`

Pour window, il faut télécharger [toolkit window][url_win_toolkit] et le dezipper. Celui-ci contient un .bat `dynacase-devtool.bat` qui
doit être exécuté via la console window.

## Utilisation {#quickstart:6e013ebc-697a-4c18-8e38-d571b94d4261}

Le devtool vous proposer par défaut la liste de commande suivante :

    DevTools for Dynacase 3.2
    You can access to the sub command :
        createAction
        createApplication
        createFamily
        createInfoXml
        createModule
        createWorkflow
        extractPo
        generateStub
        generateWebinst

Chacune de ces commandes est auto-documentée et présentée dans le tutoriel.

## Build.json {#quickstart:f0fb9907-44e1-4956-aea1-14beb5cc077c}

Le fichier build.json qui est initialisé via la createModule contient la configuration permettant au developper tool de générer le webinst et d'extraire les chaînes à traduire.

    {
        "moduleName" : "cogip-audit",
        "version" : "1.0.0",
        "release" : "0",
        "application" : ["COGIP_AUDIT"],
        "includedPath" : ["locale","EXTERNALS","STYLE"],
        "lang" : ["fr","en"],
        "toolsPath" : { "getttext" : ""},
        "csvParam" : {"enclosure" : "\"", "delimiter": ";"}
    }

Les entrées sont :

* *moduleName* : il contient le nom du module, il est utilisé pour nommer le webinst et pour compléter le info.xml (`@@moduleName@@`),
* *version*, *release* : Version et release du module. Ils sont utilisés dans le nom du webinst et complété dans le info.xml,
* *application* : c'est un array, il contient la liste des applications délivrés par le module (vous devez le mettre à jour si vous utilisez la commande createApplication),
* *includedPath* : c'est un array, il contient la liste des répertoires délivrés par le module,
* *lang* : c'est un array, il contient la liste des langues pour lesquels les catalogues sont produits,
* *toolsPath* : c'est un objet, il contient la liste des références (path) aux outils externes utilisés par le module. Pour l'instant, un seul outil est requis `gettext`. Vous devez mettre cet élément à jour si vous ne pouvez pas ajouter `gettext` à votre `PATH` courant,
* *csvParam* : la majorité des fichiers de configuration de Dynacase sont en CSV, ces options indique les paramètres du CSV.

**Attention** : Tous répertoire qui n'est ni dans la liste des applications, ni dans celles des included path n'est pas inclus dans le webinst et donc pas déployé sur le serveur.

## Utilisation avancée {#quickstart:c5c3fc85-44b9-48c8-a522-91afe6975787}

Si vous souhaitez customiser les commandes, vous pouvez télécharger [le dépôt][url_depot], celui-ci contient l'ensemble du code. Avant de l'utiliser vous devez télécharger ses dépendances avec [composer][php_composer].


<!-- links -->
[php_phar]: http://php.net/manual/en/intro.phar.php
[url_toolkit]: https://github.com/cbonnissent/dynacase-devTools/raw/master/dynacase-devtool.phar
[url_depot]: https://github.com/cbonnissent/dynacase-devTools
[php_composer]: https://getcomposer.org/
[url_win_toolkit]: https://docs.anakeen.com/dynacase/3.2/quick-start/dynacase-devtool-win32.zip
[url_linux_toolkit]: https://docs.anakeen.com/dynacase/3.2/quick-start/dynacase-devtool.phar
