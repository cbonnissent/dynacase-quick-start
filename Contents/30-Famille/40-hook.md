# Hook {#quickstart:39002eed-bc3a-4050-be76-71fcc0fbafa3}

Dans ce chapitre, vous allez utiliser la notion de hook (hameçons). 

## Objectifs {#quickstart:6aaa1eea-d37c-4d09-ac25-2b1b7d593d71}

-   Calcul automatique d'un tableau de référentiel,
-   Contrôle à la création d'un document,
-   Ajout de JS/CSS dans les formulaires.

## Théorie {#quickstart:40cef360-334d-49e9-918b-ff12e28bb54d}

Les [hooks][DocHook] sont des méthodes de la classe Doc qui sont appelées
à différents moments clefs de la vie du document.

Dynacase propose deux types de hooks :

-   **pre** : les hooks de _pre_ sont exécutés avant une action et peuvent annuler cette action,
-   **post** : les hooks de _post_ sont exécutés après une action.

La liste des hooks standards est dans la [documentation][DocHook].

## Cadre {#quickstart:1247e02d-540e-4974-8ba7-e9c6d885224d}

Lors de la phase de spécification, les éléments suivants ont été identifiés. L'application nécessite :

-   pour les _Audits_ :
    -   le tableau des Fiches de non conformité doit être calculé automatiquement et non modifiable,
    -   la duplication d'un audit peut-être effectuée mais la date d'audit doit être vidée automatiquement,
    -   lorsque la fin de l'audit est dépassée un message doit être affiché pour avertir les utilisateurs,
-   pour les _Référentiels de qualité_ :
    - un référentiel de qualité ne peut pas être supprimé tant que qu'il existe des chapitres associés à ce référentiel.

## Automatisation du calcul d'un tableau {#quickstart:5ce81bd6-b692-4a7e-99f5-cc384b4ba4fd}

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
        $search->addFilter("%s = '%d'",
            \Dcp\AttributeIdentifiers\COGIP_AUDIT_FNC::caf_audit,
            $this->getPropertyValue("initid")
        );
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

-   le filtre de la recherche est fait sur l'`initid` du document en cours,
-   le [`setValue`][DocSetValue] est fait avec un `array` car l'attribut `caa_fnc_fnc` est multiple,
-   la gestion des erreurs dans Dynacase est faite principalement par le retour de la fonction :
    celle-ci renvoie une chaîne de caractères décrivant l'erreur en cours et une chaîne vide lorsque la fonction n'a pas échoué.

Surchargez ensuite la fonction [`postStore`][DocDocPostStore], cette fonction est appelée automatiquement après chaque enregistrement du document :

    [php]
    public function postStore() {
        $err = parent::postStore();
        $err .= $this->computeFNC();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

<span class="flag inline nota-bene"></span>
Il est conseillé de ne pas mettre le code métier directement dans la fonction `postStore`.
Il est ainsi possible de surcharger dans les familles filles les fonctions appelées dans les hooks plus facilement.

<span class="flag inline nota-bene"></span>
Vous remarquerez que la méthode `computeFNC` ne sauvegarde pas les modifications qu'elle effectue (elle n'appelle pas `store`).
En effet, les hooks font automatiquement cette sauvegarde lorsque nécessaire.
De plus, cela permet d'appeler les méthodes concernées en dehors des hooks, sans surcoût particulier.

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_audit].

### Problèmes {#quickstart:59afb583-b9da-4dc2-92d7-69426961562e}

A ce stade si vous déployez les sources modifiées, le formulaire calcule automatiquement la valeur de l'attribut `caa_fnc_fnc`, il reste deux points à résoudre :

-   lors de la modification de l'audit, les utilisateurs peuvent toujours modifier la valeur de l'attribut dans le formulaire,
-   le calcul est effectué seulement lors de la sauvegarde du document audit.
    Si des fiches de non-conformités sont ajoutées, alors que l'audit n'est pas modifié, l'attribut `caa_fnc_fnc` n'est pas à mis à jour.

Pour corriger le premier point, ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv`
et modifiez la [visibilité][DocVisibilite] du tableau des Fiches de non-conformité pour le rendre statique.
Modifiez la colonne `I` :

-   pour l'attribut `caa_a_fnc`, passez la valeur de `W` à `U`,
-   pour l'attribut `caac_fnc_fnc`, passez la valeur de `W` à `S`.

La liste des fiches de non conformité n'est plus modifiable dans les audits en modification.

Vous pouvez retrouver le fichier CSV complété dans les [sources][tuto_struct_audit].

Pour corriger le second point, vous devez modifier la fiche de non conformité pour que, lors de sa sauvegarde,
elle mette à jour l'audit associé.
Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     -   Refresh the list of the audit
     * 
     * @return string
     */
    public function refreshAudit() {
        $err = "";
        $audit = $this->getAttributeValue(MyAttributes::caf_audit);
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
        $err .= $this->refreshAudit();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

<span class="flag inline nota-bene"></span>
Attention à bien appeler le parent lors de la surcharge de la fonction de hook, sinon le code des classes parentes ne serait pas appelé.

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_fnc].

## Duplication {#quickstart:c2f7a2b2-f9d5-4db1-845d-371ba6425317}

Vous allez mettre en place un traitement après la duplication d'un audit pour supprimer les dates de l'audit
dans le nouveau document créé par duplication.

<span class="flag inline nota-bene"></span>
Les liens vers les fiches de non-conformité sont re-calculé automatiquement après la duplication de la page
(car ils sont enregistrés au `postStore`), il est donc inutile de les supprimer après la duplication.

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
    public function postDuplicate($copyFrom) {
        $err = parent::postDuplicate($copyFrom);
        $err .= $this->cleanDate();
        if ($err) {
            error_log(__FILE__ . ":" . __LINE__ . ":" . __METHOD__ . " " . $err . "\n");
        }
    }

<span class="flag inline nota-bene"></span> Attention à penser à transmettre le paramètre $copyFrom au parent.

Si vous souhaitez tester, vous pouvez générer le paquet `<devtool> generateWebinst -s .` et le
déployer.
Vous pouvez ensuite dupliquer le document en utilisant le menu du document `Autres > Dupliquer`.

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_audit].

## Affichage d'un message aux utilisateurs {#quickstart:d0443641-f6fc-419b-9647-c30bc1b2e635}

Vous allez maintenant mettre en place l'affichage conditionnel d'un message aux utilisateurs
lorsque la date de fin d'audit est dépassée.

Ouvrez `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php` et ajoutez la fonction suivante :

    [php]
    /**
     * Check if the end date is in the past
     *
     * @return string
     */
    public function checkEndDate()
    {
        $err = "";
        $date = $this->getAttributeValue(MyAttributes::caa_date_fin);
        if (!empty($date) && $this->getAttributeValue(MyAttributes::caa_date_fin) < new \DateTime()) {
            $err = ___("The end date of the audit is in the past", "COGIP_AUDIT:AUDIT");
        }
        return $err;
    }

Ajoutez ensuite la fonction suivante :

    [php]
    /**
     * Hook executed after the refresh
     * 
     * @return string
     */
    public function postRefresh() {
        $err = parent::postRefresh();
        $err .= $this->checkEndDate();
        return $err;
    }

Si vous souhaitez tester, vous pouvez générer le paquet `<devtool> generateWebinst -s .` et le
déployer.

Une fois le code déployé si la date de fin d'audit est dans le passé vous avez le message suivant qui s'affiche :

![ Message utilisateur ](30-40-postRefresh.png "Message utilisateur")

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_audit].

## Contrôle à la suppression {#quickstart:e1f220a8-aa10-4149-aa4a-a20fd6b4598c}

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
        $search->addFilter("%s = '%d'",
            \Dcp\AttributeIdentifiers\COGIP_AUDIT_CHAPITRE::cac_ref,
            $this->getPropertyValue("initid")
        );
        $search->setSlice(1);
        $nb = $search->onlyCount();
        if ($nb > 0) {
            $return = ___("You have to delete all associated chapter before delete the ref", "COGIP_AUDIT:REFERENTIEL");
        }
        return $return;
    }

Cette fonction effectue une recherche et possède les spécificités suivantes :

-   [`setSlice`][DocSetSlice] : cette fonction indique le nombre maximum de retour de la recherche.
    Dans votre cas, la présence d'un seul élément suffit pour enclencher le rejet de la suppression
    et limiter la recherche à un élément permet de l'accélérer,
-   [`onlyCount`][DocOnlyCount] : cette fonction indique que l'on ne souhaite pas lancer la recherche
    mais juste compter le nombre de résultats de celle-ci.

Ajoutez ensuite la fonction suivante :

    [php]
    public function preDelete() {
        $msg = parent::preDelete();
        $msg .= $this->checkIfAssociatedChapterExist();
        return $msg;
    }

Vous pouvez retrouver le fichier PHP complété dans les [sources][tuto_class_ref].

## Injection de JS ou CSS {#quickstart:bb25d5ff-d5a6-4d26-b32a-26db45de88e7}

Pour finir ce chapitre, le service qualité a jeté un coup d'œil sur vos ajouts et aimerait
que le message envoyé aux utilisateurs soit moins anxiogène et donc moins rouge. 

Vous allez donc ajouter une CSS pour obtenir ce comportement.

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

Cette méthode fait appel à la fonction [`addCssRef`][DocAddCssRef], elle permet d'ajouter une CSS à un document.

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

Les deux fonctions ajoutées s’exécutent respectivement avant l'édition et avant la consultation.
La CSS définie ci-dessus est ajoutée dans le formulaire.

Vous pouvez retrouver les sources complétées dans les [sources][tuto_class_base].

## Conclusion {#quickstart:e066bf1f-a23b-4a8d-bf56-7207147c095b}

Vous allez maintenant produire le paquet.

    <devtool> generateWebinst -s .

Déployez le paquet en passant par Dynacase Control (`http://<nomDeDomaine>/dynacase-control/`) en utilisant le scénario *upgrade* 
(en cas de besoin, n'hésitez pas à consulter les instruction de [déploiement][deploy_instruct]).

Vous pouvez ensuite consulter les modifications apportées via l'application `http://<nomDeDomaine>/dynacase/`.

Vous avez abordé les _hooks_ et leurs fonctionnalités. Ils permettent de surcharger le fonctionnement par défaut
des documents de Dynacase pour implémenter la logique métier de votre projet.

## Voir aussi {#quickstart:3d2825a4-f9f5-45ce-ac3a-099965f178b5}

-   [Les sources après ce chapitre][tuto_zip],
-   [Les hooks][DocHook].

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
[tuto_zip]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-30-40.zip
[tuto_sources]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-30-40/COGIP_AUDIT
[deploy_instruct]: #quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e
[tuto_class_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-40/COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php
[tuto_struct_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-40/COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
[tuto_class_fnc]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-40/COGIP_AUDIT/COGIP_AUDIT_FNC__CLASS.php
[tuto_class_ref]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-40/COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__CLASS.php
[tuto_class_base]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-40/COGIP_AUDIT/COGIP_AUDIT_BASE__CLASS.php
