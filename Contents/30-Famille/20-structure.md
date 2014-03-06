# Mise en place des structures 

Ce chapitre va vous permettre d'initier vos première famille.

## Objectifs

* Créer une famille de base
* Créer les familles en utilisant l'héritage
* Initier les attributs
* Faire une première traduction
* Déployer votre module

## Cadre

L'analyse des besoins a montrer que votre application a besoin des familles suivantes :

* Site : Elle représente un site et permet d'identifier son directeur :
    * la description d'un site
    * une référence vers son directeur,
    * la description de son emplacement.
* Référentiel qualité : Elle représente un référentiel qualité :
    * la référence d'un référentiel qualité,
* Chapitre de référentiel : Elle représente un chapitre :
    * un lien vers la référence à un référentiel, 
    * un titre,
+ Audit : Elle représente un audit et contient :
    + le titre de l'audit,
    + sa date de début,
    + la liste des auditeurs,
    + un champ de descriptif,
    + une liste de référentiels,
    + une liste de points forts,
    + une liste de points faibles,
    + une liste de Fiche de Non Conformité,
    + une liste de fichier associée.
+ Fiche de non conformité : Elle représente une non conformité et contient :
    + le titre de la non conformité,
    + un lien vers la fiche de non conformité,
    + une liste de liens vers des chapitres,
    + une liste d'actions.

## Partie théorique

### Structure de famille

La structure d'une famille est définie par deux éléments :

* le fichier de structure : il contient la liste des attributs (type de donnée) que les documents de la famille contiennent, 
* l'héritage : si une famille hérite d'une autre, elle hérite de manière dynamique de tous les éléments de ses familles parentes.

La structure de la famille est utilisée en interne par Dynacase pour :

* créer la table de la base de donnée permettant de stocker les données,
* générer les formulaires de saisie des données,
* générer les formulaires de recherche de documents,
* générer les matrices de gestion de droits,
* etc.

## Création de votre première famille : Famille de base

Il est considéré comme une bonne pratique de commencer un projet Dynacase par une famille abstraite qui est mère de toutes les autres familles.  
Ceci permet de propager plus facilement des comportements spécifiques entre toutes les familles d'un projet. Par exemple, si vous souhaitez empêcher la duplication de tous les documents au sein de votre projet, vous pouvez le spécifier au niveau de la famille mère et le comportement est transmis à toutes les familles filles.

Veuillez ouvrir le **developper toolkit** et cliquez sur **Template** et ensuite **Create a family**, l'outil vous demande ensuite :

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

Dans la partie d'initialisation après l'import des utilisateurs, dans la partie d'upgrade après le `record_application`. Vous devrez avoir un fichier `info.xml` semblable à :

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

Cette famille reste vide pour l'instant.

## Création des fichiers de familles

Vous allez maintenant créer les familles de référentiels, reprenez l'outil **developper toolkit** et cliquez sur **Template** et ensuite **Create a family**. Ajoutez les options suivantes :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_SITE`,
* parent name : `COGIP_AUDIT_BASE`,
* [namespace][php_namespace] : `COGIP`.

Vous avez créé les fichiers de la famille `Site`.

Ensuite, la famille `Référentiel de qualité` :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `COPGIP_AUDIT_REFERENTIEL`,
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

Il faut maintenant les référencer dans le fichier `info.xml`. Pour ce faire, vous devez respecter l'ordre de l'héritage et importer en premier les familles mères et ensuite les familles filles. Si vous ne suivez pas un ordre adéquat, l'installeur refusera d'installer le paquet et vous indiquera la dépendances manquantes.

Votre `info.xml` contient les lignes suivantes :

    <post-install>
        <process command="programs/record_application COGIP_AUDIT" />
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_SITE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_SITE__PARAM.csv"/>
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
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_SITE__STRUCT.csv"/>
        <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_SITE__PARAM.csv"/>
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

## Ajout des attributs

Vous allez maintenant définir les [attributs][DocAttribut] contenus dans vos familles.

Vous allez commencer par la famille `Site`. Ouvrez le fichier `COGIP_AUDIT_SITE__STRUCT.csv`.

Le fichier se présente sous cette forme :

![ Contenu structure site ](30-20-structure-site.png "Contenu structure site")



## Voir aussi

* [Définition CSV d'une famille][DocFamCSV]

<!-- links -->

[php_namespace]: http://www.php.net/manual/en/language.namespaces.rationale.php "Doc PHP : namespace"
[DocFamCSV]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html "Documentation : structure du fichier de définition"
[DocAttribut]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4e167170-33ed-11e2-8134-a7f43955d6f3.html "Documentation : attribut"
[annexe]:   #quickstart:69f091b6-34ef-47b0-a453-8e00676b7dcd