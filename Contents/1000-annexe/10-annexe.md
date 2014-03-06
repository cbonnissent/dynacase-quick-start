# Annexe {#quickstart:f032dd5b-a7dc-47f7-b216-6a973a447dfd}

Ce chapitre contient différent éléments de références qui sont applicables pour tous les tutoriels.

## CSV {#quickstart:f32d9a77-43b1-4f10-b225-22daa1e0ba1b}

Le format standard de CSV de Dynacase est :

* encodage : `UTF8`,
* délimiteur de cellule : `;`,
* délimiteur de texte : `` (chaîne vide).

Ce format est valide pour l'import et pour l'export des documents et des familles avec l'action `importDocuments`.

## Convention de nommage {#quickstart:69f091b6-34ef-47b0-a453-8e00676b7dcd}

Module :

    ├── API/
    ├── <APPLICATION>
    │   ├── <APPLICATION>.app
    │   ├── <APPLICATION>_init.php
    │   ├── Images/
    │   ├── Layout/
    ├── EXTERNALS/
    ├── locale/
    ├── STYLE/
    ├── info.xml

Avec les éléments suivants :

* API contient les [scripts][docScript],
* EXTERNALS contient les [aide à la saisie][docHelper],
* STYLE contient les [styles][docStyle],
* locale contient les [traduction][doci18n],
* info.xml contient les instructions pour la mise à jour et l'upgrade,
* <APPLICATION> contient les fichiers associés à une application.

Famille :

* `<FAMILY_NAME>__STRUCT.csv` : Structure d'une famille,
* `<FAMILY_NAME>__CLASS.php` : Classe contenant le code métier d'une famille,
* `<FAMILY_NAME>__PARAM.csv` : Paramétrage d'une famille,
* `<FAMILY_NAME>_INIT_DATA.csv` : Documents d'initialisation appartenant à la famille `<FAMILY_NAME>`,
* `<FAMILY_NAME>__DATA.csv` : Documents appartenant à la famille `<FAMILY_NAME>`.

Action :

* `<APPLICATION>`/action.`<action_name>`.php : Fichier de contrôleur d'action,
* `<APPLICATION>`/Layout/`<action_name`.html : Template HTML d'une action.

## Script open office {#quickstart:c35b47c9-22d0-44c9-9bdd-0ddde39af53c}

Il existe un ensemble de scripts libre/openoffice pour faciliter le développement d'une famille.

Vous pouvez le trouver [ici][githubScriptOOO].

Le script s'intègre en passant par le menu `Macro` sous partie `Libre office basic`.

![ Ajout d'un script ](1000-10-add-script.png "Ajout d'un script")

Ensuite la fenêtre suivante s'ouvre :

![ Ajout d'un script ](1000-10-add-script2.png "Ajout d'un script")

Vous sélectionnez le module1 et le bouton `éditer`. L'écran suivant est affiché :

![ Ajout d'un script ](1000-10-add-script3.png "Ajout d'un script")

Et vous copié-collé le contenu du fichier référencé ci-dessus à la place du script existant.

Vous pouvez ensuite ajouter les scripts en modifiant les menus. Faite un clique droit sur la barre d'outil et sélectionnez l'option `Personnaliser la barre d'outil`.

<!-- style -->

[docScript]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1566c46d-a53d-44cf-8c3f-0d0e21c0b117.html#core-ref:4df1314f-9fdd-4a7f-af37-a18cc39f3505 "Documentation : Script"
[docHelper]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:0b2d4cd0-4eed-41d8-ac57-37525a444194.html#core-ref:0b2d4cd0-4eed-41d8-ac57-37525a444194 "Documentation : Aide à la saisie"
[docStyle]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1844a1a8-1406-47bd-a884-1a18ef0a6ca7.html "Documentation : Style"
[doci18n]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:8f3ad20a-4630-4e86-937b-da3fa26ba423.html "Documentation : traduction"
[githubScriptOOO]: https://raw.github.com/Anakeen/dynacase-quick-start/documentation/Contents/1000-annexe/script-openoffice.txt "Script open office"