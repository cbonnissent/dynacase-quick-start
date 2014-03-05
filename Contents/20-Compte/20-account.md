# Initialisation des comptes

## Objectifs

* Utiliser l'interface d'administration pour initialiser des comptes,
* Exporter les comptes,
* Initialiser des comptes à l'aide des formats d'exports,
* Produire le paquet `webinst` en important les comptes nouvellement créé.

## Cadre

Lors de la phase de spécification, les éléments suivants ont été identifiés. Votre application va nécessiter :

* les rôles suivants :
    * Responsable des audits,
    * Auditeurs,
    * Administrateur fonctionnel.
+ les groupes suivants :
    + Utilisateurs COGIP,
    + Siège de COGIP,
    + Les 90 sites de la COGIP,
    + DSI,
    + Section Risque Opérationnel et Qualité.

De plus, l'application doit être initialisée avec les utilisateurs suivants :

* Jean Martin : membre de la section Risque Opérationnel et Qualité et auditeur,
* Priscilla Arthaud : membre de la section Risque Opérationnel et Qualité et auditeur,
* Arnaud Luc : membre de la section Risque Opérationnel et Qualité et auditeur,
* Karine Marthe : membre de la section Risque Opérationnel et Qualité et auditeur, responsable des audit et administrateur fonctionnel,
* Marina Arnic : responsable de la DSI et administrateur fonctionnel.

## Initialisation du premier utilisateur

Pour commencer à initialiser les différents type de compte le plus simple et d'utiliser l'interface web. Pour ce faire, veuillez vous rendre sur l'interface d'administration :

`http://<nomDeDomaine>/admin.php`

Et veuillez cliquer sur `Gestion des utilisateurs`

![ Création d'utilisateur ](20-10-users.png "Création d'utilisateurs")

Cette interface permet de créer des utilisateurs, des groupes et des rôles.

NB : Vous pouvez replier la partie gauche de l'interface en cliquant sur le bouton tout en haut à gauche.

Pour créer un utilisateur, veuillez cliquer sur le bouton `Créer un utilisateur`, l'interface de création apparaît :

![ Création d'utilisateur ](20-10-creation-user.png "Création d'utilisateur")

Veuillez compléter le formulaire en indiquant, le nom, le prénom, login, le mail et le mot de passe de l'utilisateur, dans notre cas :

* nom : Martin
* prénom : Jean
* mail : martin.jean@quickstartcogip.com
* login : martin.jean
* mot de passe : p@ssw0rd

Ensuite cliquez sur le bouton `Créer`.

Votre utilisateur est ajouté et il vous est affiché.

![ Création d'utilisateur ](20-10-creation-user-done.png "Création d'utilisateur")

Les utilisateurs ont quelques spécificités, vous pouvez :

* modifier les groupes dans lequel l'utilisateur est présent (via le menu `Gestion du compte`),
* ajouter un suppléant à l'utilisateur en cours, le suppléant possède tous les droits de l'utilisateur,
* indiquer une date d'expiration du compte, passé cette date le compte est désactivé et l'utilisateur ne peut plus se connecter à plateforme,
* désactiver le compte à l'aide du menu `Compte`.

## Export du premier utilisateur

### Mise en place du nom logique

Vous allez maintenant exporter cet utilisateur pour pouvoir l'importer avec le paquet d'installation.

Tous les éléments nécessaires au paramétrage de l'application doivent être importés pour permettre l'installation de l'application dans divers environnement (développement, pré-production, production).

Pour pouvoir référencer l'utilisateur de manière unique entre les différents contextes, vous allez lui attribuer un **nom logique**. Le nom logique est un identifiant sous la forme d'une chaîne de caractères qui doit être unique au sein du contexte et permet de retrouver le document.

Vous devez cliquer sur le menu `Autres` et le sous-menu `Propriétés` de la fiche utilisateur.

Le formulaire suivant est affiché :

![ Utilisateur : nom logique ](20-10-user-logical-name.png "Utilisateur : nom logique")

Pour compléter le nom logique, veuillez cliquer sur `affecter un nom logique`. Un champ apparaît et vous allez rentrer le nom logique `USER_JEAN_MARTIN` et ensuite cliquer sur `Nom à appliquer`.

L'interface de saisie du nom logique est présentée à nouveau avec cette fois ci le nom logique affiché en son centre.

Veuillez fermer la fenêtre de propriétés.

### Export du document

Vous allez maintenant exporter le document. Veuillez cliquer sur `Autres` et ensuite sur `Ajouter au porte document`.

La fenêtre suivante s'ouvre :

![ Utilisateur : export ](20-10-user-export.png "Utilisateur : export")

Cette fenêtre affiche les documents qui vont être exportés.

Veuillez ensuite cliquer sur `Outils` `Exportation du dossier`, la fenêtre suivante s'ouvre :

![ Utilisateur : export ](20-10-user-export2.png "Utilisateur : export")

NB : Si la fenêtre ne s'ouvre pas, veuillez regarder dans l'application `Gestion des documents` `Explorateur de documents`.

Veuillez cliquer sur `Exporter` en laissant les options par défaut.

Un fichier CSV vous est proposé au téléchargement, celui-ci est encodé avec les paramètres suivants :

* Jeu de caractères : `UTF8`,
* Séparateur de cellule : `;`,
* Séparateur de texte : `` (chaîne vide).

Le logiciel conseillé pour ouvrir ces documents est libre office. Sous ce logiciel, le fenêtre de paramétrage avant ouverture du fichier est :

![ Utilisateur : export ](20-10-user-export3.png "Utilisateur : export")

Vous retrouvez ensuite le contenu suivant :

![ Utilisateur : CSV ](20-10-user-export4.png "Utilisateur : CSV")

Ce fichier contient l'ensemble des valeurs contenues dans la fiche utilisateur (à l'exception des mots de passe qui étant encodés en base ne sont pas exportables).

### Format d'export

Le format d'export CSV repose sur quelques mots clefs, les deux mots utilisés dans le fichier produit sont :

* `DOC` : le mot clef doc indique que toute la ligne contient des valeurs à associer à un document existant ou à créer,
* `ORDER` : le mot clef order indique à quoi correspond le contenu de chaque colonne.

Vous devez ensuite supprimer les colonnes qui ne sont pas utiles.

NB : **Il est nécessaire de supprimer au moins la colonne us_whatid**, en effet cette colonne contient la référence interne vers l'utilisateur et elle n'est d'aucune utilité et cause des incompatibilité à l'import sur une autre base.

Dans notre cas, vous allez conserver uniquement les colonnes correspondant aux éléments que vous avez complété ci-dessus soit :

* les 4 premières colonnes,
* Nom : `us_lname`,
* Prénom : `us_fname`,
* Mail : `us_mail`,
* Login : `us_login`,
* Nouveau mot de passe : `us_passwd1`,
* Confirmation mot de passe : `us_passwd2`.

Une fois le fichier nettoyé vous obtenez les lignes suivantes :

![ Utilisateur : CSV ](20-10-user-export5.png "Utilisateur : CSV")

Vous devez ensuite enregistrer le fichier dans les sources du projet que vous avez initialisé précédemment. Utilisez la sauvegarde de votre tableur, les options de sauvegarde doivent être similaire à celle de lecture, soit :

* Jeu de caractères : `UTF8`,
* Séparateur de cellule : `;`,
* Séparateur de texte : `` (chaîne vide).

Sauvez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `IUSER_INIT_DATA.csv`.

NB : Le nom est normalement laissé à votre appréciation. Dans le cadre de ce tutoriel, nous utilisons une nomenclature qui vous est présentée dans le premier tutoriel sur la création d'une famille.

Il vous reste à ajouter l'instruction d'import du fichier dans le fichier info.xml. Ce fichier indique les actions que le paquet fait lors de son installation et de sa mise à jour, dans ce cas vous allez indiquez que souhaitez que le fichier soit importé lors de l'installation, vous allez donc ajouter la ligne suivante :

`<process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>`

entre les lignes :

    <process command="programs/record_application COGIP_AUDIT" />
    <process command="programs/update_catalog" />

## Ajout des autres utilisateurs

Vous pouvez utiliser la même technique pour créer les autres utilisateurs mais ce fonctionnement est assez vite fastidieux. Vous allez donc créer les autres utilisateurs directement en modifiant le fichier `IUSER_INIT_DATA.csv`.

Pour ce faire ouvrez le et faite un copié-collé de la première ligne commençant par DOC (ligne 3) et vous complétez avec le listing d'utilisateurs identifiés pendant la phase de spécification.

Vous devez obtenir un résultat similaire à : 

![ Utilisateur : CSV ](20-10-user-export6.png "Utilisateurs : CSV")

Au prochain import de votre paquet, si vous choisissez la stratégie d'initialisation les utilisateurs que vous avez défini ici seront ajoutés à la base.

## Création des groupes

Vous allez maintenant créer les groupes. La procédure est similaire à celle des utilisateurs.

Pour cela, retournez dans l'interface d'administration et cliquez sur gestion des utilisateurs et ensuite sur tous les groupes.

![ Groupe ](20-10-group-creation.png "Groupe")

Appuyez ensuite sur `Créer un groupe d'utilisateur`, un formulaire est affiché. Vous devez compléter les deux champs obligatoires :

* Nom : Utilisateurs COGIP,
* Identifiant : GRP_USER_COGIP.

Appuyez ensuite sur le bouton `Créer`.

Ajouter un nom logique à ce groupe, `Autres` `Propriétés` `Affecter un nom logique`.

* Nom logique : GRP_USER_COGIP

Ensuite, vous allez exporter le groupe, `Autres` `Ajouter au porte-documents`. Le porte documents s'ouvre :

![ Groupe ](20-10-group-creation2.png "Groupe")

Vous pouvez remarquer qu'il reste dans le porte document le document que vous avez sélectionné précédemment `Martin Jean`. En effet, le porte document permet d'exporter plusieurs documents en une seule fois. Dans votre cas, vous allez l'enlever du porte document, en faisant un clique droit sur le document `Martin Jean` et en cliquant dans le menu `Supprimer la référence`.

Cliquez ensuite sur `Outils` `Exportation du dossier` et sur le bouton `Exporter` dans l'interface suivante.

Un fichier CSV vous est retourné comme précédemment.

Ouvrez le et comme précédemment vous allez supprimer les colonnes non nécessaires, vous n'allez garder que les colonnes :

* les 4 premières colonnes,
* Nom : `gr
Sauvez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `IGROUP_INIT_DATA.csv`.

Ensuite, ajoutez dans le fichier info.xml l'instruction suivante :

`<process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>`

Les groupes contenant les utilisateurs, ils doivent être importés avant les utilisateurs.

ce qui donne pour la procédure d'installation :

    <process command="programs/record_application COGIP_AUDIT" />
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
    <process command="programs/update_catalog" />

Vous allez maintenant créer les autres groupes, de la même manière que pour les utilisateurs en copiant collant la 3em ligne.

Vous obtenez un listing semblable au suivant :

![ Liste des groupes ](20-10-group-creation3.png "Liste des groupes")

Vous allez maintenant construire la hiérarchie des groupes, la colonne `D` permet d'indiquer qu'un groupe est contenu dans un autre. Tous les groupes sont contenus dans le groupe `GRP_USER_COGIP`, vous allez donc compléter la colonne `D` pour l'indiquer.

Vous obtenez un listing semblable au suivant :

![ Liste des groupes ](20-10-group-creation4.png "Liste des groupes")

NB : Vous pouvez associer un groupe à plusieurs groupe parent en dupliquant la ligne le définissant jusqu'à la colonne `D`.

## Association des utilisateurs aux groupes

L'association des utilisateurs aux groupes se passe de la même manière. Veuillez ouvrir le fichier `IUSER_INIT_DATA.csv` et compléter la colonne `D` pour indiquer pour chaque utilisateur à quel groupe il appartient.

Soit :

* `USER_JEAN_MARTIN` : `GRP_QUALITE_COGIP`,
* `USER_PRISCILLA_ARTHAUD` : `GRP_QUALITE_COGIP`,
* `USER_ARNAUD_LUC` : `GRP_QUALITE_COGIP`,
* `USER_KARINE_MARTHE` : `GRP_QUALITE_COGIP`,
* `USER_MARINA_ARNIC` : `GRP_DSI_COGIP`.

et sauvez le fichier.

## Création des rôles

Vous allez maintenant créer les rôles. La procédure est similaire à celle des utilisateurs.

Pour cela, retournez dans l'interface d'administration et cliquez sur gestion des utilisateurs et ensuite sur tous les rôles.

![ Rôle ](20-10-role-creation.png "Rôle")

Appuyez ensuite sur `Créer un Rôle`, un formulaire est affiché. Vous devez compléter les deux champs obligatoires :

* Libellé : Responsable des audits.

Appuyez ensuite sur le bouton `Créer`.

Ajouter un nom logique à ce groupe, `Autres` `Propriétés` `Affecter un nom logique`.

* Nom logique : GRP_RESPONSABLE_AUDITS

Ensuite, vous allez exporter le groupe, `Autres` `Ajouter au porte-documents`. Le porte documents s'ouvre :

Vous pouvez remarquer qu'il reste dans le porte document le document que vous avez sélectionné précédemment `Utilisateurs COGIP`. Dans votre cas, vous allez l'enlever du porte document, en faisant un clique droit sur le document `Utilisateurs COGIP` et en cliquant dans le menu `Supprimer la référence`.

Cliquez ensuite sur `Outils` `Exportation du dossier` et sur le bouton `Exporter` dans l'interface suivante.

Un fichier CSV vous est retourné comme précédemment.

Ouvrez le et comme précédemment vous allez supprimer les colonnes non nécessaires, vous n'allez garder que les colonnes :

* les 4 premières colonnes,
* Référence : `role_login`,
* Libellé : `role_name`.

Sauvez le fichier dans le répertoire `COGIP_AUDIT` sous le nom `ROLE_INIT_DATA.csv`.

Ensuite, ajoutez dans le fichier info.xml l'instruction suivante :

`<process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>`

Les rôles pouvant être associés aux groupes et aux utilisateurs, ils doivent être importés en premier.

Ce qui donne pour la procédure d'installation :

    <process command="programs/record_application COGIP_AUDIT" />
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
    <process command="programs/update_catalog" />

Vous allez maintenant de la même manière que précédemment initier les autres rôles en dupliquant la ligne contenant l'instruction `DOC`.

En ajoutant les rôles définis lors de la phase de spécification, on obtient :

![ Rôle ](20-10-role-creation2.png "Rôle")

### Association des rôles aux groupes et utilisateurs

Vous allez maintenant conclure la partie pratique de ce chapitre en associant les rôles aux utilisateurs et aux groupes.

Cette association se fait dans les fichiers de définition des groupes et des utilisateurs.

Vous allez donc ouvrir le fichier `IUSER_INIT_DATA.csv`. Vous allez ajouter une colonne après la colonne `us_passwd2` que vous allez nommer `us_roles`. Cette colonne contient la liste des rôles associés à un utilisateur séparé par des `\n`.

En suivant, l'étape d'analyse décrite en début de chapitre, vous avez les liens suivants à établir :

* Karine Marthe : responsable des audit et administrateur fonctionnel,
* Marina Arnic : Administrateur fonctionnel.

Ce qui donne le résultat suivant : 

![ Rôle association ](20-10-role-association.png "Rôle association")

Pour les groupes, vous devez ouvrir le fichier `IGROUP_INIT_DATA.csv` et de la même manière ajouter une colonne `grp_roles`.

En reprenant l'analyse, on voit que tous les membres du groupe `Section Risque Opérationnel et Qualité` sont auditeurs, vous allez donc affecter le rôle à ce groupe :

