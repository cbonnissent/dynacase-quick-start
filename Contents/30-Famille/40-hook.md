# Hook {#quickstart:39002eed-bc3a-4050-be76-71fcc0fbafa3}

Dans ce chapitre, vous allez utiliser la notion de hook (hameçons). 

## Objectifs

* Calcul automatique d'un tableau de référentiel,
* Contrôle à la création d'un document,
* Ajout de JS/CSS dans les formulaires.

## Théorie

Les [hooks][DocHook] sont des fonctions de la classe Doc qui sont appelées 
à différents moments clefs de la vie du document.

Dynacase propose deux types de hooks :

* **pre** : les hooks de pre sont exécutés avant une action et peuvent annuler cette action,
* **post** : les hooks de post sont exécutés après une action.

La liste des hooks standards est dans la [documentation][DocHook].

## Cadre

Lors de la phase de spécification, les éléments suivants ont été identifiés. L'application nécessite :

* pour les Audits :
    * le tableau des Fiche de non conformité doit être calculé automatiquement et non modifiable,
    * la duplication d'un audit peut-être effectuée mais la date d'audit doivent être vidée automatiquement,
    * lorsque la fin de l'audit est dépassée à message doit être affiché pour avertir les utilisateurs,
* pour les Référentiels de qualité :
    - un référentiel de qualité ne peut pas être supprimé tant que qu'il existe des chapitres associés à ce référentiel.

## Automatisation du calcul d'un tableau

Vous allez mettre en place la logique permettant de calculer automatiquement le tableau des Fiches de non conformité.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Compute the FNC attributes content
     * 
     * @return string
     */
    public function computeFNC() {
        $err = "";
        $fncs = array();
        $search = new \SearchDoc('', 'COGIP_AUDIT_FNC');
        $search->setObjectReturn();
        $search->addFilter("%s = '%d'", \Dcp\AttributeIdentifiers\COGIP_AUDIT_FNC::caf_audit, $this->getPropertyValue("initid"));
        foreach($search->getDocumentList() as $currentFNC) {
            /* @var \Dcp\Family\COGIP_AUDIT_FNC $currentFNC */
            $fncs[] = $currentFNC->getPropertyValue("initid");
         }
        $err .= $this->setValue(MyAttributes::caa_fnc_fnc, $fncs);
        if ($err) {
            $err = __FILE__.":".__LINE__.":".__METHOD__." ".$err."\n";
        }
        return $err;
     }

Cette méthode est assez proche de celles écrites dans le chapitre de paramétrage pour les [aides à la saisie][internHelper].

Les point suivants sont intéressants :

* le filtre de la recherche est fait sur l'`initid` du document en cours,
* le [`setValue`][DocSetValue] est fait avec un array car l'attribut `caa_fnc_fnc` est multiple,
* la gestion des erreurs dans Dynacase est faite principalement par le retour des fonctions, celle-ci renvoie une chaîne de caractères décrivant l'erreur en cours et rien lorsque la fonction n'a pas échoué.

Surchargez ensuite la fonction [`postStore`][DocDocPostStore], cette fonction est appelée après chaque enregistrement du document :

    [php]
    public function postStore() {
        $err = "";
        $err .= $this->computeFNC();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

<span class="flag inline nota-bene"></span> Il est déconseillé de mettre le code métier directement dans la fonction de manière à pouvoir surcharger dans les familles filles les fonctions appelées dans les hooks plus facilement.

### Problèmes

A ce stade, le formulaire calcul automatiquement la valeur de l'attribut `caa_fnc_fnc`, il reste deux défauts :

* les utilisateurs peuvent toujours modifier la valeur de l'attribut dans le formulaire,
* le calcul n'est effectué que lors de la sauvegarde du document audit, si des fiches de non-conformités sont ajoutées et l'audit n'est pas modifié alors l'attribut `caa_fnc_fnc` n'est pas à jour.

Pour corriger le premier point, ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez la [visibilité][DocVisibilite] du tableau des Fiches de non conformité pour le rendre statique. Modifiez la colonne `I` :

* pour l'attribut `caa_a_fnc`, passez la valeur de `W` à `U`,
* pour l'attribut `caac_fnc_fnc`, passez la valeur de `W` à `S`.

La liste des fiches de non conformité n'est plus modifiable dans les audits en modification.

Pour corriger le second point, vous devez modifier les fiches de non conformité pour qu'à sa sauvegarde une fiche mette à jour l'audit associé. Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Refresh the list of the audit
     * 
     * @return string
     */
    public function refreshAudit() {
        $err = "";
        $audit = $this->getAttribute(MyAttributes::caf_audit);
        $audit = new_Doc("", $audit, true);
        /* @var \Dcp\Family\COGIP_AUDIT_AUDIT $audit */
        $err .= $audit->computeFNC();
        $err .= $audit->store();
        if ($err) {
            $err = __FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n";
        }
        return $err;
     }

Ensuite surchargez la fonction [`postStore`][DocDocPostStore] :

    [php]
    /**
     * Hook executed after the store
     *
     * @return string|void
     */
    public function postStore() {
        $err = parent::postStore();
        $err .= $this->computeFNC();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

<span class="flag inline nota-bene"></span> Attention a bien appeler le parent lors de la surcharge de la fonction de hook, sinon le code des classes parentes ne serait pas appelé.

## Duplication

Vous allez mettre en place un traitement après la duplication d'un audit pour supprimer les dates de l'audit dans le nouveau document créé par duplication.

Ouvrez `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Clean constat date
     *
     * @return string
     */
    public function cleanDate() {
        $err = "";
        $err .= $this->clearValue(MyAttributes::caa_date_debut);
        $err .= $this->clearValue(MyAttributes::caa_date_fin);
        $err .= $this->clearValue(MyAttributes::caa_duree);
        if ($err) {
            $err = __FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n";
        }
        return $err;
    }

Cette fonction utilise [`clearValue`][DocDocClearValue] qui permet de vider la valeur d'un attribut.

Ajoutez ensuite la fonction suivante :

    [php]
    public function postDuplicate() {
        $err = "";
        $err .= $this->cleanDate();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

Vous pouvez ensuite dupliquer le document, le menu de duplication est dans `Autres > Dupliquer`.

## Affichage d'un message aux utilisateurs

Vous allez maintenant mettre en place l'affichage conditionnel d'un message aux utilisateurs lorsque la date de fin d'audit est dépassée.

Ouvrez `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Check if the end date is in the past
     * 
     * @return string
     */
    public function checkEndDate() {
        $err = "";
        if ($this->getAttributeValue(MyAttributes::caa_date_fin) > date("o-m-d") ) {
            $err = _("coa:The end date of the audit is in the past");
        }
        return $err;
    }

Ajoutez ensuite la fonction suivante :

    [php]
    /**
     * Hokk executed after the refresh
     * 
     * @return string
     */
    public function postRefresh() {
        $err = parent::postRefresh();
        $err .= $this->checkEndDate();
        return $err;
    }

Une fois le code déployé si la date de fin d'audit est dans le passé vous avez le message suivant qui s'affiche :

![ Message utilisateur ](30-40-postRefresh.png "Message utilisateur")

## Contrôle à la suppression

Vous allez mettre en place un contrôle à la suppression.

Ouvrez `./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Check if exist chapter associated to the current referentiel
     * 
     * @return string
     */
    public function checkIfAssociatedChapterExist() {
        $return = "";
        $search = new \SearchDoc("", "COGIP_AUDIT_CHAPITRE");
        $search->addFilter("%s = '%d'", \Dcp\AttributeIdentifiers\COGIP_AUDIT_CHAPITRE::cac_ref,
            $this->getPropertyValue("initid"));
        $search->setSlice(1);
        $nb = $search->onlyCount();
        if ($nb > 0) {
            $return = _("coa:You have to delete all associated chapter before delete the ref");
        }
        return $return;
    }

Cette fonction effectue une recherche et possède les spécificités suivantes :

* [`setSlice`][DocSetSlice] : cette fonction indique le nombre maximum de retour de la recherche. Dans votre cas, la présence d'un seul élément suffit pour enclencher le rejet de la suppression et limiter la recherche à un élément permet de l'accélérer,
* [`onlyCount`][DocOnlyCount] : cette fonction indique que l'on ne souhaite pas lancer la recherche mais juste compter le nombre de résultats de celle-ci.

Ajoutez ensuite la fonction suivante :

    [php]
    public function preDelete() {
        $msg = parent::preDelete();
        $msg .= $this->checkIfAssociatedChapterExist();
        return $msg;
    }

## Injection de JS ou CSS

Pour finir ce chapitre, le service qualité a jeté un coup d'oeil sur vos ajouts et aimerait que le message renvoyé aux utilisateurs soit moins impressionnant. 

Ajoutez donc une CSS pour obtenir ce comportement.

Ajoutez le fichier `./COGIP_AUDIT/Layout/specRefresh.css` :

    [css]
    .COREErrorBg {
        color: rgb(255, 173, 0);
    }

Ce fichier définit la couleur de background des erreurs en orange.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_BASE__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Inject a CSS
     */
    public function addCSS() {
        global $action;
        $action->parent->addCssRef("COGIP_AUDIT:specRefresh.css");
    }

Cette méthode fait appelle à la fonction [`addCssRef`][DocAddCssRef], elle permet d'ajouter une CSS à un document.

Vous allez maintenant ajouter les fonctions suivantes :

    [php]
        public function preEdition() {
        $err = parent::preEdition();
        $this->addCSS();
        return $err;
    }
    
    public function preConsultation() {
        $err = parent::preConsultation();
        $this->addCSS();
        return $err;
    }

Les deux fonctions ajoutées s’exécute respectivement avant l'édition et avant la consultation et ajoute la CSS que vous avez défini ci-dessus dans le formulaire.

## Conclusion

Vous avez abordé les hooks et leurs fonctionnalités, ils permettent de surcharger le fonctionnement par défaut des documents de Dynacase pour implémenter la logique métier de votre projet.

## Voir aussi

* [Les hooks][DocHook].

<!-- links -->

[DocHook]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:8f3d47de-32b5-4748-8a00-b1569c5423e5.html "Documentation : hooks"
[internHelper]: #quickstart:4678ab4e-c5bf-4dae-b446-611baad5e225
[DocSetValue]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:febc397f-e629-4d47-955d-27cab8f4ed2f.html "Documentation : setValue"
[DocDocPostStore]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:99520a31-0aef-4bc6-b20a-114737059d17.html "Documentation : postStore"
[DocDocClearValue]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:30b0592f-f0cd-498f-bc5f-301891c297e0.html "Documentation : clearValue"
[DocSetSlice]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:298603d5-ee5e-4c61-81b7-51b699dc670e.html "Documentation : setSlice"
[DocOnlyCount]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:2d43be1a-1991-42dd-a25d-5c3bb0b393fa.html "Documentation : onlyCount"
[DocAddCssRef]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:4bba8a6b-8002-4c0a-8ac7-70d75b31b02b.html "Documentation : addCssRef"
[DocVisibilite]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3e67d45e-1fed-446d-82b5-ba941addc7e8.html "Documentation : visibilité"