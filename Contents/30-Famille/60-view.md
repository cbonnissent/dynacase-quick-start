# Vue {#quickstart:987d7ccf-ffb9-48f0-bb7b-4a8363ad7dbf}

Ce chapitre va vous permettre de modifier la mise en forme des documents en modification et en consultation.

## Objectifs {#quickstart:6ecad751-7d81-405f-b240-f459ca1737c1}

-   Modifier la mise en forme des attributs via les options,
-   Utiliser une zone pour modifier la présentation du document,
-   Utiliser la mise en forme de tableau,
-   Utiliser la mise en forme d'attribut en édition et en consultation,
-   Mettre en place un style pour modifier la présentation globale de Dynacase.

## Cadre {#quickstart:288a6149-da38-4fe3-8365-9c7f0276c7c0}

Lors de la phase de spécification et des premiers retours les demandes suivantes ont été émises.
Certains détails pourraient être améliorés sur les formulaires :

-   Formulaires : les attributs en S (statique non modifiable en édition) apparaissent en gris,
    ce qui les rend difficilement lisibles :
    ![ Audit : Date Statique ](30-60-date-S.png "Audit : Date Statique")
-   Audits : le mot pièces-jointes apparaît 4 fois :
    ![ Audit : Pièces jointes ](30-60-files.png "Audit : Pièces jointes"),
-   Audits : la date de début, la durée et la date de fin doivent être présentées sur la même ligne,
-   Fiche de non-conformité : les auditeurs aimeraient que le tableau des actions
    soit présenté en colonnes et pas en lignes,
-   Après avoir vu les possibilités offertes par les contrôles de vue, les administrateurs fonctionnels veulent
    un menu leur permettant d'éditer tous les attributs d'une fiche.
    Dans ce mode un message doit être affiché pour indiquer le mode d'édition spécial.

## Théorie {#quickstart:f4f9e332-6ad1-4d5d-b986-fd592cea3c8e}

La modification des options de génération des formulaires utilise plusieurs techniques différentes :

-   le [style][DocStyle], il permet de définir des préférences d'affichage
    (ensemble de couleurs, css et js à intégrer dans certains types de page, définition de [layout][DocLayout], etc...),
-   les [options des attributs][DocAttrOptions], une partie des options des attributs influe sur la mise en forme de ceux-ci,
-   l'[injection de JS et CSS][QuickStartHook] par le biais des hooks,
-   la création d'une [zone documentaire et de son contrôleur][DocZoneDocumentaire] associé
    pour redéfinir entièrement la vue d'un document,
-   l'utilisation d'une [vue de rangée de tableau][DocVueRangeeTableau] pour mettre en forme la ligne d'un tableau,
-   la définition d'une [vue d'attribut][DocVueAttribut] en édition et en consultation,
    elle permet de modifier la présentation d'un ou plusieurs attributs.

## Les options {#quickstart:5298b658-fe14-4adb-bda9-3b449064b7e2}

Vous allez commencer par la technique la plus simple à mettre en œuvre :
la modification des options de mise en forme des attributs.

Vous allez utiliser l'option [`vlabel`][DocAttrOptions],
cette option permet d'indiquer où vous souhaitez afficher le libellé des attributs. 

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez les lignes :

-   `caa_f_pj` : ajoutez dans la colonne `P` (options) `vlabel=none`,
-   `caa_a_pj` : ajoutez dans la colonne `P` (options) `vlabel=none`.

![ Audit : Structure ](30-60-options-struct.png "Audit : Structure")

Ces options indiquent à Dynacase qu'il ne faut pas mettre de label dans la génération du document pour ces attributs.

Une fois le fichier de structure importé ou le module déployé le formulaire devient semblable à :

![ Audit : Pièces jointes ](30-60-files-with-option.png "Audit : Pièces jointes")

Vous pouvez remarquer que les deux libellés _pièces jointes_ surnuméraires ne sont plus présents.

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_audit].

## Le style {#quickstart:87bae86c-a40c-4018-baea-cd72ebf85288}

Vous allez créer votre style.
Un style est composé d'un fichier de définition et de fichier d'assets (css, js, [layout][DocLayout]),
et permet de définir des règles de mise en forme valables sur un contexte.

### Création des fichiers {#quickstart:bc2cd429-dac5-4f68-a277-6a68b163a8d3}

Ajoutez un répertoire `COGIP_AUDIT` dans le répertoire `STYLE`. 
Ensuite, ajoutez un fichier `COGIP_AUDIT.sty` dans le répertoire `COGIP_AUDIT`.

Le fichier [`.sty`][DocStyleSTY] est un fichier php, ce fichier doit contenir le code suivant :

    [php]
    <?php
    //global $sty_desc, $sty_const;
    $sty_desc = array(
        "name" => "COGIP_AUDIT", //Name
        "description" => "COGIP_AUDIT", //long description
    );
    
    $sty_inherit = "STYLE/MODERN/MODERN.sty";

Ce code indique le nom logique du style et son style parent. Dans votre cas, c'est le style par défaut de Dynacase.

### Ajout des règles spécifiques {#quickstart:b2b9c27e-3648-420c-8776-e0625842b90b}

Vous allez ajouter des règles spécifiques à votre nouveau style.

Ajoutez un répertoire `Layout` sous le répertoire `STYLE/COGIP_AUDIT` et ajoutez-y un fichier `style_s_attributes.css`.

<span class="flag inline nota-bene"></span>
Le nom du fichier est libre. ;
toutefois, puisque vous pouvez être amenés à créer plusieurs fichiers, il ets important de donner des noms explicites.

Vous devez avoir la structure de fichiers suivante :

    │STYLE
    ├── COGIP_AUDIT
    │   ├── COGIP_AUDIT.sty
    │   └── Layout
    │       └── style_s_attributes.css

Le fichier CSS doit contenir :

    [css]
    .document input[visibility="S"],
    .document input[visibility="S"]:hover,
    .document textarea[visibility="S"],
    input[visibility="S"],
    input[visibility="S"]:hover,
    textarea[visibility="S"],
    div.static {
        color: black;
        background: white;
        border: none;
        border-style: none;
        padding: 0;
        margin-bottom: 0;
        text-overflow: ellipsis;
    }
    
    select[visibility="S"] {
        border: none;
        color: black;
        background: white;
        -webkit-appearance: none;
        -moz-appearance: none;
    }
    
    input[disabled="disabled"],
    input[disabled] {
        cursor: auto;
    }
    
    .document input[visibility="S"], .document input[visibility="S"]:hover {
        background-color: white;
        background-image: none;
        padding: 3px;
    }

Ces règles CSS vont rendre les attributs en `S` avec un fond blanc et une police noire sur les vues d'édition et
sur les navigateurs suffisamment récents (supérieurs à IE7).

Vous allez maintenant enregistrer votre fichier CSS pour que celui-ci soit ajouté aux fichiers CSS produit par Dynacase.

Ouvrez le fichier `STYLE/COGIP_AUDIT/COGIP_AUDIT.sty` et modifiez le contenu pour qu'il soit semblable à :

    [php]
    <?php
    //global $sty_desc, $sty_const;
    $sty_desc = array(
        "name" => "COGIP_AUDIT", //Name
        "description" => "COGIP_AUDIT", //long description
    );
    
    $sty_inherit = "STYLE/MODERN/MODERN.sty";
    // global parameters which can be use for other css
    $sty_rules = array(
        'css' => array(
            'dcp/document-edit.css' => array(
                "src" => array(
                    "ultra" => "STYLE/COGIP_AUDIT/Layout/style_s_attributes.css"
                )
            )
        )
    );

<span class="flag inline nota-bene"></span>
Vous pouvez trouver la liste des règles de compositions applicables dans la [documentation][DocStyleRules].

Vous pouvez retrouver le repertoire style initialisé dans [les sources][tuto_style].

### Import du style {#quickstart:58893482-8ef1-45d6-9598-4ed0ff78a8db}

Ouvrez le fichier `info.xml` et ajoutez à la fin de la procédure d'installation et d'upgrade l'instruction suivante :

`<process command="./wsh.php --api=setStyle --style=STYLE/COGIP_AUDIT/COGIP_AUDIT.sty"/>`

Ce qui donne :

    [xml]
    <?xml version="1.0"?>
    <module name="COGIP_AUDIT" disabled="no" version="1.0.0" release="0">
    
        <description>Cogip audit application</description>
    
        <requires>
            <module comp='ge' version='3.2' name='dynacase-core'/>
        </requires>
    
        <post-install>
            <process command="programs/record_application COGIP_AUDIT" />
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/ROLE_INIT_DATA.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IGROUP_INIT_DATA.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/IUSER_INIT_DATA.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_REFERENTIEL__PARAM.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_CHAPITRE__PARAM.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__PARAM.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_FNC__PARAM.csv"/>
            <process command="programs/update_catalog" />
            <process command="./wsh.php --api=setStyle --style=STYLE/COGIP_AUDIT/COGIP_AUDIT.sty"/>
        </post-install>
        
        <post-upgrade>
            <process command="programs/pre_migration COGIP_AUDIT" />
            <process command="programs/record_application COGIP_AUDIT" />
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv"/>
            <process command="./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_BASE__PARAM.csv"/>
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
            <process command="./wsh.php --api=setStyle --style=STYLE/COGIP_AUDIT/COGIP_AUDIT.sty"/>
        </post-upgrade>
    
    </module>

Après déploiement, cela donne pour la date évoquée ci-dessus, en édition :

![ Audit : Date Statique ](30-60-date-S-style.png "Audit : Date Statique")

## Vue d'attribut {#quickstart:070ffd40-3ff0-4cb8-86b8-4b0d63bf62ec}

Vous allez utiliser la [vue d'attribut][DocVueAttribut].
Celle-ci va vous permettre de mettre en forme les différentes dates de l'audit
pour qu'elles soient présentées sur la même ligne et pas les unes en dessous des autres.

### Vue d'attribut : édition {#quickstart:47a6d278-1796-43aa-9e77-e946fde7f043}

#### Création {#quickstart:22665c04-e3c6-447a-96f9-166d09ce29aa}

Vous allez commencer par la [vue d'édition][DocVueAttrEdit].

Ajoutez le fichier `audit_dates_edit.xml` dans le répertoire `./COGIP_AUDIT/Layout`.
Ce fichier va contenir la définition de la représentation des attributs en édition.

Veuillez le compléter comme ci-dessous :

    [html]
    <style>
        [attrid=caa_duree] {
            display : none;
        }
        [attrid=caa_date_fin] {
            display : none;
        }
        .date-label {
            box-sizing: border-box;
            display: inline-block;
            width: 30%;
            float: left;
            text-align: right;
            padding: 2px 5px 1px 1px;
        }
        .date-value {
            box-sizing: border-box;
            display: inline-block;
            width: 70%;
            float: right;
            padding: 1px;
        }
        .date-duree {
            padding-left: 10px;
        }
    </style>
    
    <div class="date-label">
        <span>[L_CAA_DATE_DEBUT]&nbsp;:</span>
    </div>
    
    <div class="date-value">
        <span>[V_CAA_DATE_DEBUT]</span>
        <span class="date-duree">[L_CAA_DUREE] &nbsp;: [V_CAA_DUREE]</span>
    </div>

De plus, vous devez créer une vue d'attribut vide pour cacher les attributs.
Ajoutez le fichier `audit_void.xml` dans le répertoire `./COGIP_AUDIT/Layout`.
Ce fichier reste vide car il va servir à cacher les attributs de durée et de fin
qui sinon seraient représentés deux fois.

Vous pouvez retrouver les fichier complété dans [les sources][tuto_audit_edit].

#### Enregistrement {#quickstart:bb5c90dd-8f71-4532-9031-027065b796dd}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et ajoutez les options suivantes :

-   `caa_date_debut` : colonne `P` (options) : `edittemplate=COGIP_AUDIT:AUDIT_DATES_EDIT.xml:S`,
-   `caa_duree` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`,
-   `caa_date_fin` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`.


Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_audit].

Une fois le paquet déployé, vous obtenez en édition sur les documents d'audit le rendu suivant :

![ Audit : Attributs alignés ](30-60-attr-aligned.png "Audit : Attributs alignés")

### Vue d'attribut : consultation {#quickstart:7dc65009-e511-408d-9c7a-fcb14b11f0a8}

#### Création {#quickstart:d472fab6-1baa-47c0-8b05-68c59e774912}

Vous allez maintenant customiser la [vue de consultation][DocVueAttrView].

Ajoutez le fichier `audit_dates_view.xml` dans le répertoire `./COGIP_AUDIT/Layout/`.

Veuillez le compléter comme ci-dessous :

    [html]
    <style>
        #Tcaa_f_desc tr:nth-child(0n+4), #Tcaa_f_desc tr:nth-child(0n+5) {
            display : none;
        }
        .date-label {
            box-sizing: border-box;
            display: inline-block;
            width: 30%;
            float: left;
            text-align: right;
            padding: 2px 5px 1px 1px;
        }
        .date-value {
            box-sizing: border-box;
            display: inline-block;
            float: left;
            padding: 2px;
        }
        .date-fin {
            padding-left: 10px;
        }
        .date-separator {
            float: left;
            padding: 2px;
        }
        .date-separator:before {
            content: ":";
        }
    </style>
    
    <div class="date-label">
        <span>[L_CAA_DATE_DEBUT]</span>
    </div>
    
    <div class="date-separator">
    </div>
    
    <div class="date-value">
        <span>[V_CAA_DATE_DEBUT]</span>
        <span class="date-fin">[L_CAA_DATE_FIN] &nbsp;: [V_CAA_DATE_FIN]</span>
    </div>

Vous pouvez retrouver les fichier complété dans [les sources][tuto_audit_view].

#### Enregistrement {#quickstart:4d3b485d-8341-43ed-ac71-b5479b28401f}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et ajoutez les options suivantes :

-   `caa_date_debut` : colonne `P` (options) : `edittemplate=COGIP_AUDIT:AUDIT_DATES_EDIT.xml:S|viewtemplate=COGIP_AUDIT:AUDIT_DATES_VIEW.xml:S`,
-   `caa_duree` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S|viewtemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`,
-   `caa_date_fin` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S|viewtemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`.

Une fois le paquet déployé, vous obtenez en consultation sur les documents d'audit le rendu suivant :

![ Audit : Attributs alignés ](30-60-attr-aligned-view.png "Audit : Attributs alignés")

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_audit].

## Vue de rangée de tableau {#quickstart:6393dae9-7911-46c7-a687-466ea623d18b}

Vous allez maintenant créer une [vue de rangée de tableau][DocVueRangeeTableau].
Cette vue va vous permettre d'organiser différemment la présentation des lignes d'un tableau.
Elle est souvent mise en place sur des tableaux ayant de nombreuses colonnes pour les présenter de manière plus compacte.

Ajoutez un fichier `fnc_table.xml` dans le répertoire `./COGIP_AUDIT/Layout`.

Ce fichier doit contenir :

    [xml]
    <?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
    <!DOCTYPE table [
            <!ELEMENT table (table-head*,table-body*)>
    
            <!ELEMENT table-head (cell)*>
            <!ELEMENT table-body (cell)*>
    
            <!ELEMENT cell ANY>
            <!ATTLIST cell
                    class CDATA #IMPLIED
                    style CDATA #IMPLIED>
            ]>
    
    <table>
        <table-body>
            <cell>
                <div class="cogip-fnc-cell" data-attrid="caf_action_desc">
                    <div class="cogip-label">[L_CAF_ACTION_DESC] :</div>
                    <div class="cogip-value">[V_CAF_ACTION_DESC]</div>
                </div>
                <div class="cogip-fnc-cell" data-attrid="caf_action_resp">
                    <div class="cogip-label">[L_CAF_ACTION_RESP] :</div>
                    <div class="cogip-value">[V_CAF_ACTION_RESP]</div>
                </div>
                <div class="cogip-fnc-cell" data-attrid="caf_action_date">
                    <div class="cogip-label">[L_CAF_ACTION_DATE] :</div>
                    <div class="cogip-value">[V_CAF_ACTION_DATE]</div>
                </div>
            </cell>
        </table-body>
    </table>

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_fnc_table].

Le fichier ci-dessus décrit un template de table où :

-   il n'y a plus de ligne de header (absence de la balise `table-head`),
-   chaque ligne de la table contient trois `div` qui chacune contiennent le libellé et la valeur d'un attribut.
    Les classes et le `data-attrid` ne sont pas utilisées mais sont ajoutées à titre de bonne pratique
    pour favoriser la mise en place d'une éventuelle css.

Ensuite ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_FNC__STRUCT.csv`
et modifiez la colonne `P` (options) de la ligne `caf_a_action` pour remplacer la colonne options (vide) par
`vlabel=up|rowviewzone=COGIP_AUDIT:FNC_TABLE.xml|roweditzone=COGIP_AUDIT:FNC_TABLE.xml`. 

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_audit].

Ces nouvelles options indiquent que le template ci-dessus est utilisé en édition et en consultation.

Après le déploiement du paquet, le tableau est présenté de la manière suivante :

![ FNC : tableau mis en forme ](30-60-rowviewzone.png "FNC : tableau mis en forme")

## Vue de document {#quickstart:13421fec-a139-4c0f-b80d-caa48e43e586}

Vous allez finir ce chapitre en mettant en place une vue de document pour l'édition.

Vous allez mettre en place une vue qui effectue plusieurs actions :

-   vérifie que l'utilisateur qui la demande a bien le profil `administrateur fonctionnel`,
-   force toutes les visibilités à `W`,
-   ajoute un bandeau indiquant que ce mode d'édition est un mode administrateur
    et que de grands pouvoirs impliquent de grandes responsabilités.

Une vue est composée de deux éléments :

-   un template : un fichier contenant la définition de la vue et son contenu,
-   un contrôleur : une méthode PHP qui est exécutée avant le rendu du template.

### Création de la vue {#quickstart:49a0cb20-6b1c-4217-ab83-2932c7a5910b}

Vous allez commencer par ajouter le fichier de template.
Ajoutez un fichier `edit_admin.xml` dans le répertoire `./COGIP_AUDIT/Layout/`.

Ce fichier doit contenir :

    [DOCUMENT]

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_edit_admin].

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_BASE__CLASS.php` et ajoutez les fonctions suivantes :

    [php]
        /** Total edition */
    
        /**
         * Controller of total admin
         *
         * @templateController
         */
        public function edit_admin()
        {
            if ($this->userIsAdmin()) {
                //Choice of the default zone (FDL:EDITBODYCARD)
                $message = _("coa:Admin edition : beware !");
                $css = <<<CSS
    .normal::before {
        display: block;
        width: 100%;
        text-align: center;
        content: "$message";
        color: red;
        font-size: 2em;
    }
    CSS;
                global $action;
                /* @var \Action $action */
                $action->parent->addCssCode($css);
                $zonebodycard = "FDL:EDITBODYCARD";
                $attributes = $this->getAttributes();
                foreach ($attributes as $currentAttribute) {
                    /* @var \NormalAttribute $currentAttribute */
                    if (is_a($currentAttribute, "NormalAttribute") && $currentAttribute->mvisibility !== "I") {
                        $currentAttribute->setVisibility("W");
                    }
                }
                $this->lay->set("DOCUMENT", $this->viewDoc($zonebodycard));
                return;
            }
            $this->lay->set("DOCUMENT", "<h1>You cannot access to this page</h1>");
        }
    
        /**
         * Compute if user have the admin role
         *
         * @return bool
         */
        protected function userIsAdmin()
        {
            global $action;
    
            if ($action->user->id === 1) {
                return true;
            }
            $roles = $action->user->getAllRoles();
            foreach ($roles as $currentRole) {
                if (strtolower($currentRole["login"]) === "role_admin_fonctionnel") {
                    return true;
                }
            }
            return false;
        }

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_class_base].

Vous pouvez remarquer les points suivants :

-   la fonction `userIsAdmin`, cette fonction récupère l'utilisateur en cours et vérifie deux conditions :
    -   soit que son id est `1` (c'est l'id système de l'administrateur),
    -   soit qu'il possède le rôle `role_admin_fonctionnel`,
-   la fonction `edit_admin`, c'est le contrôleur de la vue :
    -   elle doit posséder le même nom que le fichier xml de la vue,
    -   elle doit posséder le tag `@templateController` sinon la fonction n'est pas exécutée,
    -   si l'utilisateur est admin :
        -   une CSS est ajoutée elle met en place un message d'avertissement,
        -   elle parcourt tous les attributs et passe ceux-ci à `W`
            (excepté ceux en `I` car ils ne peuvent pas être modifié par l'utilisateur courant),
        -   elle génère le contenu de la page et l'injecte dans la variable de layout `DOCUMENT`,
-   l'utilisation de `$this->lay->set("DOCUMENT", "…")` dans le contrôleur de la vue : c'est lui qui va remplacer
    `[DOCUMENT]` dans le template par le contenu généré.

### Ajout du menu {#quickstart:ff4ad8c7-af92-4467-87dc-776f819bf961}

Vous allez maintenant ajouter le menu.

Ouvrez le fichier `COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv` et ajoutez la ligne suivante :

![ Base : définition de menu ](30-60-base-menu-def.png "Base : définition de menu")

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_struct_base].

Vous allez gérer les visibilités de ce menu.
Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_BASE__CLASS.php` et ajoutez la fonctions suivante :

    [php]
    /**
     -   Compute menu visibility
     *
     -   @return int
     */
    public function visibilityAdminMenu()
    {
        if ($this->userIsAdmin()) {
            return MENU_ACTIVE;
        } else {
            return MENU_INVISIBLE;
        }
    }

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_class_base].

Cette fonction va vous permettre de définir que le menu est visible
uniquement pour les utilisateurs ayant le profil administrateur.

Ouvrez le fichier `COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv`
et modifiez la colonne `M` (phpfunc) pour l'attribut `cab_menu_admin_edit` en la complétant avec `::visibilityAdminMenu()`.

Vous pouvez retrouver le fichier mis à jour dans [les sources][tuto_struct_base].

### Résultat {#quickstart:74785b78-5688-4118-ad87-da23df9ceaaf}

Une fois le paquet déployé et si l'utilisateur connecté est administrateur, un menu supplémentaire est affiché.

![ Menu édition admin ](30-60-menu-admin.png "Menu édition admin")

Après avoir cliqué sur ce menu, la vue suivante s'ouvre :

![ Édition admin ](30-60-edition-admin.png "Édition admin")

Vous pouvez remarquer dans cette vue :

-   le libellé d'avertissement,
-   le champ rédacteur qui normalement est en `S` (non modifiable) et passé en `W` (modifiable)
    et est donc modifiable par l'administrateur fonctionnel.

## Conclusion {#quickstart:eeb14f31-c61d-4502-a8ab-7cf9b1044a4e}

Vous allez maintenant produire le paquet.

    <devtool> generateWebinst -s .

Déployez le paquet en passant par Dynacase Control (`http://<nomDeDomaine>/dynacase-control/`) en utilisant le scénario *upgrade* 
(en cas de besoin, n'hésitez pas à consulter les instruction de [déploiement][deploy_instruct]).

Dans ce chapitre vous avez expérimenté les principales techniques de modifications d'interface.
Vous avez pu constater que le formulaire est facilement modifiable,
à la fois dans les détails de mise en forme et dans son fonctionnement.

## Voir aussi {#quickstart:5e6dd852-671f-4dc8-ac40-6197cb950c93}

-   [Les sources après ce chapitre][tuto_zip],
-   le [style][DocStyle],
-   les [layouts][DocLayout],
-   les [options des attributs][DocAttrOptions],
-   l'[injection de JS et CSS][QuickStartHook],
-   la [zone documentaire et de son contrôleur][DocZoneDocumentaire],
-   la [vue de rangée de tableau][DocVueRangeeTableau],
-   la [vue d'attribut][DocVueAttribut].

<!-- links -->

[DocAttrOptions]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:16e19c90-3233-11e2-a58f-6b135c3a2496.html#core-ref:16e19c90-3233-11e2-a58f-6b135c3a2496 "Documentation : options"
[QuickStartHook]: #quickstart:bb25d5ff-d5a6-4d26-b32a-26db45de88e7
[DocZoneDocumentaire]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:cb3e2b97-ee6d-4cdf-aa25-b2e41d0d3156.html#core-ref:49b96dc9-64e9-4f5a-a167-396282625c1e "Documentation : Zone documentaire"
[DocVueRangeeTableau]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:9e76ac49-3b17-435b-ba25-a7122369be85.html#core-ref:9e76ac49-3b17-435b-ba25-a7122369be85 "Documentation : Vue de rangée de tableau"
[DocVueAttribut]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:26dca29e-92b3-445f-a6d8-51eaa297219a.html#core-ref:26dca29e-92b3-445f-a6d8-51eaa297219a "Documentation : Vue d'attribut"
[DocStyle]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1844a1a8-1406-47bd-a884-1a18ef0a6ca7.html "Documentation : Style"
[DocLayout]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:5f4a2f4b-9ceb-42db-8ac1-2a7baa621ce2.html#core-ref:5f4a2f4b-9ceb-42db-8ac1-2a7baa621ce2 "Documentation : Layout"
[DocStyleSTY]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1844a1a8-1406-47bd-a884-1a18ef0a6ca7.html#core-ref:53fe66e1-ecb6-4f0b-b7b4-9d9a420ecbcf "Documentation : sty"
[DocStyleRules]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:1844a1a8-1406-47bd-a884-1a18ef0a6ca7.html#core-ref:76671db7-f66c-4a6f-853e-e573be03f213 "Documentation : style règles"
[DocVueAttrEdit]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:26dca29e-92b3-445f-a6d8-51eaa297219a.html#core-ref:4faa4b17-56fc-4e42-a091-f1a97b7591b8 "Documentation : vue attribut édition"
[DocVueAttrView]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:26dca29e-92b3-445f-a6d8-51eaa297219a.html#core-ref:9cb7b313-7294-424d-bd86-a63155025902 "Documentation : vue attribut consultation"
[tuto_zip]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-30-60.zip
[tuto_style]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-30-60/STYLE/COGIP_AUDIT
[tuto_audit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv
[tuto_audit_edit]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/Layout/audit_dates_edit.xml
[tuto_audit_view]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/Layout/audit_dates_view.xml
[tuto_fnc_table]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/Layout/fnc_table.xml
[tuto_edit_admin]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/Layout/edit_admin.xml
[tuto_class_base]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/COGIP_AUDIT_BASE__CLASS.php#L32-L106
[tuto_struct_base]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-30-60/COGIP_AUDIT/COGIP_AUDIT_BASE__STRUCT.csv#L5
[deploy_instruct]: #quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e
