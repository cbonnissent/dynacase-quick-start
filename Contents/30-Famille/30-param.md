# Paramétrage {#quickstart:b5501068-3412-4849-a1ac-4155272da2ad}

Dans ce chapitre, vous allez paramétrer les familles que vous avez créé dans le chapitre [structure][structure].

## Objectifs  {#quickstart:9fd3067d-5851-4306-9e1a-13eb626417d8}

* Mise en place des propriétés de familles,
* Mise en place du code métier :
    * Valeur par défaut,
    * Aide à la saisie,
    * Attribut calculé,
    * Contrainte.

## Cadre {#quickstart:fc3a144d-e608-4538-aa71-808075b1860b}

Lors de la phase de spécification, les éléments suivants ont été identifiés. Votre application va nécessiter :

* Référentiel qualité : 
    * Le titre d'un référentiel est sa référence,
    * L'attribut référence est obligatoire.
* Chapitre de référentiel : 
    * Le titre est composé du titre du référentiel associé et du titre de la fiche,
    * L'attribut titre de la fiche est obligatoire.
+ Audit : 
    + Le titre est composé du titre de l'audit et d'un préfixe,
    + L'attribut titre est obligatoire,
    + La date de début ne doit pas être inférieure à la date du jour,
    + La date de fin de l'audit est calculée automatiquement en fonction de la date de début d'audit et de sa durée,
    + La liste des fiches de non conformité n'est pas modifiable et calculée automatiquement.
+ Fiche de non conformité : 
    + Le titre est composé de l'attribut titre de la fiche et du titre de l'audit associé,
    + Le rédacteur d'une fiche est la personne ayant créé celle-ci,
    + Les référentiels accessibles sont ceux sélectionnés dans l'audit associé,
    + Les chapitres accessibles sont ceux du référentiel de la ligne en cours,
    + L'attribut titre est obligatoire,
    + L'attribut lien vers l'audit est obligatoire.

## Théorie et fichiers mis en œuvre {#quickstart:6db003ec-41fb-416e-a19a-94488774070e}

Le paramétrage des familles de Dynacase comprend tout ce qui est lié à la personnalisation du fonctionnement des fiches et des familles. Les différents éléments paramétrables sont :

* les [propriétés des familles][famProperty], via les propriétés vous pouvez spécifier :
    - des éléments de présentation (titre, icône),
    - la sécurité (profil de famille, profil de document),
    - [valeur par défaut][DocValDefault],
    - [paramètre de famille][DocParamFam],
    - le cycle de vie associé,
    - etc.
* l'ajout de code métier à la famille, plusieurs concepts sont mis en œuvre :
    - [contrainte][DocDocContrainte],
    - [attribut calculé][DocDocAttrComputed],
    - [aide à la saisie][DocDocHelper],

## Propriétés des familles {#quickstart:d73e0224-f9f4-445a-a828-069cbc468053}

Vous allez commencer par les propriétés des familles. 

Une famille peut contenir un certain nombre de propriétés, elles sont décrites dans la [documentation][famProperty].

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv`

Celui-ci contient les lignes suivantes :

![ Paramètre de la famille référentiel ](30-30-param-referentiel.png "Paramètre de la famille référentiel")

Vous pouvez remarquer que deux paramètres ont été rempli par le **developper tool** :

* ICON : ce paramètre contient la référence vers une image qui est utilisée comme icône de cette famille dans les interfaces standards,
* DFLDIF : cet élément est lié au fonctionnement de ONEFAM, il est paramétré par défaut avec une valeur permettant d'afficher les familles dans ONEFAM.

### Icône {#quickstart:486c3a7e-2471-4cc4-8633-44ce5203c1fe}

L'image de l’icône doit être ajoutée dans le répertoire `Images` à la racine du contexte. Vous devez donc créer dans vos sources un répertoire `Images` et ajouter une image.

Vous pouvez trouver ici un zip contenant une suggestion d'icônes.

Vous devez obtenir la structure de fichiers suivantes :

    ./Images
    ├── COGIP_AUDIT_AUDIT.png
    ├── COGIP_AUDIT_BASE.png
    ├── COGIP_AUDIT_CHAPITRE.png
    ├── COGIP_AUDIT_FNC.png    
    └── COGIP_AUDIT_REFERENTIEL.png

![ Famille avec icônes ](30-30-with-title.png "Famille avec icônes")

### Titre de famille {#quickstart:dfcd3737-1642-449f-9986-28bbbd4bccdb}

Le titre de la famille se paramètre via les traductions. Veuillez ouvrir le fichier `locale/fr/LC_MESSAGES/src/family_COGIP_AUDIT_AUDIT.po` et modifier le bloc suivant :

    msgid "COGIP_AUDIT_AUDIT#title"
    msgstr "COGIP_AUDIT_AUDIT"

en 

    msgid "COGIP_AUDIT_AUDIT#title"
    msgstr "Audit"

Vous pouvez compléter les différents `po` avec les traductions suivantes :

* `COGIP_AUDIT_BASE#title` : Base,
* `COGIP_AUDIT_CHAPITRE#title` : Chapitre,
* `COGIP_AUDIT_FNC#title` : Fiche de non conformité,
* `COGIP_AUDIT_REFERENTIEL#title` : Référentiel qualité.

![ Famille avec titre ](30-30-with-title.png "Famille avec titre")

NB : **Attention**, si jamais votre bloc de traduction porte la mention `fuzzy`à supprimer la mention sinon la traduction ne sera pas prise en compte.

### Valeur par défaut {#quickstart:b48d21a1-1305-407c-a2bc-aebca7315416}

Dans les fiches de non conformité, le rédacteur est le créateur de la fiche.

Pour obtenir ce comportement, vous allez utiliser la notion de [valeur par défaut][DocValDefault].

La valeur par défaut est donnée par une fonction PHP contenue dans la classe associée à famille, cette fonction est appelée lors de la création d'un document et retourne une valeur qui complète la valeur d'un attribut.

Pour indiquer la valeur par défaut, ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv` et ajouter une ligne juste avant le `END` contenant, dans les colonnes :

* `A` : `DEFAULT`,
* `B` : le nom de l'attribut `caf_redacteur` dans votre cas,
* `C` : le nom de la fonction fournissant la valeur par défaut `::getUserId()`.

Ce qui donne :

![ Valeur par défaut ](30-30-param-default.png "Valeur par défaut")

De plus, cette valeur n'étant pas modifiable par les utilisateurs vous allez modifier la [visibilité][DocVisibilite] par défaut de l'attribut correspondant pour le rendre non modifiable.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` et modifiez la ligne correspondant à l'attribut `caf_redacteur` pour mettre `S` dans la colonne `I`. Cela indique que l'attribut est statique et donc non modifiable :

![ Attribut en S ](30-30-param-default-S.png "Attribut en S")

## Attribut obligatoire {#quickstart:2654ac63-6c63-4daa-a107-8bb9e50c70c0}

Votre spécification indique que certains attributs sont obligatoires.

Pour indiquer qu'un attribut est obligatoire, il faut modifier le fichier `__STRUCT.csv` où il est définit.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv` et modifiez la colonne `J` sur la ligne de l'attribut `car_titre` en y ajoutant la lettre `Y`. Le fichier doit être similaire à :

![ Valeur par défaut ](30-30-needed.png "Valeur par défaut")

Une fois le fichier importé le formulaire en édition indique que l'attribut est obligatoire (passage en gras du label) et ne permet pas d'effectuer la sauvegarde sans mettre une valeur dans cet attribut.

Complétez ensuite les autres fiches :

* `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv` : attributs `cac_ref` et `cac_titre`,
* `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` : attribut `caa_titre`,
* `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` : attributs `caf_titre` et `caf_audit`.

## Calcul des titres des fiches {#quickstart:66cc3713-6e43-4e45-916e-82d29c016d05}

Vous avez différentes règles de calcul de titre de fiche. 

Il existe deux moyens de spécifier les règles de calcul de titre d'une fiche :

* soit en modifiant la colonne `E` d'un fichier `__STRUCT.csv`, cette colonne indique les attributs utilisés dans la composition du titre. Ce moyen est simple mais à plusieurs limitations :
    - vous ne pouvez pas définir l'ordre de composition,
    - seuls les attributs textuels et numériques sont utilisables
* soit en modifiant la méthode [`getCustomTitle`][DocGetCustomTitle] dans ce cas vous composez directement le titre et la colonne `E` n'est plus utilisée.

### Composition du titre en paramétrant la famille {#quickstart:d3a65d4a-67d4-42dd-9b11-23a41ee3f5c7}

Vous allez commencer par modifier la famille où la première méthode fonctionne.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv` et modifiez le pour qu'il soit similaire à :

![ Attribut titre ](30-30-param-referentiel-titre.png "Attribut titre")

Ce qui donne après la création du document :

![ Document avec le calcul du titre ](30-30-compute-title-simple.png "Document avec le calcul du titre")

### Composition du titre en utilisant `getCustomTitle` {#quickstart:7afe120f-3249-48a1-af92-7bd52b4ff837}

Pour les autres familles, vous ne pouvez pas utiliser la même méthode car soit le titre contient un lien vers un attribut, soit il est composé avec des éléments qui ne sont pas directement dans la fiche.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle], pour qu'elle soit similaire à :

    [php]
    /**
     * Compute the title of the chapter family
     *
     * @return string
     */
    public function getCustomTitle() {
        //Get the attr cac_titre value
        $title = $this->getAttributeValue(MyAttributes::cac_titre);
        //Get the title of the referenced referentiel
        $chapterTitle = $this->getTitle($this->getAttributeValue(MyAttributes::cac_ref));
        // Compose the title
        return sprintf("%s : %s", $chapterTitle, $title);
    }

Ce qui donne après la création du document :

![ Document avec le calcul du titre ](30-30-compute-title-function.png "Document avec le calcul du titre")

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle], pour qu'elle soit similaire à :

    [php]
    /**
     * Compute the title of the FNC family
     *
     * @return string
     */
    public function getCustomTitle()
    {
        //Get the attr caf_titre value
        $title = $this->getAttributeValue(MyAttributes::caf_titre);
        //Get the title of the referenced audit
        $chapterTitle = $this->getTitle($this->getAttributeValue(MyAttributes::caf_audit));
        // Compose the title
        return sprintf("%s : %s", $chapterTitle, $title);
    }

### Paramètre de famille {#quickstart:534a6d71-a5f5-4cc0-8a6d-c44275ae9937}

Vous allez maintenant construire le titre pour la famille audit. Ce titre est composé de deux parties :

* un préfixe que vous allez stocker dans un [paramètre de famille][DocParamFam],
* le contenu d'un attribut de la famille `caa_titre`.

Vous allez ajouter un paramètre de famille à la famille audit. Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv`, et modifiez le pour qu'il soit similaire à :

![ Paramètre de famille ](30-30-param-famParam.png "Paramètre de famille")

NB : Les paramètres de familles se définissent de la même manière que les attributs (voir la [documentation d'importation][DocDefFamParam]).

À la prochaine importation, un paramètre sera associé à cette famille, sa valeur est modifiable dans les interfaces d'administration sans redéploiement des sources.

### Composition du titre avec un paramètre de famille {#quickstart:fc2ad726-7db2-4bed-a759-f0f49f7163cc}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle], pour qu'elle soit similaire à :

    [php]
    /**
     * Compute the title of the audit family
     *
     * @return string
     */
    public function getCustomTitle()
    {
        //Get the attr cac_titre value
        $title = $this->getAttributeValue(MyAttributes::caa_titre);
        //Get the prefix
        $prefixe = $this->getFamilyParameterValue("caa_p_title_prefix");
        // Compose the title
        return sprintf("%s_%s", $prefixe, $title);
    }

Ce qui donne :

![ Titre : famille audit ](30-30-title-audit.png "Titre : famille audit")

Bravo ! Vous avez composé tous les titres de familles.

## Mise en place des contraintes {#quickstart:ec7f3353-9d8f-4813-adda-ab1a964e2760}

Vous allez maintenant paramétrer la [contrainte][DocDocContrainte] nécessaire à votre projet.

Une contrainte permet d'empêcher la sauvegarde d'un document tant qu'une condition n'est pas valide.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et veuillez ajouter la fonction suivante :

    [php]
    /**
     * Check if the date is inferior to today
     * 
     * @param string $date iso date
     * @return string|null
     */
    public function checkBeginningDate($date) {
        if (!empty($date) && $date <= date("c")) {
            return _("coa:The date must not be inferior at today");
        }
        return null;
    }

Quelques remarques sur la fonction ci-dessus :

* les méthodes associées à des contraintes commence par convention par `check`,
* la fonction `_` permet d'indiquer que la ligne va être traduite.

NB : Pensez à relancer l'extraction des traductions et à traduire la chaîne dans le fichier po de l'application.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez la colonne `O` de la ligne de l'attribut `caa_date_debut` pour y ajouter la référence à la fonction définie ci-dessus. Vous devez obtenir une ligne similaire à :

![ Définition contrainte : Structure ](30-30-struct-constraint.png "Définition contrainte : Structure")

La cellule contient :

* le nom de la fonction `::checkBeginningDate`,
* le nom de l'attribut dont la valeur est passée en paramètre à la fonction `caa_date_debut`.

Une fois le module déployé, le formulaire possède une nouvelle fonctionnalité, qui s'affiche de cette manière :

![ Définition contrainte : résultat ](30-30-form-constraint.png "Définition contrainte : résultat")

## Configuration des aides à la saisie {#quickstart:4678ab4e-c5bf-4dae-b446-611baad5e225}

Vous allez maintenant configurer une [aide à la saisie][DocDocHelper].  
La spécification indique que dans une fiche de non conformité les référentiels accessibles sont ceux référencés par l'audit associé à la fiche.

### Fonction {#quickstart:3af954c1-fba1-4899-934e-2de89965e9f4}

Veuillez créer un fichier `helper_audit.php` dans le répertoire `EXTERNALS` et ajouter dans celui-ci la fonction `selectReferentiel` comme ci-dessous :

    [php]
    function selectReferentiel($caf_audit, $userInput = "") {
    
        $return = array();
        // Get the audit doc with the id
        $audit = new_Doc("", $caf_audit, true);
        if (!$audit->isAlive()) {
            return _("coa:You need to select an audit before");
        }
        // Get the referentiel doc
        $auditReferentiel = $audit->getAttributeValue(\Dcp\AttributeIdentifiers\COGIP_AUDIT_AUDIT::caa_ref);
    
        if (is_array($auditReferentiel)) {
            $auditReferentiel = implode(",", $auditReferentiel);
        }
    
        // Search the associated referentiel
        $searchDoc = new \SearchDoc("", "COGIP_AUDIT_REFERENTIEL");
        $searchDoc->setObjectReturn();
        /* @var $auditReferentiel \COGIP\COGIP_AUDIT_AUDIT */
        //Add a filter to select only the referentiel in the audit
        $searchDoc->addFilter("id in (%s)", $auditReferentiel);
        //Add a filter on the title that take the userInput
        if (!empty($userInput)) {
            $searchDoc->addFilter("title ~* '%s'", $userInput);
        }
    
        $htmlUserInput = htmlentities($userInput);
        foreach($searchDoc->getDocumentList() as $currentRef) {
            /* @var $currentRef \COGIP\COGIP_AUDIT_AUDIT */
            $enhancedTitle = $currentRef->getHTMLTitle();
            if (!empty($userInput)) {
                //Enhance the title to emphasize the userInput
                $enhancedTitle = str_replace($userInput, "<strong>$htmlUserInput</strong>", $currentRef->getHTMLTitle());
            }
            //Set the return value
            $return[] = array(
                $enhancedTitle,
                $currentRef->getPropertyValue("id"),
                $currentRef->getTitle()
            );
        }
    
        return $return;
     }

Cette fonction permet de sélectionner uniquement les référentiels cités dans l'audit associé à la fiche de non conformité. Vous pouvez remarquer les points suivants :

* si jamais le document audit associé à la FNC n'est pas [alive][DocIsAlive] (soit pas existant, soit supprimé) alors un message est envoyé à l'utilisateur lui indiquant qu'il doit sélectionner un audit,
* l'attribut `caa_ref` est multiple donc le retour de la fonction `getAttributeValue` est un array,
* l'array retourné par la fonction `getAttributeValue` est converti en une chaîne de caractères`,
* la variable `$searchDoc` est une instance de la classe [`SearchDoc`][DocSearchDoc], cette classe permet de chercher des documents dans la base documentaire de Dynacase. Cette classe génère le SQL nécessaire à la recherche et retourne des instances de Document,
* la fonction [addFilter][DocAddFilter] permet d'ajouter un critère de recherche pour préciser la recherche,
* la fonction [getDocumentList][DocGetDocumentList] permet d'avoir la liste des documents trouvés,
* la variable `$return` contient un array bi-dimensionnel. Chaque entrée de cet array est un array décrivant une suggestion, avec l'ordre suivant :
    * le premier élément est le nom de l'élément affiché dans la liste de suggestion, ce nom est en HTML,
    * les éléments suivants sont défini dans le fichier `__STRUCT`.

### Paramétrage {#quickstart:dd771ea3-deb6-4d78-991a-236caed4b347}

Vous allez maintenant enregistrer cette aide à la saisie dans la famille, ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` et ajouter dans les colonnes `L` et `M` les valeurs suivantes :

* `L` : `helper_audit.php`, cette colonne contient la référence vers le fichier contenant l'aide à la saisie,
* `M` : `selectReferentiel(caf_audit,CT):caf_ecart_ref,CT[caf_ecart_ref]` cette colonne contient le paramétrage de l'aide à la saisie, elle peut-être découpée en trois éléments :
    - le nom de la fonction `selectReferentiel`,
    - la liste des éléments entrants : `caf_audit,CT`, ces éléments sont passés à la fonction en valeur entrantes, vous pouvez trouvez [la liste des éléments acceptés][DocHelperSyntaxe] dans la documentation,
    - la liste des éléments cibles de l'aide à la saisie, cette liste décrit les éléments à valuer avec l'élément sélectionné.

![ Aide à la saisie : struct ](30-30-helper.png " Aide à la saisie : struct")

NB : Vous pouvez remarquer qu'il y a un décalage d'une valeur entre le nombre de retour de la fonction d'aide à la saisie (3 éléments par valeur possible) et la définition de l'aide à la saisie (2 éléments uniquement).  Le premier élément du retour de l'aide à la saisie est utilisé pour construire la liste de suggestion présentée à l'utilisateur.

### Résultat {#quickstart:ac23551e-7fc5-4f92-b6dd-7d97c11cbb6e}

![ Aide à la saisie : résultat ](30-30-helper-result.png " Aide à la saisie : résultat")

### Exemple {#quickstart:fb944e8e-6327-4ea9-8e95-9d45ceeb5624}

Ci-dessous, un autre exemple d'aide à la saisie. Il concerne toujours les Fiche de non conformité, les chapitres présentés doivent être ceux du référentiels en cours.

La fonction suivante est à ajouter dans `helper_audit.php` :

    [php]
    function selectChapter($caf_referentiel, $userInput = "")
    {
        if (empty($caf_referentiel)) {
            return _("coa:You need to select a referentiel");
        }
    
        $return = array();
    
        // Search the associated referentiel
        $searchDoc = new \SearchDoc("", "COGIP_AUDIT_CHAPITRE");
        $searchDoc->setObjectReturn();
        /* @var $auditReferentiel \COGIP\COGIP_AUDIT_CHAPITRE */
        //Add a filter to select only the referentiel in the audit
        $searchDoc->addFilter("id = '%s'", $caf_referentiel);
        //Add a filter on the title that take the userInput
        if (!empty($userInput)) {
            $searchDoc->addFilter("title ~* '%s'", $userInput);
        }
    
        $htmlUserInput = htmlentities($userInput);
        foreach ($searchDoc->getDocumentList() as $currentRef) {
            /* @var $currentRef \COGIP\COGIP_AUDIT_CHAPITRE */
            $enhancedTitle = $currentRef->getHTMLTitle();
            if (!empty($userInput)) {
                //Enhance the title to emphasize the userInput
                $enhancedTitle = str_replace($userInput, "<strong>$htmlUserInput</strong>", $currentRef->getHTMLTitle());
            }
            //Set the return value
            $return[] = array(
                $enhancedTitle,
                $currentRef->getPropertyValue("id"),
                $currentRef->getTitle()
            );
        }
    
        return $return;
    }

Et compléter le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` :

![ Aide à la saisie : struct ](30-30-helper2.png " Aide à la saisie : struct")

## Attributs calculés {#quickstart:ead89bc8-c1ce-4522-8d19-6e2d8d0dfd50}

Pour finir ce chapitre, vous allez mettre en place un attribut calculé. Vous allez calculer la date de fin de l'audit en fonction de sa date de début et de sa durée.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et ajoutez la fonction ci-dessous :

    [php]
    /**
     * Compute end date
     * 
     * @param string $dateDebut iso
     * @param int $duree nb days
     * @return string
     */
    public function computeDateFin($dateDebut, $duree) {
        if (!empty($dateDebut) && !empty($duree)) {
            $date = new \DateTime($dateDebut);
            $interval = \DateInterval::createFromDateString(sprintf('%d day', $duree));
            $date->add($interval);
            return $date->format("o-m-d");
        }
        return "";
    }

Ensuite, vous devez enregistrer la fonction dans le fichier `__STRUCT.csv`, ouvrez `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez pour la ligne contenant l'attribut `caa_date_fin` les colonnes :

* `I` : pour rester cohérent il faut que la visibilité soit en `S` car l'utilisateur ne doit pas pouvoir modifier la date de fin,
* `M` : `::computeDateFin(caa_date_debut,caa_duree)`. Cette cellule porte la référence vers la fonction et ces paramètres d'entrée. Le format de cet élément est explicité dans la [documentation][DocDocAttrComputed].

Bravo ! Vous avez terminé la partie pratique de ce chapitre.

## Conclusion {#quickstart:8a58c628-904c-46ea-914a-f592438059c5}

Vous pouvez maintenant, si ce n'est pas déjà fait, générer le paquet et le déployer et créer quelques formulaires pour voir les modifications que vous avez mis en place.

Ce chapitre de paramétrage vous a permis de rendre votre formulaire plus interactif et d'y intégrer plus de logique métier.

Dans les chapitres suivants, vous allez continuer à améliorer celui-ci notamment en ajoutant des règles métier grâce aux hooks et en améliorant l'interface générée.

## Voir aussi {#quickstart:3cd0df89-9a45-46a6-86de-3d218619b8bd}

* [Principales méthodes de la classe Doc][DocMethodClassDoc],
* [Contrainte][DocDocContrainte],
* [Attribut calculé][DocDocAttrComputed],
* [Aide à la saisie][DocDocHelper],
* [Valeur par défaut][DocValDefault],
* [Propriété des familles][famProperty]

<!-- links -->

[structure]:   #quickstart:3b64d38f-81aa-4c02-aad5-77271247bf15
[famProperty]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html#core-ref:6f013eb8-33c7-11e2-be43-373b9514dea3 "Documentation : propriété de famille"
[DocValDefault]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html#core-ref:94fa51e2-3488-11e2-9e34-1f7c912168cf "Documentation : valeur par défaut"
[DocVisibilite]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3e67d45e-1fed-446d-82b5-ba941addc7e8.html "Documentation : visibilité"
[DocParamFam]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4595c8e7-5002-4dbc-b6bb-882b4123efd8.html "Documentation : paramètre de famille"
[DocAttrOption]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:16e19c90-3233-11e2-a58f-6b135c3a2496.html "Documentation : options"
[DocDocContrainte]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:7b41906b-f199-41a4-94df-33b9ad34153b.html "Documentation : contrainte"
[DocDocAttrComputed]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4565cab9-73c8-4eee-bfa7-218ffbd4b687.html "Documentation : attribut calculé"
[DocDocHelper]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:0b2d4cd0-4eed-41d8-ac57-37525a444194.html "Documentation : Aide à la saisie"
[DocGetCustomTitle]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3c5ff78d-c080-48fb-a293-9736ed4e95b8.html "Documentation : getCustomTitle"
[DocDefFamParam]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html#core-ref:c28824e2-3486-11e2-be3b-337d2321d8ee "Documentation : définition paramètre de famille"
[DocMethodClassDoc]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:7d224848-b334-419f-b88e-7d5d6311bfc2.html "Documentation : Principales méthodes de la classe Doc"
[DocSearchDoc]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:a5216d5c-4e0f-4e3c-9553-7cbfda6b3255.html "Documentation : SearchDoc"
[DocAddFilter]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:ec525c92-ab30-4861-aba1-7c2678df130a.html "Documentation : AddFilter"
[DocGetDocumentList]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:8f0824fa-eed6-4170-b52d-d3dc7c5cb9c1.html "Documentation : getDocumentList"
[DocHelperSyntaxe]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:0b2d4cd0-4eed-41d8-ac57-37525a444194.html#core-ref:c3ea0d07-1032-4abf-9746-df01e9434247 "Documentation : Syntaxe"
[DocIsAlive]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b791d14e-800a-4b3b-bee7-41e271a8087e.html "Documentation : alive"