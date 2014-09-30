# Paramétrage du cycle de vie {#quickstart:44863baa-b9c5-46a7-8a46-d28b4d8696a2}

Ce chapitre aborde le paramétrage du cycle de vie.

## Objectifs {#quickstart:8bf472d9-6bd8-40fe-ac1c-7f8eef15f5a7}

-   Mettre en place les couleurs des étapes,
-   Ajouter des modèles de mail,
-   Ajouter des minuteurs,
-   Effectuer des contrôles avant un changement d'étape,
-   Poser des questions lors d'un changement d'étape.

## Cadre {#quickstart:73d8d0ac-0892-46b2-bd89-3e834ca18b4f}

Lors de la phase d'analyse, les points suivants ont été relevés :

-   chaque étape doit porter un code couleur permettant de l'identifier,
-   un mail doit être envoyé pour notifier les différents acteurs d'un audit de son début,
-   une relance doit être envoyée si un audit reste en rédaction plus de 15 jours,
-   un audit ne peut pas franchir l'étape `En rédaction` tant que toutes les fiches de non-conformité associées ne sont pas closes,
-   lorsqu'un audit est passe à l'état `annulé` une question doit être posée pour en demander la raison,
-   une fois que l'audit n'est plus dans l'étape `Brouillon`,
    le contrôle de cohérence sur la date de début inférieure à la date du jour ne doit plus être appliqué.

## Théorie {#quickstart:86140cda-43d9-44f1-b16f-4f5c2eb39c4e}

Le paramétrage d'un cycle de vie passe par plusieurs éléments distincts :

-   le document de cycle de vie, il permet de paramétrer :
    -   les [mails][DocModelMail],
    -   les [minuteurs][DocMinuteur],
    -   les couleurs,
    -   des éléments de profilages.
-   le fichier PHP de classe du cycle de vie, il permet de mettre en place :
    -   du [code métier][DocWFLClass] qui peut être exécuté avant ou après un changement d'étape,
    -   la liste des questions ([ask][DocWFLask]) qui doivent être posée lors d'un changement d'état.

## Paramétrage via le document {#quickstart:1b65b62f-7169-4e8f-9fe0-aa18d2ca03df}

L'intégralité du paramétrage du document cycle de vie est détaillé dans la [documentation][DocWFLDoc].

### Couleur {#quickstart:f7499780-3582-4e5e-a677-9481b1d94841}

Vous allez commencer par spécifier les couleurs.

Connectez vous à l'interface d'administration : `http://<nomDeDomaine>/admin.php`.

Allez dans l'application `Gestion des documents > Explorateur de documents` cliquez ensuite sur `les cycles`
et sélectionnez le cycle `Audit Audit`.

![ Cycle de vie : Audit ](40-30-edit-wfl-audit.png "Cycle de vie : Audit")

Cliquez ensuite sur `Modifier` et sélectionnez l'onglet `Étapes`

![ Cycle de vie : Audit ](40-30-edit-wfl-audit1.png "Cycle de vie : Audit")

Le document cycle de vie contient pour chaque étape et transition une série de champs
qui permettent de spécifier son comportement. Vous allez modifier les entrées `Couleur` de chaque étape.

<span class="flag inline nota-bene"></span>
Même si l'attribution d'une couleur à chaque étape peut sembler accessoire, il reste important et facilite
la prise en main par les utilisateurs de l'application que vous produisez.

<span class="flag inline nota-bene"></span>
Il est conseillé de suivre un code couleur cohérent et d'identifier les étapes similaires par des teintes similaires
et de choisir des couleurs qui dans la culture des utilisateurs sont en cohérence avec la signification des étapes.

Pour votre cycle, il a été décidé en concertation avec les utilisateurs les couleurs suivantes :

-   __<span style="background-color: #F2FFF9;">Brouillon</span>__ : `#F2FFF9`,
-   __<span style="background-color: #96EAFF;">Planifié</span>__ : `#96EAFF`,
-   __<span style="background-color: #BFD3D6;">Annulé</span>__ : `#BFD3D6`,
-   __<span style="background-color: #8CFF8C;">Certifié</span>__ : `#8CFF8C`,
-   __<span style="background-color: #FF8282;">Refusé</span>__ : `#FF8282`.

Ce qui donne le cycle suivant :

![ Cycle de vie : Audit coloré ](40-30-audit-color.png "Cycle de vie : Audit coloré")

<span class="flag inline nota-bene"></span> Les couleurs des étapes se retrouvent dans les interfaces standard de Dynacase.

![ Interface standard : utilisation des couleurs d'étapes ](40-30-audit-interface-color.png "Interface standard : utilisation des couleurs d'étapes")

<span class="flag inline nota-bene"></span>
__Attention__, il faut exporter le document de cycle de vie et mettre à jour sa définition dans le fichier
`COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv` pour que ce paramétrage soit valide en dehors du contexte de développement.

Vous pouvez trouver le document complété dans [les sources][tuto_color].

### Les mails {#quickstart:284cd032-303b-4140-bb44-72a30843d0c8}

Ouvrez le document de cycle de vie en modification.

Dans votre spécification, il est indiqué que le mail doit être envoyé lors du démarrage de l'audit.

Sélectionnez l'onglet `Transitions` et cliquez le `+` à droite de `Modèle de courriel Démarrer`.

![ Ajout de mail : interface ](40-30-add-mail.png "Ajout de mail : interface")

Une fenêtre d'édition de [mail][DocModelMail] pré-paramétrée s'ouvre alors :

![ Ajout de mail : modification ](40-30-add-mail-edition.png "Ajout de mail : modification")

<span class="flag inline nota-bene"></span>
Cette fenêtre contient des données provenant de son formulaire de création (Famille et Famille Cycle).
Vous pouvez paramétrer vos documents pour avoir le même comportement à l'aide de l'option [creation][DocCreation].

Complétez les champs suivants :

-   Titre : Mail de démarrage d'audit,
-   Émetteur : Laissez ce champ vide dans ce cas c'est le mail de la personne effectuant le changement d'étape qui sera utilisé,
-   Destinataires : Vous allez indiquer les destinataires du mail
    -   Type : Attribut Relation, Destinataire : `caa_auditeur_auditeur (Auditeur)`,
    -   Type : Attribut Relation, Destinataire : `caa_resp_audit (Responsable d'audit)`,
    -   Type : Attribut Relation, Destinataire : `caa_site (Site audité)`.
-   Titre : `L'audit [TITLE] vient de démarrer`
-   Corps : 

    Bonjour,
    
    L'audit [V_TITLE] va commencer le [V_CAA_DATE_DEBUT] et se terminer le [V_CAA_DATE_FIN].
    
    Bien à vous,

Cliquez sur Sauvez.

Cliquez sur `Autres > Propriétés` et ajoutez le nom logique `MAIL_DEMARRAGE`.

Vous pouvez fermer la fenêtre de création et cliquez sur le bouton `sauver` du cycle de vie.

Une fois ce paramétrage fait lors du changement d'état en passant par la transition un mail est envoyé.

<span class="flag inline nota-bene"></span>
Il est aussi possible d'attacher des mails à une étape, dans ce cas le mail est envoyé à chaque passage dans l'étape,
quelle que soit la transition utilisée pour parvenir dans cette étape.

![ Mail : exemple ](40-30-mail.png "Mail : exemple")

Vous pouvez trouver le modèle de mail complété dans [les sources][tuto_mail_dem].

### Relance (timer) {#quickstart:67c58ac9-a1df-4d22-9bb6-8172a3adfb1d}

Ouvrez le document de cycle de vie en modification.

<span class="flag inline nota-bene"></span>
Il existe plusieurs manière d'affecter les minuteurs, elles sont décrites dans la [documentation][DocMinuteur].

Vous allez créer un minuteur simple, celui-ci est attaché au document lors du passage de la transition
et détaché au prochain changement d'état.

Sélectionnez l'onglet `Transitions` et cliquez le `+` à droite de `Minuteur Démarrer`.

L'interface suivante est ouverte :

![ Minuteur création ](40-30-minuteur-creation1.png "Minuteur création")

Remplissez les champs suivants :

-   Titre : Démarrer,
-   Délai (en jours) (première ligne) : 15

#### Création du mail associé {#quickstart:b3e8706a-1c26-49cc-b530-b36f3ee7d018}

Cliquez sur le `+` dans la colonne `Modèle de mail` pour initier le modèle de mail.

Remplissez les champs de la manière suivante :

-   Titre : `Relance rédaction`,
-   Destinataires :
    -   Type : `Attribut relation`, Destinataire : `caa_resp_audit (Responsable d'audit)`,
    -   Type : `Attribut relation`, Destinataire : `caa_auditeur_auditeur (Auditeur)`.
-   Sujet : `L'audit [TITLE] est toujours en rédaction`,
-   Corps : 

    Bonjour,
    
    L'audit [V_TITLE] est en rédaction depuis 15 jours.
    
    Bien à vous,

Et cliquez sur `Créer`. Ajoutez ensuite un nom logique `Autres > Propriétés` : `MAIL_REDACTION_RELANCE`.

![ Minuteur mail ](40-30-minuteur-mail.png "Minuteur mail")

Fermez ensuite la fenêtre. 

Sélectionnez la fenêtre contenant le minuteur en cours de paramétrage. 

Cliquez sur les `...` dans la colonne `Modèle de mail` et sélectionnez le mail `Relance rédaction.`.

Cliquez sur `Créer`, le document se ferme.

Cliquez sur `Sauver`.

![ Minuteur ](40-30-minuteur-wdoc.png "Minuteur")

<span class="flag inline nota-bene"></span>
Vous allez utiliser le minuteur pour effectuer une relance par mail, mais celui-ci permet aussi :

-   de changer automatiquement d'état le document auquel est associé le document,
-   de lancer une méthode sur le document associé au cycle de vie.

<span class="flag inline nota-bene"></span>
Les différentes options pour paramétrer les règles de relance sont décrites dans la [documentation][DocMinuteur].

#### Nom logique {#quickstart:598741bf-95c4-486b-b8f0-114fb6196d74}

Cliquez sur le lien `Minuteur démarrer` puis sur `Autres > Propriétés` et donnez le nom suivant `MINUTEUR_DEMARRER`.

<span class="flag inline nota-bene"></span>
Vous pouvez suivre les différents minuteurs en activité grâce à l'interface de suivi qui est dans l'admin
`Gestion des documents > Gestion des minuteurs`.

### Export du paramétrage {#quickstart:6633ab3c-ab35-48ad-93a9-71898bfad9f3}

Vous allez maintenant exporter le paramétrage que vous avez mis en place.
Vous avez plusieurs manières de faire cette action, soit :

-   vous sélectionnez les documents à exporter les uns après les autres,
-   vous exportez un des documents de familles associés au cycle de vie.
    Dans ce cas l'ensemble des documents de paramétrages de la famille sont exportés.

Vous allez exporter l'ensemble des documents en une seule fois.

Connectez vous à l'interface d'administration : `http://<nomDeDomaine>/admin.php`.

Ouvrez la `Gestion des documents > Accès aux documents systèmes`, sélectionnez la famille `Audit`.

![ Famille Audit ](40-30-wdoc-export.png "Famille Audit")

Cliquez sur `Autres > Ajoutez au porte-documents`, videz les documents non utiles du porte-documents, puis cliquez sur
`Outils > Exportation du dossier`.

Sélectionnez `Profil` `Avec les profils` et cliquez sur `Exporter`.

![ Famille Audit ](40-30-wdoc-export-csv.png "Famille Audit")

Le fichier CSV qui vous est envoyé contient une partie du paramétrage de la famille,
ce qui inclut le paramétrage du cycle de vie.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv`.

Supprimez les documents que vous avez déjà dans le fichier de paramétrage, soit les :

-   PFAM,
-   PDOC,
-   et les lignes entre BEGIN et END.

Ajoutez les nouveaux documents au début du fichier `__PARAM.csv`, soit :

-   `WDOC_COGIP_AUDIT_AUDIT_WFL` : il contient la définition des couleurs et la référence au timer et au modèle de mail,
-   `MAIL_DEMARRAGE` : il contient le modèle de mail envoyé au démarrage de l'audit,
-   `MINUTEUR_DEMARRER` : il contient le timer ajouté lors du passage de la transition démarrer,
-   `MAIL_REDACTION_RELANCE` : il contient le modèle de mail envoyé en cas de relance.

![ Famille Audit ](40-30-wdoc-import-csv.png "Famille Audit")

Vous pouvez trouver le modèle de mail complété dans [les sources][tuto_minuteur].

## Paramétrage via le code {#quickstart:bc42ac10-2bf8-48fc-850b-30caf71b72d8}

L'intégralité du paramétrage du cycle de vie via le code est détaillé dans la [documentation][DocWFLClass].

### Contrôle au changement d'état {#quickstart:edf4add4-7cde-4fc7-a0a9-56caab45516a}

Les contrôle au changement d'état se font lors des [transitions][DocTransition],
il existe quatre hook de transition utilisés pour :

-   `m0` : savoir si la transition est possible.
    Si le hook retourne un message la transition est annulée,
-   `m1` : modifier le document avant la transition.
    Si des questions (ask) sont paramétrées elles sont présentées avant le m1.
    Si le hook retourne un message la transition est annulée,
-   `m2` : modifier le document juste après le changement d'état
    Ce hook ne peut plus annuler le changement d'état,
-   `m3` : modifier le document après le changement d'état et après les différents traitements automatiques de Dynacase.

#### m0 (pré-condition) {#quickstart:1fbdce8d-c8dc-44b7-ad87-cd8348ac0d12}

Vous allez utiliser le `m0` pour vérifier que les fiches de non-conformités associées à l'audit sont bien toutes closes
avant d'accorder ou de refuser la certification.

##### Définition de la fonction {#quickstart:3ddde06d-f233-4e54-980a-8264e370ef9b}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__WFL__CLASS.php` et ajoutez la fonction suivante :

    [php]
    public function checkAssociatedFNC()
    {
        //Search in the FNC
        $searchDoc = new \SearchDoc("", \Dcp\Family\Cogip_audit_fnc::familyName);
        //If you find one FNC it's enough (speed the search)
        $searchDoc->setSlice(1);
        $searchDoc->addFilter("%s = '%d'", \Dcp\AttributeIdentifiers\Cogip_audit_fnc::caf_audit, $this->doc->getPropertyValue("initid"));
        $searchDoc->addFilter("state <> '%s'", COGIP_AUDIT_FNC__WFL::e_clos);
        if ($searchDoc->onlyCount() > 0) {
            return _("coa:You have to close all FNC before change state");
        }
        return "";
    }

Cette fonction effectue une recherche sur les FNC, elle a les spécificités suivantes :

-   elle recherche parmi les `Fiches de non-conformités`,
-   la recherche limite le nombre de résultat à 1,
    car un seul résultat suffit à indiquer que la transition ne doit pas être franchie,
-   la recherche utilise la fonction [`onlyCount`][DocSearchOnlyCount].
    Cette fonction calcule uniquement le nombre de résultats et ne retourne pas les documents.

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_code].

##### Enregistrement de la fonction {#quickstart:587bf536-180e-4878-9c02-9b0f2969c441}

Modifiez le tableau de déclaration des transitions :

    [php]
    public $transitions = array(
        self::t_brouillon__redaction => array("nr" => true),
        self::t_brouillon__annule => array("nr" => true),
        self::t_redaction__brouillon => array("nr" => true),
        self::t_redaction__certif => array("nr" => true, "m0" => "checkAssociatedFNC"),
        self::t_redaction__refus_certif => array("nr" => true, "m0" => "checkAssociatedFNC"),
    );

Vous avez déclaré deux hooks de `m0` qui seront déclenchés lors de l'affichage de la liste des états.

![ m0 ](40-30-m0-capture.png "m0")

Dans l'exemple ci-dessus la transition est refusée et au survol un message est affiché à l'utilisateur.

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_code].

### Question au changement d'état (ask) {#quickstart:52b12e42-a3e8-4b7f-a7a2-bf0c77f2691c}

Vous allez maintenant mettre en place le mécanisme de [`ask`][DocWFLask].
Il permet de poser un ensemble de question via un petit formulaire lors d'un changement d'état.

#### Déclaration du ask {#quickstart:1a89239f-465e-464e-8098-cf59854371d3}

Les ask se composent de deux éléments :

-   un paramètre de famille qui va servir de conteneur à la question,
    ce paramètre permet de définir le type de donnée et une éventuelle valeur par défaut, etc.,
-   l'association d'un ou plusieurs paramètres à une transition.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__WFL.csv` et ajoutez les lignes suivantes :

![ Déclaration _ask_ ](40-30-wdoc-ask-declaration.png  "Déclaration _ask_")

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_wfl].

Vous avez déclaré deux paramètres, ceux-ci peuvent être utilisés comme _ask_.
Vous allez mettre à jour la liste des transitions :

    [php]
        public $transitions = array(
            self::t_brouillon__redaction => array(
                "nr" => true
            ),
            self::t_brouillon__annule => array(
                "nr" => true,
                "ask" => \Dcp\AttributeIdentifiers\Cogip_audit_audit__wfl::caaw_raison
            ),
            self::t_redaction__brouillon => array(
                "nr" => true
            ),
            self::t_redaction__certif => array(
                "nr" => true,
                "m0" => "checkAssociatedFNC"
            ),
            self::t_redaction__refus_certif => array(
                "nr" => true,
                "m0" => "checkAssociatedFNC"
            )
        );

Vous avez ajouté un array sur la transition `self::t_brouillon__annule`,
celui-ci est référencé par la clef `ask` et contient la liste des ask qui vont être présentés à l'utilisateur.

Lors du passage de la transition, le ask est présenté sous la forme d'une fenêtre posant la question :

![ Ask : démonstration ](40-30-wdoc-ask-capture.png  "Ask : démonstration")

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_code].

#### Utilisation du ASK {#quickstart:e7fe1de5-f5da-45dc-bbb2-2ca0f4449477}

Les valeurs de retour du ASK peuvent être utilisées au m1, m2 et m3 et dans les modèles de mail.

Dans votre cas, vous allez utiliser le retour du ask pour le stocker dans l'historique du document.

Ajoutez la fonction suivante :

    [php]
    public function handleRaison()
    {
        $this->doc->addHistoryEntry($this->getRawValue(\Dcp\AttributeIdentifiers\Cogip_audit_audit__wfl::caaw_raison));
    }

et modifiez la liste des transitions :

    [php]
    public $transitions = array(
        self::t_brouillon__redaction => array("nr" => true),
        self::t_brouillon__annule => array("nr" => true,
            "ask" => array(\Dcp\AttributeIdentifiers\Cogip_audit_audit__wfl::caaw_raison),
            "m2" => "handleRaison"
        ),
        self::t_redaction__brouillon => array("nr" => true),
        self::t_redaction__certif => array("nr" => true, "m0" => "checkAssociatedFNC"),
        self::t_redaction__refus_certif => array("nr" => true, "m0" => "checkAssociatedFNC"),
    );

Vous avez ajouté une fonction qui utilise et enregistre dans l'historique la valeur du ask
et ensuite vous avez enregistré cette fonction au `m2` de la transition `self::t_brouillon__annule`.

![ Ask : historique ](40-30-wdoc-ask-histo.png  "Ask : historique")

Une fois la transition de retour franchie, si l'utilisateur clique sur le menu `historique`,
l'interface ci-dessus est présentée.

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_code].

## Mise à jour des contrôle de cohérence {#quickstart:85a0bad9-9e7f-424f-b5d3-88aea4616944}

Vous allez maintenant modifier le contrôle de cohérence que vous avez mis en place sur les [dates][contrainte]
pour que le contrôle ne se déclenche que lorsque la fiche est à l'état `Brouillon`.

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php`
et modifiez la fonction `checkDate` pour qu'elle soit identique à :

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
        if (!empty($date)
            && $this->getPropertyValue("state") === COGIP_AUDIT_AUDIT__WFL::e_brouillon
            && $this->getAttributeValue(MyAttributes::caa_date_fin) < new \DateTime()) {
            $err = ___("The end date of the audit is in the past", "COGIP_AUDIT:AUDIT");
        }
        return $err;
    }

Vous avez ajouté une condition pour que la contrainte ne se déclenche qu'à l'état `Brouillon`.

Vous pouvez trouver le fichier complété dans [les sources][tuto_audit_class].

## Conclusion {#quickstart:72d48b82-db47-4c82-9d5e-a7cb5b6077e2}

Vous allez maintenant déployer vos modifications. Vous allez produire le paquet.

    php <path_to_devtool>/devtool.phar generateWebinst -i .

Vous obtenez alors un fichier `webinst` que vous allez déployer en passant par Dynacase Control `http://<content>/dynacase-control/`.
Vous sélectionnez votre contexte et cliquez sur le bouton `Import module`. Choisissez la stratégie de déploiement `Upgrade`.

Vous connaissez les principales manipulations que vous pouvez effectuer avec un cycle de vie,
que ça soit à l'aide du document cycle de vie ou de la classe de la famille cycle de vie.

Ces paramétrages permettent de créer simplement des cycles complets et riches et de guider les utilisateurs.

## Voir aussi {#quickstart:837931f9-3475-4494-9f2b-c09327ec4603}

-   [Les sources après ce chapitre][tuto_zip],
-   [Document workflow][DocWFLDoc],
-   [Modèle de mail][DocModelMail],
-   [Minuteur][DocMinuteur],
-   [Code de cycle de vie][DocWFLClass],
-   [Ask][DocWFLask].

<!-- links -->

[DocCreation]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:d461d5f5-b635-47a0-944d-473c227587ab.html#core-ref:9bcfd205-fb07-4a71-be06-ba07d4a9cc7c "Documentation : création"
[DocModelMail]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:8723b1aa-10d3-4316-af6b-071f4d59ceee.html#core-ref:8723b1aa-10d3-4316-af6b-071f4d59ceee "Documentation : modèle de mail"
[DocMinuteurType]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b541e22f-5ece-4d19-8460-0cb0c5f3ec7a.html#core-ref:0c1a2bdc-ee8c-46f1-a463-cb0094b34364 "Documentation : minuteur"
[DocMinuteur]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:3de1c186-e1ab-44a3-b3b1-536d2f9a7554.html#core-ref:3de1c186-e1ab-44a3-b3b1-536d2f9a7554 "Documentation : minuteur"
[DocWFLDoc]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b541e22f-5ece-4d19-8460-0cb0c5f3ec7a.html#core-ref:b541e22f-5ece-4d19-8460-0cb0c5f3ec7a "Documentation : document workflow"
[DocWFLClass]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b8824399-f17d-4007-adde-8a7433939273.html#core-ref:b8824399-f17d-4007-adde-8a7433939273 "Documentation : code"
[DocWFLask]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:91e2017b-d595-47b3-bfc6-3b57c932b989.html#core-ref:9e248e52-ad6b-4089-ab83-11a534b307e9 "Documentation : ask"
[DocTransition]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:91e2017b-d595-47b3-bfc6-3b57c932b989.html#core-ref:ed74f035-ec6f-4e63-ae61-014a2947a6aa "Documentation : transition"
[DocSearchOnlyCount]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:2d43be1a-1991-42dd-a25d-5c3bb0b393fa.html#core-ref:2d43be1a-1991-42dd-a25d-5c3bb0b393fa "Documentation : searchDoc::onlyCount"
[contrainte]: #quickstart:ec7f3353-9d8f-4813-adda-ab1a964e2760
[tuto_zip]: https://github.com/Anakeen/dynacase-quick-start-code/archive/after-40-30.zip
[tuto_color]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv#L3
[tuto_mail_dem]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv#L5-L7
[tuto_minuteur]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv#L8-L13
[tuto_audit_code]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__WFL.php
[tuto_audit_wfl]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__WFL.csv#L5-L7
[tuto_audit_class]: https://github.com/Anakeen/dynacase-quick-start-code/blob/after-40-30/COGIP_AUDIT/COGIP_AUDIT_AUDIT__CLASS.php#L78