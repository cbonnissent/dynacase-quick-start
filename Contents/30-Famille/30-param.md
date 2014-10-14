# Paramétrage {#quickstart:b5501068-3412-4849-a1ac-4155272da2ad}

Dans ce chapitre, vous allez paramétrer les familles que vous avez créées
dans le [chapitre précédent, "Mise en place des structures"][structure].

## Objectifs  {#quickstart:9fd3067d-5851-4306-9e1a-13eb626417d8}

* Mise en place des propriétés des familles,
* Mise en place du code métier :
    * Valeurs par défaut,
    * Aides à la saisie,
    * Attributs calculés,
    * Contraintes.

## Cadre {#quickstart:fc3a144d-e608-4538-aa71-808075b1860b}

Lors de la phase de spécification, les éléments suivants ont été identifiés.
Votre application nécessite les comportements suivants :

-   Référentiel qualité :
    -   L'attribut référence est obligatoire,
    -   Le titre d'un référentiel est sa référence.
-   Chapitre de référentiel :
    -   L'attribut titre du chapitre est obligatoire,
    -   Le titre est composé du titre du référentiel associé et du titre du chapitre.
-   Audit :
    -   L'attribut titre est obligatoire,
    -   Le titre est composé du titre de l'audit et d'un préfixe,
    -   La date de début est postérieure à la date du jour,
    -   La date de fin de l'audit est calculée automatiquement en fonction de la date de début d'audit et de sa durée,
    -   La liste des fiches de non-conformité, calculée automatiquement, n'est pas modifiable.
-   Fiche de non-conformité :
    -   Le titre est composé de l'attribut titre de la fiche et du titre de l'audit associé,
    -   Le rédacteur d'une fiche est la personne l'ayant créée,
    -   Les référentiels accessibles sont ceux sélectionnés dans l'audit associé,
    -   Les chapitres accessibles sont ceux du référentiel de la ligne en cours,
    -   L'attribut titre est obligatoire,
    -   L'attribut lien vers l'audit est obligatoire.

## Théorie et fichiers mis en œuvre {#quickstart:6db003ec-41fb-416e-a19a-94488774070e}

Le paramétrage des familles de Dynacase comprend tout ce qui est lié à la personnalisation du fonctionnement des familles.
Les différents éléments paramétrables sont :

-   les [propriétés des familles][famProperty], qui permettent de spécifier :
    - des éléments de présentation (titre, icône),
    - la sécurité (profil de famille, profil de document),
    - [valeur par défaut][DocValDefault],
    - [paramètre de famille][DocParamFam],
    - le cycle de vie associé,
    - etc.
-   l'ajout de code métier à la famille; plusieurs concepts sont mis en œuvre :
    - [contrainte][DocDocContrainte],
    - [attribut calculé][DocDocAttrComputed],
    - [aide à la saisie][DocDocHelper],

<span class="flag inline nota-bene"></span> Il vous est rappelé qu'à chaque modification de votre paquet,
vous devez reconstruire celui-ci et le déployer pour voir les modifications s'appliquer sur votre environnement d'exécution (VM). De plus :

-   si vous avez modifié la structure (ajout, suppression d'attribut), il est conseillé de :
    -   rafraîchir les [stubs][stubs],
    -   rafraîchir les [traductions][i18n]
-   si vous avez ajouté/enlevé une clef de traduction dans le code associé aux familles (fonctions `_`, `___`),
    il est conseillé de rafraîchir les [traductions][i18n].

<span class="flag inline nota-bene"></span> Les annexes contiennent un chapitre [développement rapide][devRapide]
qui résume quelques techniques permettant d'accélérer le développement en évitant de déployer à chaque modification.

## Propriétés des familles {#quickstart:d73e0224-f9f4-445a-a828-069cbc468053}

Commencez par les propriétés des familles. 

Une famille peut contenir un certain nombre de propriétés, elles sont décrites dans la [documentation][famProperty].

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv`, celui-ci contient les lignes suivantes :

![ Paramètre de la famille référentiel ](30-30-param-referentiel.png "Paramètre de la famille référentiel")

Deux paramètres ont été remplis par le **developper tool** :

-   `ICON` : désigne une image qui est utilisée comme icône pour cette famille dans les interfaces standards,
-   `DFLDID` : cette propriété est utilisée par l'interface par défaut `ONEFAM` pour identifier les familles à afficher.

### Icône {#quickstart:486c3a7e-2471-4cc4-8633-44ce5203c1fe}

L'image de l’icône doit être ajoutée dans le répertoire `Images` à la racine du contexte.
Vous devez donc créer dans vos sources un répertoire `Images` et ajouter une image.

Vous obtenez la structure de fichiers suivantes :

    ├ Images
    ├── cogip_audit_audit.png
    ├── cogip_audit_base.png
    ├── cogip_audit_chapitre.png
    ├── cogip_audit_fnc.png
    ├── COGIP_AUDIT.png
    └── cogip_audit_referentiel.png


Vous pouvez retrouver l'ensemble des images de l'application sur [github][tuto_images].

![ Famille avec icônes ](30-30-with-title.png "Famille avec icônes")

### Titre de famille {#quickstart:dfcd3737-1642-449f-9986-28bbbd4bccdb}

Le titre de la famille se paramètre via les traductions.
Ouvrez le fichier `locale/fr/LC_MESSAGES/src/COGIP_AUDIT_AUDIT.po` et modifiez le bloc suivant :

    [gettext]
    msgid "COGIP_AUDIT_AUDIT#title"
    msgstr ""

en

    [gettext]
    msgid "COGIP_AUDIT_AUDIT#title"
    msgstr "Audit"

Complétez les différents fichiers `.po` avec les traductions suivantes :

-   `COGIP_AUDIT_BASE#title` : Base,
-   `COGIP_AUDIT_CHAPITRE#title` : Chapitre,
-   `COGIP_AUDIT_FNC#title` : Fiche de non-conformité,
-   `COGIP_AUDIT_REFERENTIEL#title` : Référentiel qualité.

![ Famille avec titre ](30-30-with-title.png "Famille avec titre")

<span class="flag inline nota-bene"></span> **Attention** si jamais votre bloc de traduction porte la mention `fuzzy`,
cette mention doit être supprimée pour que la traduction soit prise en compte.

Vous pouvez retrouver les po complétés sur [github][tuto_po].

### Valeur par défaut {#quickstart:b48d21a1-1305-407c-a2bc-aebca7315416}

Dans les fiches de non-conformité, le rédacteur est le créateur de la fiche.

Pour obtenir ce comportement, vous allez utiliser la notion de [valeur par défaut][DocValDefault].

La valeur par défaut est donnée par une méthode de la classe associée à famille.
Cette méthode est appelée lors de la création d'un document et retourne une valeur qui complète la valeur d'un attribut.

Pour indiquer la valeur par défaut, ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv`
et ajoutez une ligne juste avant le `END` avec pour les colonnes les valeurs :

-   `A` : `DEFAULT`,
-   `B` : le nom de l'attribut, `caf_redacteur` dans votre cas,
-   `C` : le nom de la fonction fournissant la valeur par défaut, ici `::getUserId()`.

Ce qui donne :

![ Valeur par défaut ](30-30-param-default.png "Valeur par défaut")

Vous pouvez retrouver le fichier complété dans [les sources][tuto_param_fnc].

De plus, cette valeur n'étant pas modifiable par les utilisateurs, vous allez modifier la [visibilité][DocVisibilite]
par défaut de l'attribut correspondant pour le rendre non modifiable.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` et modifiez la ligne correspondant à l'attribut `caf_redacteur`
pour mettre `S` dans la colonne `I`. Cela indique que l'attribut est statique et donc non modifiable :

![ Attribut en S ](30-30-param-default-S.png "Attribut en S")

Vous pouvez retrouver le fichier complété dans [les sources][tuto_struct_fnc].

## Attribut obligatoire {#quickstart:2654ac63-6c63-4daa-a107-8bb9e50c70c0}

Votre spécification indique que certains attributs sont obligatoires.

Pour indiquer qu'un attribut est obligatoire, sa définition est modifiée dans le fichier `__STRUCT.csv`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv` et modifiez la colonne `J`
sur la ligne de l'attribut `car_titre` en y ajoutant la lettre `Y`. Le fichier doit être similaire à :

![ Attribut obligatoire ](30-30-needed.png "Attribut obligatoire")

Une fois le fichier importé, le formulaire en édition indique que l'attribut est obligatoire (passage en gras du label).
L'enregistrement n'est pas permis sans mettre une valeur dans cet attribut.

Complétez ensuite les autres familles :

-   `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv` : attributs `cac_ref` et `cac_titre`,
-   `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` : attribut `caa_titre`,
-   `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` : attributs `caf_titre` et `caf_audit`.

Vous pouvez retrouver les familles complétées dans les [sources][tuto_fam].

## Calcul des titres des documents {#quickstart:66cc3713-6e43-4e45-916e-82d29c016d05}

Il existe deux moyens de spécifier les règles de calcul de titre d'un document :

-   soit en modifiant la colonne `E` d'un fichier `__STRUCT.csv`, cette colonne indique les attributs utilisés dans la composition du titre.
    Ce moyen est simple mais a plusieurs limitations :
    -   vous ne pouvez pas définir l'ordre de composition (les valeurs sont concaténées selon l'ordre des attributs),
    -   seuls les attributs textuels et numériques sont utilisables.
-   soit en modifiant la méthode [`getCustomTitle`][DocGetCustomTitle] dans ce cas vous composez directement le titre.
    La colonne `E` n'est plus utilisée.

### Composition du titre par paramétrage de la structure {#quickstart:d3a65d4a-67d4-42dd-9b11-23a41ee3f5c7}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv` et modifiez le pour qu'il soit similaire à :

![ Attribut titre ](30-30-param-referentiel-titre.png "Attribut titre")

Ce qui donne après la création du document :

![ Document avec le calcul du titre ](30-30-compute-title-simple.png "Document avec le calcul du titre")

Vous pouvez retrouver le fichier complété dans [les sources][tuto_struct_ref].

### Composition du titre en utilisant `getCustomTitle` {#quickstart:7afe120f-3249-48a1-af92-7bd52b4ff837}

Pour les autres familles, vous ne pouvez pas utiliser la même méthode car soit le titre contient un lien vers un attribut,
soit il est composé avec des éléments qui ne sont pas directement dans le document.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle] :

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

Vous pouvez retrouver le fichier complété dans [les sources][tuto_class_audit].

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle] :

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

Vous pouvez retrouver le fichier complété dans [les sources][tuto_class_fnc].

### Paramètre de famille {#quickstart:534a6d71-a5f5-4cc0-8a6d-c44275ae9937}

Vous allez maintenant construire le titre pour la famille audit. Ce titre est composé de deux parties :

-   un préfixe que sera stocké dans un [paramètre de famille][DocParamFam],
-   le contenu d'un attribut de la famille `caa_titre`.

Vous allez ajouter un paramètre à la famille audit.
Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv` et modifiez le pour qu'il soit similaire à :

![ Paramètre de famille ](30-30-param-famParam.png "Paramètre de famille")

<span class="flag inline nota-bene"></span> Les paramètres de familles se définissent de la même manière que les attributs
(voir la [documentation d'importation][DocDefFamParam]).

À la prochaine importation, le paramètre sera associé à cette famille.
Sa valeur est modifiable dans les interfaces d'administration sans nouveau déploiement des sources.

Vous pouvez retrouver les sources complétées dans les [sources][tuto_fam].

### Composition du titre avec un paramètre de famille {#quickstart:fc2ad726-7db2-4bed-a759-f0f49f7163cc}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et surchargez la méthode [`getCustomTitle`][DocGetCustomTitle] :

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

Ce qui donne, après déploiement :

![ Titre : famille audit ](30-30-title-audit.png "Titre : famille audit")

Bravo ! Vous avez mis en place le calcul des titres des documents.

## Mise en place des contraintes {#quickstart:ec7f3353-9d8f-4813-adda-ab1a964e2760}

Vous allez maintenant paramétrer la [contrainte][DocDocContrainte] nécessaire à votre projet.

Une contrainte permet de vérifier qu'une condition est valide lors de l'enregistrement d'un document.

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
            return _("coa:The date must be after today");
        }
        return null;
    }

Quelques remarques sur la fonction ci-dessus :

-   les méthodes associées à des contraintes commencent, par convention, par `check` (bonne pratique),
-   la fonction `_` permet d'indiquer que la chaîne va être traduite.

<span class="flag inline nota-bene"></span>
Pensez à relancer l'extraction des traductions et à traduire la chaîne dans le fichier `.po` de l'application (`COGIP_AUDIT_fr.po`).

Vous pouvez retrouver la contrainte complétée dans les [sources][tuto_code_contrainte].

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez la colonne `O`
de la ligne de l'attribut `caa_date_debut` pour y ajouter la référence à la fonction définie ci-dessus.
Vous devez obtenir une ligne similaire à :

![ Définition contrainte : Structure ](30-30-struct-constraint.png "Définition contrainte : Structure")

La cellule contient :

-   le nom de la fonction `::checkBeginningDate`,
-   le nom de l'attribut dont la valeur est passée en paramètre à la fonction `caa_date_debut`.

Une fois le module déployé, le formulaire possède une nouvelle fonctionnalité, qui s'affiche de cette manière :

![ Définition contrainte : résultat ](30-30-form-constraint.png "Définition contrainte : résultat")

Vous pouvez retrouver la contrainte complétée dans les [sources][tuto_struct_audit].

<span class="flag inline nota-bene"></span> Les contraintes permettent aussi de suggérer des valeurs.
Si vous souhaitez implémenter ce comportement, veuillez consulter la [documentation][DocDocContrainte].

<span class="flag inline nota-bene"></span>
Pour l'instant cette contrainte est très limitante, en effet elle s’exécute à chaque sauvegarde du document. Donc :

1. vous créez l'audit le 12 juin pour un audit commençant le 15 juin et durant 5 jours,
2. vous le modifiez le 16 juin la contrainte vous indique que la date de début est dépassée et vous empêche de sauvegarder.

Vous verrez dans le chapitre sur les cycles de vie différents moyens d'améliorer cette contrainte.

## Configuration des aides à la saisie {#quickstart:4678ab4e-c5bf-4dae-b446-611baad5e225}

Vous allez maintenant configurer une [aide à la saisie][DocDocHelper].  
La spécification indique que dans une fiche de non-conformité les référentiels accessibles sont ceux référencés par l'audit associé à la fiche.

<span class="flag inline nota-bene"></span> Une aide à la saisie est dans un fichier autonome car elle peut-être utilisée
au sein de plusieurs famille différentes.

### Fonction {#quickstart:3af954c1-fba1-4899-934e-2de89965e9f4}

Ajoutez un fichier `helper_audit.php` dans le répertoire `EXTERNALS` et ajoutez dans celui-ci la fonction `selectReferentiel` comme ci-dessous :

    [php]
    <?php
    
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
            $searchDoc->addFilter("title ~* '%s'", preg_quote($userInput));
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
                $currentRef->getPropertyValue("initid"),
                $currentRef->getTitle()
            );
        }
    
        return $return;
     }

Cette fonction permet de sélectionner uniquement les référentiels cités dans l'audit associé à la fiche de non-conformité.
Vous pouvez remarquer les points suivants :

-   si jamais le document audit associé à la FNC n'est pas [vivant (alive)][DocIsAlive] (soit inexistant, soit supprimé)
    alors un message est envoyé à l'utilisateur lui indiquant qu'il doit sélectionner un audit,
-   l'attribut `caa_ref` est multiple, donc le retour de la fonction `getAttributeValue` est un `array`,
-   l'`array` retourné par la fonction `getAttributeValue` est converti en une chaîne de caractères,
-   la variable `$searchDoc` est une instance de la classe [`SearchDoc`][DocSearchDoc],
    cette classe permet de chercher des documents dans la base documentaire de Dynacase.
    Elle génère le SQL nécessaire à la recherche et retourne des instances de Document ou les valeurs contenues dans le document,
-   la fonction [addFilter][DocAddFilter] permet d'ajouter un critère de recherche pour préciser la recherche,
-   la fonction [getDocumentList][DocGetDocumentList] permet d'avoir la liste des documents trouvés,
-   la variable `$return` contient un `array` bi-dimensionnel.
    Chaque entrée de cet `array` est un `array` décrivant une proposition, constituée de :
    -   le premier élément est le nom de l'élément affiché dans la liste de suggestion, ce nom est en HTML,
    -   les éléments suivants sont les valeurs pour les attributs spécifiés dans le fichier `__STRUCT`.

<span class="flag inline nota-bene"></span>
`id` et `initid` : dans l'aide à la saisie la [propriété][DocDocProperty] renvoyée est l'initid du document.
Tout document possède plusieurs moyens d'être identifié :

-   `id` : identifiant unique qui permet de trouver le document au sein d'un contexte,
-   `initid` : identifiant d'une [lignée documentaire][DocLigneeDoc].
    Une lignée documentaire est l'ensemble des révisions (passées et applicable) d'un document,
    et l'`initid` est l'`id` de la première révision du document.
    Cet `initid` doit être utilisé pour référencer le document dans les formulaires pour permettre la recherche.
-   `name` : identifiant fonctionnel d'un document. Alors que l'`id` et l'`initid` sont générés par la base de donnée,
    le `name` est défini par le développeur. Ainsi, il est constant entre les différentes installations,
    alors que l'`id` et l'`initid` ne le sont pas.

Vous pouvez retrouver les aides à la saisie complétées dans les [sources][tuto_external].

### Paramétrage {#quickstart:dd771ea3-deb6-4d78-991a-236caed4b347}

Vous allez maintenant référencer cette aide à la saisie dans la famille.
Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` et ajoutez dans les colonnes `L` et `M` les valeurs suivantes :

-   `L` : `helper_audit.php`, cette colonne contient la référence vers le fichier contenant l'aide à la saisie,
-   `M` : `selectReferentiel(caf_audit,CT):caf_ecart_ref,CT[caf_ecart_ref]`
    cette colonne contient le paramétrage de l'aide à la saisie, elle peut-être découpée en trois éléments :
    -   le nom de la fonction `selectReferentiel`,
    -   la liste des éléments entrants : `caf_audit,CT`, ces éléments sont passés à la fonction en valeur entrantes,
        vous trouverez [la liste des éléments acceptés][DocHelperSyntaxe] dans la documentation,
    -   la liste des éléments cibles de l'aide à la saisie,
        cette liste décrit les éléments à valuer avec la suggestion sélectionnée par l'utilisateur.

![ Aide à la saisie : struct ](30-30-helper.png " Aide à la saisie : struct")

<span class="flag inline nota-bene"></span>
Vous remarquez qu'il y a un décalage d'une valeur entre
le nombre de retour de la fonction d'aide à la saisie (3 éléments par valeur possible)
et la définition de l'aide à la saisie (2 éléments uniquement).  
En effet, le premier élément du retour de l'aide à la saisie est utilisé
pour construire la liste de suggestion présentée à l'utilisateur.

Vous pouvez retrouver le paramétrage complété dans les [sources][tuto_fnc_struct].

### Résultat {#quickstart:ac23551e-7fc5-4f92-b6dd-7d97c11cbb6e}

![ Aide à la saisie : résultat ](30-30-helper-result.gif " Aide à la saisie : résultat")

### Exemple {#quickstart:fb944e8e-6327-4ea9-8e95-9d45ceeb5624}

Ci-dessous, un autre exemple d'aide à la saisie.
Il concerne toujours les Fiche de non-conformité, les chapitres présentés doivent être ceux du référentiels en cours.

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
        $searchDoc->addFilter("cac_ref = '%s'", $caf_referentiel);
        //Add a filter on the title that take the userInput
        if (!empty($userInput)) {
            $searchDoc->addFilter("title ~* '%s'", preg_quote($userInput));
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
                $currentRef->getPropertyValue("initid"),
                $currentRef->getTitle()
            );
        }
    
        return $return;
    }

Vous pouvez retrouver les aides à la saisie complétées dans les [sources][tuto_external].

Et complétez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv` :

![ Aide à la saisie : struct ](30-30-helper2.png " Aide à la saisie : struct")

Vous pouvez retrouver les sources complétées dans les [sources][tuto_fam].

## Attributs calculés {#quickstart:ead89bc8-c1ce-4522-8d19-6e2d8d0dfd50}

Pour finir ce chapitre, vous allez mettre en place un attribut calculé.
La date de fin de l'audit doit être calculée en fonction de sa date de début et de sa durée.

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
        return " ";
    }

<span class="flag inline nota-bene"></span> Le retour de l'attribut calculé doit être un espace pour indiquer que
le contenu de l'attribut doit-être vidé. Si jamais la fonction retourne une chaîne vide ou rien alors le contenu
de l'attribut est laissé tel quel.

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_audit].

Ensuite, vous devez enregistrer la fonction dans le fichier `__STRUCT.csv`,
ouvrez `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez pour l'attribut `caa_date_fin` les colonnes :

-   `I` : pour rester cohérent il faut que la [visibilité][DocVisibilite] soit en `S`
    car l'utilisateur ne doit pas pouvoir modifier la date de fin,
-   `M` : `::computeDateFin(caa_date_debut,caa_duree)`.
    Cette cellule porte la référence vers la fonction et ces paramètres d'entrée.
    Le format de cet élément est explicité dans la [documentation][DocDocAttrComputed].

Vous pouvez retrouver le fichier CSV complété dans les [sources][tuto_struct_audit].

Bravo ! Vous avez terminé la partie pratique de ce chapitre.

## Conclusion {#quickstart:8a58c628-904c-46ea-914a-f592438059c5}

Vous allez maintenant produire le paquet.

    <devtool> generateWebinst -s .

Déployez le paquet en passant par Dynacase Control (`http://<nomDeDomaine>/dynacase-control/`) en utilisant le scénario *upgrade* 
(en cas de besoin, n'hésitez pas à consulter les instruction de [déploiement][deploy_instruct]).
 
Vous pouvez ensuite créer quelques formulaires pour voir les modifications que vous avez mises en place.

Ce chapitre de paramétrage vous a permis de rendre votre formulaire plus interactif et d'y intégrer plus de logique métier.

Dans les chapitres suivants, vous allez continuer à améliorer celui-ci notamment

-   en ajoutant des règles métier grâce aux hooks
-   et en améliorant l'interface générée.

## Voir aussi {#quickstart:3cd0df89-9a45-46a6-86de-3d218619b8bd}

-   [Les sources après ce chapitre][tuto_after_30_30],
-   [Principales méthodes de la classe Doc][DocMethodClassDoc],
-   [Contrainte][DocDocContrainte],
-   [Attribut calculé][DocDocAttrComputed],
-   [Aide à la saisie][DocDocHelper],
-   [Valeur par défaut][DocValDefault],
-   [Propriété des familles][famProperty]

<!-- links -->

[devRapide]:    #quickstart:c4eef86b-1f5d-4fd1-b362-d78c8fa637eb
[i18n]:     #quickstart:989b4a9e-e3d8-475e-9dcf-9a158605eab6
[stubs]:    #quickstart:df9b59b1-3a7f-420b-a89d-36cd6894edb9
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
[DocDocProperty]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:9aa8edfa-2f2a-11e2-aaec-838a12b40353.html "Documentation : propriétés des documents"
[DocLigneeDoc]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1cdff481-42e0-4caf-baba-d2348d760ca5.html "Documentation : Lignée documentaire"
[tuto_images]: https://github.com/Anakeen/dynacase-quick-start-code/tree/master/Images
[tuto_after_30_30]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-30-30.zip
[tuto_po]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-30-30/locale/fr/LC_MESSAGES/src
[tuto_fam]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-30-30/COGIP_AUDIT
[tuto_external]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/EXTERNALS/helper_audit.php
[tuto_fnc_struct]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv#L11-L12
[tuto_code_contrainte]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php#L24-L36
[tuto_struct_fnc]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv
[tuto_param_fnc]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv#L9
[tuto_struct_ref]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv#L6
[tuto_class_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php
[tuto_class_fnc]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php#L14-L22
[tuto_struct_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv#L7
[deploy_instruct]: #quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e
