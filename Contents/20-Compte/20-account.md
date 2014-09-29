# Initialisation des comptes {#quickstart:b4800208-9c02-45bc-badc-9948c2277eae}

## Objectifs {#quickstart:d3ca62ec-47fb-42a9-8402-3c580a6382f7}

-   Utiliser l'interface d'administration pour initialiser des comptes,
-   Exporter les comptes,
-   Initialiser des comptes à l'aide des formats d'exports,
-   Produire le paquet `webinst` en important les comptes.

## Cadre {#quickstart:fdbc640b-3030-45f5-ad2f-486d3eead6c3}

Lors de la phase de spécification, les éléments suivants ont été identifiés. L'application nécessite :

-   les _rôles_ :
    -   Responsable des audits,
    -   Auditeurs,
    -   Administrateur fonctionnel.
-   les _groupes_ :
    -   Utilisateurs COGIP,
    -   DSI,
    -   Section Risque Opérationnel et Qualité.

De plus, une bonne pratique est de faire le lien entre les _utilisateurs_ et les _rôles_ au travers des _groupes_. Nous allons donc également créer les groupes suivants :

-   Responsable des audits,
-   Auditeurs,
-   Administrateur fonctionnel.

De plus, l'application doit être initialisée avec les utilisateurs suivants :

-   Jean Martin :
    -   section Risque Opérationnel et Qualité,
    -   auditeur,
-   Priscilla Arthaud : 
    -   section Risque Opérationnel et Qualité,
    -   auditeur,
-   Arnaud Luc : 
    -   section Risque Opérationnel et Qualité,
    -   auditeur,
-   Karine Marthe : 
    -   section Risque Opérationnel et Qualité,
    -   auditeur,
    -   responsable des audit,
    -   administrateur fonctionnel,
-   Marina Arnic :
    -   responsable de la DSI,
    -   administrateur fonctionnel.

## Initialisation du premier utilisateur {#quickstart:653a946b-9655-4728-9c65-50c90bb771df}

Pour initialiser les différents types de comptes, vous pouvez utiliser l'interface web.
Veuillez vous rendre sur l'interface d'administration : `http://<nomDeDomaine>/admin.php`

Et cliquer sur `Gestion des utilisateurs`

![ Création d'utilisateur ](20-10-users.png "Création d'utilisateurs")

Cette interface permet de créer des utilisateurs, des groupes et des rôles.

<span class="flag inline nota-bene"></span> Vous pouvez replier la partie gauche de l'interface en cliquant sur le
bouton tout en haut à gauche.

Pour créer un utilisateur, veuillez cliquer sur le bouton `Créer un utilisateur`, l'interface de création apparaît :

![ Création d'utilisateur ](20-10-creation-user.png "Création d'utilisateur")

Veuillez compléter le formulaire en fournissant les nom, prénom, login, mail et mot de passe de l'utilisateur :

-   _nom_ : `Martin`,
-   _prénom_ : `Jean`,
-   _mail_ : `martin.jean@quickstartcogip.com`,
-   _login_ : `martin.jean`,
-   _mot de passe_ : `p@ssw0rd`.

Ensuite cliquez sur le bouton `Créer`.

Votre utilisateur est ajouté et est affiché.

![ Création d'utilisateur ](20-10-creation-user-done.png "Création d'utilisateur")

Les utilisateurs ont quelques spécificités, vous pouvez :

-   modifier les groupes dans lequel l'utilisateur est présent (via le menu `Gestion du compte`),
-   ajouter un suppléant à l'utilisateur en cours, le suppléant possède tous les droits de l'utilisateur,
-   indiquer une date d'expiration du compte, passé cette date le compte est désactivé et l'utilisateur
    ne peut plus se connecter à plateforme,
-   désactiver le compte à l'aide du menu `Compte`.

## Export du premier utilisateur {#quickstart:137414aa-e378-4ece-b343-6e0ddc4d27c0}

Vous allez maintenant exporter cet utilisateur pour pouvoir l'importer avec le paquet d'installation.

Tous les éléments nécessaires au paramétrage de l'application doivent être importés pour permettre les installations et
mises à jour de l'application dans divers environnements (développement, pré-production, production).

### Mise en place du nom logique {#quickstart:6124a031-bc16-4182-ae7e-9b659b918905}

Pour pouvoir référencer l'utilisateur entre les différents contextes, vous allez lui attribuer un **nom logique**.
Le nom logique (chaîne de caractères) est un identifiant unique au sein d'un contexte. Il permet de retrouver le document.

Vous devez cliquer sur le menu `Autres` et le sous-menu `Propriétés` de la fiche utilisateur.

Le formulaire suivant est affiché :

![ Utilisateur : nom logique ](20-10-user-logical-name.png "Utilisateur : nom logique")

Pour compléter le nom logique, veuillez cliquer sur `affecter un nom logique`.
Un champ apparaît et vous allez saisir le nom logique `USER_JEAN_MARTIN` et ensuite cliquer sur `Nom à appliquer`.

L'interface de saisie du nom logique est présentée à nouveau avec cette fois le nom logique affiché en son centre.

Veuillez fermer la fenêtre de propriétés.

#### Export  {#quickstart:3fee7d00-3ee4-4ced-ba78-b6c37e36ad6d}

Vous allez maintenant exporter le document. Veuillez cliquer sur `Autres` et ensuite sur `Ajouter au porte-document`.

<span class="flag inline nota-bene"></span>  Si jamais la fonctionnalité `Ajouter au porte-document` n'est pas présente,
veuillez vous rendre dans l'application `Gestion des documents` > `Explorateur de documents` et revenez ensuite sur 
l'application `Gestion des utilisateurs`.

La fenêtre suivante s'ouvre :

![ Utilisateur : export ](20-10-user-export.png "Utilisateur : export")

Cette fenêtre affiche les documents qui vont être exportés.

Veuillez ensuite cliquer sur `Outils > Exportation du dossier`, la fenêtre suivante s'ouvre :

![ Utilisateur : export ](20-10-user-export2.png "Utilisateur : export")

Veuillez cliquer sur `Exporter` en laissant les options par défaut.

Un fichier CSV vous est proposé au téléchargement, celui-ci est encodé avec les paramètres suivants :

-   Jeu de caractères : `UTF8`,
-   Séparateur de cellule : `;`,
-   Séparateur de texte : ``.

Le logiciel conseillé pour ouvrir ces documents est Libre Office. Avec ce logiciel, le fenêtre de paramétrage avant ouverture du fichier est :

![ Utilisateur : export ](20-10-user-export3.png "Utilisateur : export")

Vous retrouvez ensuite le contenu suivant :

![ Utilisateur : CSV ](20-10-user-export4.png "Utilisateur : CSV")

Ce fichier contient l'ensemble des valeurs contenues dans la fiche utilisateur à l'exception des mots de passe qui,
étant encodés en base, ne sont pas exportables.

### Format d'export {#quickstart:9f1e3e32-bb48-4e6b-807a-37ff31c0f705}

Le format d'export CSV repose sur quelques mots clefs, les deux mots utilisés dans le fichier produit sont :

-   `DOC` : le mot clef doc indique que toute la ligne contient des valeurs à associer à un document existant ou à créer,
-   `ORDER` : le mot clef order indique à quoi correspond le contenu de chaque colonne.

Vous devez ensuite supprimer les colonnes qui ne sont pas utiles.

<span class="flag inline nota-bene"></span> **Il est nécessaire de supprimer au moins la colonne `us_whatid`**.
En effet cette colonne contient la référence interne vers l'utilisateur.
Elle n'est d'aucune utilité et cause des incompatibilités à l'import sur une autre base.

Dans notre cas, vous allez conserver uniquement les colonnes correspondant aux éléments que vous avez complétés ci-dessus, soit :

-   les 4 premières colonnes,
-   _Nom_ : `us_lname`,
-   _Prénom_ : `us_fname`,
-   _Mail_ : `us_mail`,
-   _Login_ : `us_login`,
-   _Nouveau mot de passe_ : `us_passwd1`,
-   _Confirmation mot de passe_ : `us_passwd2`.

Une fois le fichier nettoyé vous obtenez les lignes suivantes :

![ Utilisateur : CSV ](20-10-user-export5.png "Utilisateur : CSV")

Vous devez ensuite enregistrer le fichier dans les sources du projet que vous avez initialisé précédemment.
Utilisez la sauvegarde de votre tableur, les options de sauvegarde doivent être similaire à celle de lecture :

-   Jeu de caractères : `UTF8`,
-   Séparateur de cellule : `;`,
-   Séparateur de texte : ``.

Sauvez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `IUSER__INIT_DATA.csv`.

<span class="flag inline nota-bene"></span> Le nom est normalement laissé à votre appréciation.
Dans le cadre de ce tutoriel, nous utilisons une nomenclature qui vous est présentée en [annexe][annexe].

Il vous reste à ajouter l'instruction d'import du fichier dans le fichier `info.xml`. 

Ce fichier déclare les actions réalisées lors de l'installation ou la mise à jour du paquet. 
Vous allez donc ajouter la ligne suivante pour demander l'import des utilisateurs :

    [xml]
    <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IUSER__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>

entre les lignes de la partie installation (`post-install`):

    [xml]
    <process command="programs/record_application COGIP_AUDIT" />
    <process command="programs/update_catalog" />

Le fichier CSV complété peut-être consulté [ici][source_iuser].

## Ajout des autres utilisateurs {#quickstart:28c4dbb7-97ea-4902-94ca-7e04db2d6d43}

Vous pouvez utiliser l'interface pour créer les autres utilisateurs. Ce fonctionnement est assez vite fastidieux.
Vous allez donc créer les autres utilisateurs directement en modifiant le fichier `IUSER__INIT_DATA.csv`.

Ouvrez le et faites un copié collé de la première ligne commençant par DOC (ligne 3) et vous complétez avec le listing
d'utilisateurs identifiés pendant la phase de spécification.

<span class="flag inline nota-bene"></span> Le nom logique (colonne 3) doit être unique pour
chaque utilisateur. Il faut donc penser à changer le nom logique des lignes ainsi obtenues, en plus des éléments
tels que nom, prénom…

Vous devez obtenir un résultat similaire à :

![ Utilisateur : CSV ](20-10-user-export6.png "Utilisateurs : CSV")

Au prochain import de votre paquet, si vous choisissez la stratégie d'initialisation, les utilisateurs que vous avez
ajoutés ici seront ajoutés à la base.

Le fichier CSV complété peut-être consulté [ici][source_iuser].

<span class="flag inline nota-bene"></span> Vous pouvez à tout moment générer le fichier `webinst` via la commande :

`php <path_to_devtool>/devtool.phar generateWebinst -s .`

et le déployer en choississant la stratégie d'initialisation pour tester l'ajout des utilisateurs.

Si vous déployez, vous aurez la liste suivante :

![ Groupe ](20-10-user-imported.png "Utilisateur après importation")

## Création des groupes {#quickstart:78e478c8-e1bf-4766-9ae1-de45e13e3068}

Vous allez maintenant créer les groupes. La procédure est similaire à celle de création d'utilisateurs.

Retournez dans l'interface d'administration, cliquez sur gestion des utilisateurs et ensuite sur `tous les groupes`.

![ Groupe ](20-10-group-creation.png "Groupe")

Appuyez ensuite sur `Créer un groupe d'utilisateur`, un formulaire est affiché. Vous devez compléter les deux champs obligatoires :

-   _Nom_ : `Utilisateurs COGIP`,
-   _Identifiant_ : `GRP_USER_COGIP`.

Appuyez ensuite sur le bouton `Créer`.

Ajoutez un nom logique à ce groupe, `Autres > Propriétés > Affecter un nom logique`.

-   Nom logique : `GRP_USER_COGIP`

Ensuite, vous allez exporter le groupe, `Autres > Ajouter au porte-documents`. Le porte-documents s'ouvre :

![ Groupe ](20-10-group-creation2.png "Groupe")

Vous pouvez remarquer qu'il reste dans le porte-documents l'utilisateur précédemment sélectionné.
Le porte-documents permet d'exporter plusieurs documents en une seule fois.
Dans votre cas, vous allez l'enlever du porte-documents, en faisant un clic droit sur le document `Martin Jean` et en
cliquant sur le menu `Supprimer la référence`.

Cliquez ensuite sur `Outils > Exportation du dossier` et sur le bouton `Exporter` dans l'interface suivante.

Un fichier CSV vous est retourné comme précédemment.

Ouvrez le et supprimez les colonnes non nécessaires pour ne garder que :

-   les 4 premières colonnes,
-   la colonne _Nom_ : `grp_name`,
-   la colonne _Identifiant_ : `us_login`.

Enregistrez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `IGROUP__INIT_DATA.csv`.

Ensuite, ajoutez dans le fichier `info.xml` l'instruction suivante :
`<process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IGROUP__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>`

Les groupes contenant les utilisateurs, ils doivent être importés *avant* les utilisateurs.

Ce qui donne l'ordre suivant pour la procédure d'installation :

        <process command="programs/record_application COGIP_AUDIT"/>
        <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IGROUP__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IUSER__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
        <process command="programs/update_catalog"/>

Pour créer les autres groupes, de la même manière que pour les utilisateurs, vous pouvez dupliquer la 3ème ligne.

Vous obtenez un listing semblable au suivant :

![ Liste des groupes ](20-10-group-creation3.png "Liste des groupes")

Vous devez maintenant construire la hiérarchie des groupes. La colonne `D` permet d'indiquer qu'un groupe est contenu dans un autre.
Tous les groupes sont contenus dans le groupe `GRP_USER_COGIP`, vous allez donc compléter la colonne `D` pour l'indiquer.

Vous allez donc indiquer que :

* le groupe `Utilisateurs COGIP` est contenu dans le groupe par défaut (`GDEFAULT`),
* les autres groupes appartiennent à `Utilisateurs COGIP`.

Vous obtenez un listing semblable au suivant :

![ Liste des groupes ](20-10-group-creation4.png "Liste des groupes")

<span class="flag inline nota-bene"></span> Vous pouvez associer un groupe à plusieurs groupes parents.
La ligne définissant le groupe est dupliquée en ne conservant que les quatre premières colonnes.
La colonne `D` est modifiée avec le nouveau groupe parent. Vous pouvez effectuer cette opération autant de fois que nécessaire.

Une fois l'ensemble des manipulations effectuées, le fichier doit être semblable à [celui-ci][source_igroup].

Si vous générez le webinst et que vous l'installez en choisissant l'option `Install`, vous aurez ensuite le listing suivant :

![ Liste des groupes ](20-10-group-creation5.png "Liste des groupes")

## Association des utilisateurs aux groupes {#quickstart:0ac2eeca-c96e-46fc-b79f-4bf77404cc93}

L'association des utilisateurs aux groupes se passe de la même manière. Veuillez ouvrir le fichier `IUSER__INIT_DATA.csv`
et compléter la colonne `D` pour indiquer pour chaque utilisateur à quel groupe il appartient.

Soit :

-   `USER_JEAN_MARTIN` : `GRP_QUALITE_COGIP`,
-   `USER_PRISCILLA_ARTHAUD` : `GRP_QUALITE_COGIP`,
-   `USER_ARNAUD_LUC` : `GRP_QUALITE_COGIP`,
-   `USER_KARINE_MARTHE` : `GRP_QUALITE_COGIP`,
-   `USER_MARINA_ARNIC` : `GRP_DSI_COGIP`.

et sauvez le fichier. Celui peut-être consulté [ici](https://github.com/Anakeen/dynacase-quick-start-code/blob/user-add-group/COGIP_AUDIT/IUSER__INIT_DATA.csv).

## Création des rôles {#quickstart:1a5c2498-c522-491b-a7a3-f73d03b13116}

Vous allez maintenant créer les rôles. La procédure est similaire à celle de création des utilisateurs.

Pour cela, retournez dans l'interface d'administration, cliquez sur gestion des utilisateurs et ensuite sur `tous les rôles`.

![ Rôle ](20-10-role-creation.png "Rôle")

Appuyez ensuite sur `Créer un Rôle`, un formulaire est affiché. Vous devez compléter le champ obligatoire :

-   _Libellé_ : `Responsable des audits`.

Appuyez ensuite sur le bouton `Créer`.

Ajouter un nom logique à ce rôle, `Autres > Propriétés > Affecter un nom logique`.

-   _Nom logique_ : `ROLE_RESPONSABLE_AUDITS`

Ensuite, vous allez exporter le rôle, `Autres > Ajouter au porte-documents`. Le porte-documents s'ouvre :

Pensez à supprimer du porte-documents le groupe précédemment ajouté en faisant un clic droit sur le document  et en cliquant sur le menu `Supprimer la référence`.

Cliquez ensuite sur `Outils > Exportation du dossier` et sur le bouton `Exporter` dans l'interface suivante.

Un fichier CSV vous est retourné.

Ouvrez le et supprimez les colonnes inutiles, pour ne garder que :

-   les 4 premières colonnes,
-   _Référence_ : `role_login`,
-   _Libellé_ : `role_name`.

Sauvez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `ROLE__INIT_DATA.csv`.

Ensuite, ajoutez dans le fichier info.xml l'instruction suivante : 
`<process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/ROLE__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>`

Les rôles pouvant être associés aux groupes et aux utilisateurs, ils doivent être importés en premier.

Ce qui donne pour la procédure d'installation :

    <process command="programs/record_application COGIP_AUDIT"/>
    <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/ROLE__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
    <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IGROUP__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
    <process command='./wsh.php --api=importDocuments  --file=./COGIP_AUDIT/IUSER__INIT_DATA.csv --csv-separator=&apos;;&apos;'/>
    <process command="programs/update_catalog"/>

En procédant comme pour les utilisateurs ou les groupes, vous allez initialiser les autres rôles (duplication de la ligne contenant l'instruction `DOC`).

Les rôles sont les suivants :

-   Responsable des audits : `ROLE_RESPONSABLE_AUDITS`,
-   Auditeurs : `ROLE_AUDITEUR`,
-   Administrateur fonctionnel : `ROLE_AUDITEUR`.

Après ajout des rôles définis lors de la phase de d'analyse, on obtient :

![ Rôle ](20-10-role-creation2.png "Rôle")

Une fois initialisé le fichier de rôle est semblable à [celui-ci](https://github.com/Anakeen/dynacase-quick-start-code/blob/init-role/COGIP_AUDIT/ROLE__INIT_DATA.csv).

### Association des rôles aux groupes et utilisateurs {#quickstart:e946f46a-9d47-4f44-a61d-45248f47ce62}

Vous allez maintenant conclure la partie pratique de ce chapitre en associant les rôles aux utilisateurs et aux groupes.

<span class="flag inline nota-bene"></span> Afin de garantir une meilleure évolutivité de l'application, il est recommandé
de passer par un _groupe_ pour faire l'association entre _utilisateurs_ et _rôles_. Ainsi, les
administrateurs n'ont pas à gérer les rôles, mais uniquement l'appartenance des utilisateurs aux groupes.

Cette association se fait dans les fichiers de définition des groupes.

Dans le fichier `IGROUP__INIT_DATA.csv`, vous allez ajouter une colonne nommée `grp_roles` après la colonne `us_login`.

L'analyse a mis en évidence que les membres du groupe `Section Risque Opérationnel et Qualité` sont `auditeurs`.
Vous allez donc affecter le rôle à ce groupe.  

En ajoutant la valeur `ROLE_AUDITEUR` dans la nouvelle colonne à la ligne du document `GRP_QUALITE_COGIP`, vous associez le rôle et le groupe.
Tous les utilisateurs présents dans ce groupe posséderont donc ce rôle.

![ Rôle association ](20-10-role-association2.png "Association des rôles : groupes")

De plus, _Karine Marthe_ et _Marina Arnic_ sont _administrateur fonctionnel_, et _Karine Marthe_ est _responsable des audit_.

Pour associer, les utilisateurs au rôle, vous devez ouvrir le fichier `IUSER__INIT_DATA.csv` et ajouter la colonne `us_roles` après la colonne `us_passwd2`.

Et, vous allez compléter la nouvelle colonne avec les valeurs suivantes :

* pour `USER_KARINE_MARTHE` : `ROLE_RESPONSABLE_AUDITS\nROLE_ADMIN_FONCTIONNEL`,
* pour `USER_MARINA_ARNIC` : `ROLE_ADMIN_FONCTIONNEL`.

<span class="flag inline nota-bene"></span> Vous pouvez remarquez que l'association d'un compte à plusieurs rôle se fait
avec le séparateur `\n` entre deux rôles.

Ce qui donne le résultat suivant :

![ Rôle association : utilisateurs](20-10-user-role.png "Association des rôles : utilisateurs")

Vous pouvez retrouver les fichiers complété [ici](https://github.com/Anakeen/dynacase-quick-start-code/tree/associate_role_account/COGIP_AUDIT).

## Mise en place des modifications {#quickstart:c7522c13-68ab-47c7-b592-6c672b963820}

Vous allez maintenant déployer vos modifications. Il y a pour cela deux manières de faire :

-   vous pouvez construire le paquet `webinst` et le déployer en choisissant la stratégie `install`,
-   vous pouvez déployer manuellement les fichiers que vous avez produit à l'aide de l'interface d'administration.

<span class="flag inline nota-bene"></span> L'import manuel est destiné à des phases de développement, ou de test ou des importations ponctuelles.

Vous allez commencer par déployer manuellement le premier fichier.
Veuillez sélectionner dans l'interface d'administration `Gestion des documents > Importations de documents`.
L'interface présentée est la suivante :

![ Importation manuelle ](20-10-import.png "Importation manuelle")

Veuillez sélectionner votre fichier, `ROLE__INIT_DATA.csv`, et ensuite cliquer sur `Lancer l'analyse`.
La mécanique d'import manuel passe toujours par une phase d'analyse permettant de contrôler si un fichier est importable.

![ Importation manuelle : analyse ](20-10-import-valid.png "Importation manuelle : analyse")

Le fichier d'import est valide. L'analyse indique qu'un document est mis à jour manuellement et deux autres ajoutés.
Ce qui correspond à ce que vous avez fait en créant le premier document manuellement et créant les autres dans le fichier.

Cliquez ensuite sur `Importer les documents maintenant`. Le panneau de gauche se met à jour et vous indique le compte rendu de l'import.

Vous pouvez maintenant vous rendre dans la gestion des utilisateurs pour voir vos nouveaux utilisateurs.

![ Importation manuelle : résultat ](20-10-import-role.png "Importation manuelle : résultat")

Pour les deux autres éléments, vous allez produire le paquet.

    php <path_to_devtool>/devtool.phar generateWebinst -i .

Vous obtenez alors un fichier `webinst` que vous allez déployer en passant par Dynacase Control `http://<content>/dynacase-control/`.
Vous sélectionnez votre contexte et cliquez sur le bouton `Import module`. Choisissez la stratégie de déploiement `Install`.
Le paquet se déploie et vous pouvez voir vos différents fichiers `csv` qui sont traités.

Vous pouvez maintenant vous rendre dans la gestion des utilisateurs :

![ Importation : résultat ](20-10-import-result.png "Importation : résultat")

Vous pouvez voir que les groupes ont été ajoutés, l'arborescence respectée et les différents rôles associés.

<span class="flag inline nota-bene"></span>  Le recalcul de l'arborescence des groupes et des droits est asynchrone,
il peut y avoir un décalage de quelques minutes entre l'installation du paquet et l'arrivée des données sur le contexte.

## Conclusion {#quickstart:ebfe623e-99c3-4b85-92a5-a790685b3e7e}

Dans ce chapitre, vous avez parcouru l'ensemble des techniques pour créer, associer et importer les différents éléments
nécessaires à la gestion des comptes Dynacase.

Ces éléments vous serviront dans toutes les autres phases de vos projets pour fixer les droits, définir des vues particulières, etc.

## Pour aller plus loin {#quickstart:ff368e8d-9630-408d-9644-5383753f2ac0}

Vous pouvez consulter les chapitres suivants de la documentation :

-   [les comptes][docCompte],
-   [le format d'import CSV][formatCSV],
-   [les sources après le tutoriel][githubSourceAfter].

<!-- links -->

[githubSourceAfter]: https://github.com/Anakeen/dynacase-quick-start/archive/after_20_20.zip "Github : source après le tutoriel"
[docCompte]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:2bd98eec-5b03-4af0-b9d6-1bbf78fe9733.html "Doc Dynacase : Comptes"
[formatCSV] : https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:2fb3284a-2424-44b2-93ae-41dc3969e093.html "Doc Dynacase : CSV"
[annexe]:   #quickstart:69f091b6-34ef-47b0-a453-8e00676b7dcd
[source_iuser]: https://github.com/Anakeen/dynacase-quick-start-code/blob/init-iuser/COGIP_AUDIT/IUSER__INIT_DATA.csv
[source_igroup]: https://github.com/Anakeen/dynacase-quick-start-code/blob/init-group/COGIP_AUDIT/IGROUP__INIT_DATA.csv
