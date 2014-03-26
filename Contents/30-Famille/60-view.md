# Vue

Ce chapitre va vous permettre de modifier la mise en forme des documents en modification et en consultation.

## Objectifs

* Modifier la mise en forme des attributs via les options,
* Utiliser une zone pour modifier la présentation du document,
* Utiliser la mise en forme de tableau,
* Utiliser la mise en forme d'attribut en édition et en consultation,
* Mettre en place un style pour modifier la présentation globale de Dynacase.

## Cadre

Lors de la phase de spécification et des premiers retours les demandes suivantes ont été émises.Certains détails pourraient être améliorés sur les formulaires :

* Formulaires : les attributs en S (statique non modifiable en édition) apparaissent en gris ce qui les rend difficilement lisible 
![ Audit : Date Statique ](30-60-date-S.png "Audit : Date Statique")
* Audits : le mot pièces-jointes apparaît 4 fois
![ Audit : Pièces jointes ](30-60-files.png "Audit : Pièces jointes"),
* Audits la date de début, la durée et la date de fin doivent être présentées sur la même ligne,
* Fiche de non-conformité : les auditeurs aimeraient que le tableau des actions soit présenté en colonnes et pas en lignes,
* Après avoir vu les possibilités offertes par les contrôles de vue, les administrateurs fonctionnels veulent un menu leur permettant d'éditer tous les attributs d'une fiche, dans ce mode un message doit être affiché pour indiquer le mode d'édition spécial.

## Théorie

La modification des options de génération des formulaires peuvent se faire par plusieurs techniques différentes :

* le [style][DocStyle], il permet de définir des préférences d'affichage (ensemble de couleurs, css et js à intégrer dans certains types de page, re-définition de [layout][DocLayout], etc...),
* les [options des attributs][DocAttrOptions], une partie des options des attributs influent sur la mise en forme de ceux-ci,
* l'[injection de JS et CSS][QuickStartHook] par le biais des hooks,
* la création d'une [zone documentaire et de son contrôleur][DocZoneDocumentaire] associé pour redéfinir entièrement la vue d'un document,
* l'utilisation d'une [vue de rangée de tableau][DocVueRangeeTableau] pour mettre en forme la ligne d'un tableau,
* la re-définition d'une [vue d'attribut][DocVueAttribut] en édition et en consultation qui permet de modifier la présentation d'un ou plusieurs attributs.

L'ensemble de ces techniques permet de re-définir la mise en forme d'un document.

## Les options

Vous allez commencer par la technique la plus simple à mettre en oeuvre : la modification des options de mise en forme des attributs.

Vous allez utiliser l'option [`vlabel`][DocAttrOptions], cette option permet d'indiquer l'option de mise en forme que vous souhaitez mettre en place 

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et modifiez les lignes :

* `caa_f_pj` : ajoutez dans la colonne `P` `vlabel=none`,
* `caa_a_pj` : ajoutez dans la colonne `P` `vlabel=none`.

![ Audit : Structure ](30-60-options-struct.png "Audit : Structure")

Ces instructions indique à Dynacase qu'il ne faut pas mettre de label dans la génération du document pour ces attributs.

Une fois le fichier de structure ré-importé ou le module re-déployé le formulaire devient semblable à :

![ Audit : Pièces jointes ](30-60-files-with-option.png "Audit : Pièces jointes")

Vous pouvez remarquer que les deux pièces jointes surnuméraires ne sont plus présents.

## Le style

Vous allez maintenant créer votre style. Un style est composé d'un fichier de définition et de fichier d'assets (css, js, [layout][DocLayout]).

### Création des fichiers

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

Ce code indique le nom logique du style et son style parent. Le style parent spécifié est le style par défaut de Dynacase.

### Ajout des règles spécifiques

Vous allez ajouter des règles spécifiques à votre nouveau style.

Ajoutez un répertoire `Layout` sous le répertoire `STYLE/COGIP_AUDIT` ensuite ajoutez un fichier `style_s_attributes.css` avec le contenu suivant :

    [css]
    input[visibility="S"], input[visibility="S"]:hover, textarea[visibility="S"], div.static {
        color: black;
        background: white;
        border: none;
        border-style: none;
        padding: 0;
        margin-bottom: 2px;
        text-overflow: ellipsis;
    }
    
    select[visibility="S"] {
        border: none;
        color: black;
        background: white;
        -webkit-appearance: none;
        -moz-appearance: none;
    }
    
    .document input[visibility="S"], .document input[visibility="S"]:hover {
        background-color: white;
        background-image: none;
        padding: 3px;
    }

Ces règles CSS vont rendre les attributs en `S` avec un fond blanc et une fonte noire sur les navigateurs suffisamment récents.

Vous allez maintenant enregistrer votre fichier CSS pour que celui-ci soit ajouté aux fichiers CSS produit par Dynacase.

Vous devez avoir la structure de fichiers suivante :

    │STYLE
    ├── COGIP_AUDIT
    │   ├── COGIP_AUDIT.sty
    │   └── Layout
    │       └── style_s_attributes.css

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

<span class="flag inline nota-bene"></span> Vous pouvez trouver la liste des règles applicables dans la [documentation][DocStyleRules].

### Règle d'import

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

Après re-déploiement, cela donne pour la date évoquée ci-dessus :

![ Audit : Date Statique ](30-60-date-S-style.png "Audit : Date Statique")

## Vue d'attribut

Vous allez maintenant utiliser la [vue d'attribut][DocVueAttribut]. Celle-ci va vous permettre de mettre en forme les différentes dates de l'audit pour qu'elles soient présentées sur la même ligne et pas de manière horizontale.

### Vue d'attribut : édition

#### Création

Vous allez commencer par la [vue d'édition][DocVueAttrEdit].

Ajoutez le fichier `audit_dates_edit.xml` dans le répertoire `./COGIP_AUDIT/Layout`. Ce fichier va contenir la définition de la représentation des attributs en édition.

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

De plus, vous devez créer une vue d'attribut vide pour cacher les attributs. Ajoutez le fichier `audit_void.xml` dans le répertoire `./COGIP_AUDIT/Layout`.
Ce fichier reste vide car il va servir à cacher les attributs de durée et de fin qui sinon serait représenté deux fois.

#### Enregistrement

Ouvrez le fichier `./wsh.php --api=importDocuments --file=./COGIP_AUDIT/COGIP_AUDIT_AUDIT__STRUCT.csv` et ajoutez les options suivantes :

* `caa_date_debut` : colonne `P` (options) : `edittemplate=COGIP_AUDIT:AUDIT_DATES_EDIT.xml:S`,
* `caa_duree` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`,
* `caa_date_fin` : colonne `P` : `edittemplate=COGIP_AUDIT:AUDIT_VOID.xml:S`.

Une fois le paquet déployé, vous obtenez en édition sur les documents d'audit le rendu suivant :

![ Audit : Attributs alignés ](30-60-attr-aligned.png "Audit : Attributs alignés")

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