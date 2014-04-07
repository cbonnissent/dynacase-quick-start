# Structure du cycle de vie  {#quickstart:b7a610e2-e53e-45ca-bc19-bac9f55b468c}

Ce chapitre va vous permettre d'initialiser vos cycles de vie, en créer la structure et l'associer à une famille.

## Objectifs {#quickstart:c7e46a11-3004-4de3-89c2-5180d9e28336}

* Créer un cycle de vie,
* Initialiser la forme du cycle de vie (étapes et transitions),
* Traduire le cycle de vie,
* Ajouter le cycle au `webinst`.

## Cadre {#quickstart:7ca59299-15ad-4161-a274-278a7f9403f4}

L'analyse des besoins à mis en évidence le besoin de deux cycles de vie dans votre application.

Deux cycles ont été identifiés :

* les audits
![ Cycle : audit ](40-20-graph-audit.png "Cycle : audit")
* les FNC
![ Cycle : FNC ](40-20-graph-FNC.png "Cycle : FNC")

## Théorie {#quickstart:3a5e9193-5131-4e58-8b6a-6a2744ee7d00}

La structure d'un cycle de vie fait appel aux concepts suivants :

* **Étape** : Elles marquent un moment clef dans la vie du document. Une étape est constituée de :
    * **État**: c'est le statut du document à un moment donné (par exemple : brouillon, rédigé, validé, historique),
    * **Activité** : c'est la tâche en cours de réalisation sur un document donné (par exemple : en rédaction, en validation).
* **Transition** : Elles indiquent la possibilité de passage entre une étape et une autre.

Les cycles de vie sont représentés par deux objets systèmes :

* une famille : elle décrit la structure et contient le code métier,
* un document : il décrit le paramétrage (mails envoyés, couleurs, etc.).

## Initialisation des fichiers {#quickstart:a68c1cbc-e277-4908-95ea-a46cd36cc0b4}

### Cycle des audits {#quickstart:4b8012f7-a650-4e63-9015-4c7d577892b6}

Ouvrez le **developper toolkit** et cliquez sur **Template** et ensuite **Create a workflow**, l'outil vous demande de saisir :

* path : le path vers le répertoire `COGIP_AUDIT`,
* logical name : `WFL_COGIP_AUDIT_AUDIT`,
* [namespace][php_namespace] : `COGIP`.

Cliquez sur `generate`.

Deux fichiers sont générés :

    ./COGIP_AUDIT
    ...
    ├── COGIP_AUDIT_AUDIT__WFL__CLASS.php
    ├── COGIP_AUDIT_AUDIT__WFL.csv

Le fichier `__CLASS.php` contient le code métier et la structure du cycle de vie, le fichier CSV contiendra quelques éléments de paramétrage.

Le fichier est initialisé avec les éléments suivants :

    [php]
    namespace Cogip;
    
    class COGIP_AUDIT_AUDIT_WFL extends \Dcp\Family\WDoc
    {
        public $attrPrefix = 'FIXME'; //FIXME: set attrPrefix
        public $firstState = 'FIXME'; //FIXME: set FirstState
        public $viewlist = "none";
    
        //region States
        const e_E1 = 'FIXME'; //FIXME: set E1
        //endregion
    
        //region Transitions
        const t_E1__E2 = 'FIXME'; //FIXME: set T1
        //endregion
    
        public $stateactivity = array(
            //FIXME: set stateactivity
        );
    
        public $transitions = array(
            //FIXME: set transitions
        );
    
        public $cycle = array(
            //FIXME: set cycle
        );
    
    }

### Préfixe {#quickstart:0ead1a07-3bd1-490e-ba4e-406055d8d198}

L' `$attrPrefix` est utilisé lors de la génération de la table de stockage du cycle de vie pour éviter des collisions de noms.

Complétez la valeur de `$attrPrefix` à `caaw`.

### États {#quickstart:b2de0c9b-9c3b-4b5c-aab6-11a2b18a3888}

Vous allez ensuite définir la liste des constantes représentant les états. Pour chaque état, vous allez indiquer un nom logique qui porte sa référence.

    [php]
    //region States
    const e_brouillon = 'coa_audit_e1';
    const e_annule = 'coa_audit_e2';
    const e_redaction = 'coa_audit_e3';
    const e_certifie = 'coa_audit_e4';
    const e_refus_certif = 'coa_audit_e5';
    //endregion

<span class="flag inline nota-bene"></span> Il est conseillé de mettre les noms des états sous la forme d'un identifiant *neutre* (id, uuid) pour pouvoir plus simplement gérer le changement de forme du cycle de vie et de paramétrage de celui-ci.

<span class="flag inline nota-bene"></span> Il est conseillé de préfixer les constantes par `e_` pour en faciliter l'extraction des clefs pour la traductions.

<span class="flag inline nota-bene"></span> Les commentaires `//region States` et `//endregion` sont une convention de certains éditeurs ([PhpStorm][phpStormFolding], etc.) qui permet de replier et retrouver plus facilement cette zone.

### Activités {#quickstart:41ca59ea-f036-4918-94c3-12c2697e274c}

Les activités sont un deuxième libellé qui est apposé à un étape. Il décrit l'activité qui doit avoir lieu lors de cette étape.

    [php]
    public $stateactivity = array(
        self::e_brouillon => "coa:audit:planning",
        self::e_redaction => "coa:audit:writing"
    );

<span class="flag inline nota-bene"></span> En théorie, les étapes finales d'un cycle n'ont pas d'activité. Par exemple, une fois l'audit `Certifié`, `Annulé` ou `Refusé`, il n'y a plus de travail à effectuer sur cet audit donc pas d'activité.

### Transitions {#quickstart:9b6709f4-c6fd-461e-b142-8e346a6f17cf}

#### Constantes {#quickstart:1c83eae6-09c0-4740-87ad-8464066261fc}

Vous allez ensuite définir la liste des constantes représentant les transitions. Pour chaque transition, vous allez indiquer un nom logique qui porte sa référence.

    [php]
    //region Transitions
    const t_brouillon__redaction = 'coa_audit_t1';
    const t_brouillon__annule = 'coa_audit_t2';
    const t_redaction__brouillon = 'coa_audit_t3';
    const t_redaction__certif = 'coa_audit_t4';
    const t_redaction__refus_certif = 'coa_audit_t5';
    //endregion

<span class="flag inline nota-bene"></span> Il est conseillé de mettre les noms des états sous la forme d'un identifiant *neutre* (id, uuid) pour pouvoir plus simplement gérer le changement de forme du cycle de vie et de paramétrage de celui-ci.

<span class="flag inline nota-bene"></span> Il est conseillé de préfixer les constantes par `t_` pour en faciliter l'extraction des clefs pour la traductions.

<span class="flag inline nota-bene"></span> Il est possible d'utiliser la même transition pour relier deux étapes mais ce fonctionnement est déconseillé car tous le paramétrage de la transition est alors partagé, notamment les droits d'accès ce qui rend le cycle moins facilement paramétrable.

<span class="flag inline nota-bene"></span> Il est conseillé de nommer les transitions sous la forme `t_<etat1>__<etat2>` pour en faciliter le paramétrage.

#### Paramétrage {#quickstart:9ec307d5-d547-47ef-b4ba-b2f56233de87}

Vous allez maintenant enregistrer les constantes dans le tableau des transitions.

    [php]
    public $transitions = array(
        self::t_brouillon__redaction => array("nr" => true),
        self::t_brouillon__annule => array("nr" => true),
        self::t_redaction__brouillon => array("nr" => true),
        self::t_redaction__certif => array("nr" => true),
        self::t_redaction__refus_certif => array("nr" => true),
    );

Ce tableau est le seul élément obligatoire, il répertorie l'ensemble des transitions existantes et [leur paramétrage][DocTransition].

### Cycle {#quickstart:86ecf616-c0f1-420f-b14f-b2afc593334f}

Pour terminer, vous allez enregistrer la forme du cycle en utilisant [`$cycle`][DocCycle].

    [php]
    public $cycle = array(
        array("t" => self::t_brouillon__redaction, "e1" => self::e_brouillon, "e2" => self::e_redaction),
        array("t" => self::t_brouillon__annule, "e1" => self::e_brouillon, "e2" => self::e_annule),
        array("t" => self::t_redaction__brouillon, "e1" => self::e_redaction, "e2" => self::e_brouillon),
        array("t" => self::t_redaction__certif, "e1" => self::e_redaction, "e2" => self::e_certifie),
        array("t" => self::t_redaction__refus_certif, "e1" => self::e_redaction, "e2" => self::e_refus_certif),
    );

Le tableau de cycle est composé de tableau, chacun de ces tableaux a trois entrées :

* `t` : porte la référence vers une transition,
* `e1` : porte la référence vers l'état de départ,
* `e2` : porte la référence vers l'état d'arrivée.

### Premier état {#quickstart:c6b05ec6-de0e-49f4-ad13-8fe2aee9b93a}

Vous allez maintenant définir le premier état de votre cycle. Passez `$firstState = self::e_brouillon`.

### Résultat {#quickstart:0e13de8d-2d7e-4423-88cf-bb991645fb9a}

Vous avez terminé la déclaration de la structure. Le fichier doit donc contenir :

    [php]
    namespace Cogip;
    
    class COGIP_AUDIT_AUDIT_WFL extends \Dcp\Family\WDoc
    {
        public $attrPrefix = 'caaw';
        public $firstState = self::e_brouillon;
        public $viewlist = "none";
    
        //region MyAttributes-constants
        //endregion
    
        //region States
        const e_brouillon = 'coa_e1';
        const e_annule = 'coa_e2';
        const e_redaction = 'coa_e3';
        const e_certifie = 'coa_e4';
        const e_refus_certif = 'coa_e5';
        //endregion
    
        //region Transitions
        const t_brouillon__redaction = 'coa_t1';
        const t_brouillon__annule = 'coa_t2';
        const t_redaction__brouillon = 'coa_t3';
        const t_redaction__certif = 'coa_t4';
        const t_redaction__refus_certif = 'coa_t5';
        //endregion
    
        public $stateactivity = array(
            self::e_brouillon => "coa:planning",
            self::e_redaction => "coa:writing"
        );
    
        public $transitions = array(
            self::t_brouillon__redaction => array("nr" => true),
            self::t_brouillon__annule => array("nr" => true),
            self::t_redaction__brouillon => array("nr" => true),
            self::t_redaction__certif => array("nr" => true),
            self::t_redaction__refus_certif => array("nr" => true),
        );
    
        public $cycle = array(
            array("t" => self::t_brouillon__redaction, "e1" => self::e_brouillon, "e2" => self::e_redaction),
            array("t" => self::t_brouillon__annule, "e1" => self::e_brouillon, "e2" => self::e_annule),
            array("t" => self::t_redaction__brouillon, "e1" => self::e_redaction, "e2" => self::e_brouillon),
            array("t" => self::t_redaction__certif, "e1" => self::e_redaction, "e2" => self::e_certifie),
            array("t" => self::t_redaction__refus_certif, "e1" => self::e_redaction, "e2" => self::e_refus_certif),
        );
    
    }

## Traduction {#quickstart:7290190d-50f3-4094-8941-7a3395f9f74f}

Vous allez maintenant extraire les clefs permettant de traduire votre cycle de vie.

Reprenez le **developper toolkit** et cliquez sur le bouton `internationalisation`, vous indiquez alors le path vers vos sources et cliquer sur le bouton `extraction`.

Les clefs suivantes sont ajoutées dans le fichier `locale/fr/LC_MESSAGES/src/COGIP_AUDIT.po`

    msgid "coa:planning"
    msgstr "En planification"
    
    msgid "coa:writing"
    msgstr "En rédaction"
    
    msgid "coa_e1"
    msgstr "Brouillon"
    
    msgid "coa_e2"
    msgstr "Annulé"
    
    msgid "coa_e3"
    msgstr "Planifié"
    
    msgid "coa_e4"
    msgstr "Certifié"
    
    msgid "coa_e5"
    msgstr "Refusé"
    
    msgid "coa_t1"
    msgstr "Démarrer"
    
    msgid "coa_t2"
    msgstr "Annuler l'audit"
    
    msgid "coa_t3"
    msgstr "Renvoyer en planification"
    
    msgid "coa_t4"
    msgstr "Accorder la certification"
    
    msgid "coa_t5"
    msgstr "Refuser la certification"

## Inscription dans le paquet {#quickstart:3094c4a5-631d-491f-b5cb-4fa688c1bd09}

Vous allez maintenant inscrire votre cycle de vie dans le paquet pour qu'il soit importé à l'installation et à la mise à jour.

Ajoutez la ligne suivante dans le `info.xml` à l'installation et à la mise à jour entre les lignes `<process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv"/>` et `<process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv"/>`:

    [xml]
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__WFL.csv"/>
    <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv"/>

## Génération du document {#quickstart:c343a2f1-6ad0-4ad2-bbdb-bfed3ddd846c}

### Création {#quickstart:0cb52cff-7687-4ce7-8000-40a3221e3bbb}

Vous allez maintenant générer le document de cycle de vie.

Pour cela générez le `webinst` et importez le.

Connectez vous à l'interface d'administration : `http://<nomDeDomaine>/admin.php`.

Cliquez sur `Gestion des documents > Explorateurs de documents` et cliquez sur `Création > Documents système` en haut dans la partie de droite, l'interface de création de documents s'ouvre sur la partie droite.

![ Création workflow ](40-20-creation-wfl1.png "Création workflow")

Sélectionnez ensuite votre cycle de vie dans la liste déroulante en haut `COGIP_AUDIT_AUDIT_WFL`.

Complétez le formulaire présenté avec les éléments suivants :

* **Titre** : Audit,
* **Famille** (Basique et Profil Dynamique) : `COGIP_AUDIT_AUDIT`.

![ Création workflow ](40-20-creation-wfl2.png "Création workflow")

Cliquez ensuite sur `Créer`.

Si vous cliquez sur `Voir le graphe`, vous pouvez consulter une représentation graphique du cycle de vie :

![ Graphe cycle audit ](40-20-graph-audit-generated.png "Graphe cycle audit")

### Paquet webinst {#quickstart:dd64e324-c050-46e4-8454-940c0e95d4bc}

#### Nom logique {#quickstart:0b81cb6c-c93b-4e48-a02c-e5bca4114c56}

Ajoutez un nom logique au cycle de vie, cliquez sur `Autres > Propriétés` et ajoutez le nom `WDOC_COGIP_AUDIT_AUDIT_WFL`.

#### Export {#quickstart:bacf9a03-0af5-4b52-afb5-e7f22f04a064}

Ajoutez le cycle au porte-documents `Autres > Ajouter au porte-documents` (pensez à supprimer les éventuels autres documents au porte-documents), cliquez ensuite sur `Outils > Exportation du dossier`. La fenêtre d'exportation s'ouvre, cliquez sur `Exporter`.

Un fichier CSV vous est envoyé.

#### Enregistrement {#quickstart:6e1f919b-a74e-4d84-8fab-182bc556f9a2}

Vous allez ajouter ce document dans le fichier de paramétrage de la famille `Audit`. Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv` ajoutez au début du fichier les trois lignes contenues dans le fichier d'exportation.

Pour finir, vous allez ajouter l'instruction qui associe le cycle de vie des audits à la famille audit.

Ajoutez une ligne juste avant le `END` les éléments suivant :

* colonne `A` : `WID`,
* colonne `B` : `WDOC_COGIP_AUDIT_AUDIT_WFL`.

<span class="flag inline nota-bene"></span> L'instruction [WID est explicité dans la documentation.][DocWID]

## Conclusion {#quickstart:c655d20b-7edd-4fb1-979f-4d3978ce52a3}

Vous avez initié la structure d'un des cycles de vie et associé celui-ci à sa famille.
Dans les prochains chapitres, vous verrez comment paramétrer, ajouter du code métier et profiler vos cycles de vie.

La réalisation de la structure du cycle des non-conformités n'est pas décrite dans ce chapitre, mais vous pouvez trouver les fichiers complet dans la solution du chapitre.

## Voir aussi {#quickstart:59b3f403-b656-4a8f-86b8-c368f64e08d8}

* [Documentation cycle de vie][DocCycleDeVie],
* [Transition][DocTransition],
* [Cycle][DocCycle],
* [Instruction WID][DocWID].

<!-- links -->

[php_namespace]: http://www.php.net/manual/en/language.namespaces.rationale.php "Doc PHP : namespace"
[phpStormFolding]: https://www.jetbrains.com/phpstorm/webhelp/folding-custom-regions-with-line-comments.html "PhpStorm : folding"
[DocTransition]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b8824399-f17d-4007-adde-8a7433939273.html#core-ref:0215aec3-671e-40b5-98e9-2ea651eff224 "Documentation : transitions"
[DocCycle]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b8824399-f17d-4007-adde-8a7433939273.html#core-ref:d5ddda0c-09d2-42b0-9543-0723e242ec09 "Documentation : cycle"
[DocWID]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cfc7f53b-7982-431e-a04b-7b54eddf4a75.html#core-ref:6f013eb8-33c7-11e2-be43-373b9514dea3 "Documentation : wid"
[DocCycleDeVie]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:b8824399-f17d-4007-adde-8a7433939273.html#core-ref:d5ddda0c-09d2-42b0-9543-0723e242ec09 "Documentation : cycle de vie"