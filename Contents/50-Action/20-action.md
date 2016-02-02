# Action {#quickstart:d461c0c7-8c7c-4bbc-9d42-9a54cef4fa0e}

Vous allez écrire une série d'action réalisant une nouvelle interface de consultation des documents.

## Objectifs {#quickstart:f25d1dac-345b-4eff-a278-994f8e57ca7d}

-   Créer une action retournant une liste de document en JSON,
-   Créer une interface représentant une liste de documents.

## Cadre {#quickstart:a37beb82-63ba-4295-95c7-4833b7974e5b}

Vos utilisateurs sont conquis par les formulaires que vous avez réalisés dans les chapitres précédents.
Toutefois, ils trouvent que l'interface d'accès par défaut pourrait être plus design 
et vous demandent de faire une nouvelle proposition.

La COGIP étant une entreprise moderne votre parc de machine est à jour
et tous les utilisateurs ont des navigateurs à jour (IE, chrome et firefox dernière version). 
Vous allez donc construire une nouvelle interface qui ne supporte que les navigateurs les plus récents,
mais qui est plus design.

Vous allez mettre en place deux actions :

-   une générale qui représente l'interface dans son ensemble et son fonctionnement,
-   une qui représente une liste de documents.

Pour vous simplifier la tâche, vous avez décidé d'utiliser deux librairies externes :

-   [jQuery][jQuery] pour manipuler le DOM et faire des requêtes Ajax,
-   [Foundation][zurbFoundation] pour la mise en forme et quelques widgets d'interface.

## Théorie {#quickstart:95a30037-1946-457e-b883-9f0e2d7df865}

Les actions impliquent trois concepts :

-   Application : une application contient :
    - des actions,
    - des paramètres applicatifs, ceux-ci sont de trois genres :
        -   basique : le paramètre a une valeur et est accédé en faisant référence à son application et son nom,
        -   global : le paramètre a une valeur et est accédé en faisant uniquement appel à son nom,
        -   utilisateur : le paramètre a une valeur par utilisateur.
-   Action : elle est composée de :
    - un fichier PHP contenant une fonction qui est exécutée à l'appel de l'action,
    - un layout (optionnel) qui facilite le rendu de l'action,
-   [ACL][DocumentationACL] : un ACL est un droit qui peut-être associé à une action.
    Dans ce cas seul les utilisateurs possédant cet ACL (directement ou via les rôles ou les groupes qu'ils possèdent)
    peuvent effectuer cette action.

Une fois l'action déclarée, elle peut être appelée de la manière suivante :

`<context>?app=<app_name>&action=<action_name>&param1=value1&....`

## Ajout des librairies externes {#quickstart:faab6a06-0d73-495e-ae50-4c1bf34382dd}

Vous allez ajouter les librairies dans le paquet.
Vous pouvez trouver les fichiers ayant servi à la réalisation du tutoriel dans les [sources][tuto_libs].

Vous devez obtenir une arborescence similaire à :

    COGIP_AUDIT/libs
    ├── css
    │   ├── foundation.css
    │   └── normalize.css
    └── js
        ├── foundation.min.js
        └── jquery.js

## Ajout d'une ACL {#quickstart:e6f0b31a-b086-448d-a4c3-0bac70896475}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT.app` et modifiez le tableau `$app_acl` pour qu'il contienne les entrées suivantes :

    [php]
    $app_acl = array(
        array(
            "name" => "BASIC",
            "description" => N_("coa:basic access"),
            "group_default" => "Y"
        )
    );

L'ACL est composée :

-   d'un nom logique,
-   d'une description traduite,
-   d'une instruction pour que cette ACL soit par défaut donnée aux utilisateurs de la plateforme.

## Action : liste de document {#quickstart:58681a59-74f9-4a6f-abc3-a8dd8c3bc590}

Vous allez commencer par l'action liste de document. Cette action affiche une liste d'audits et un entête.

Elle est conçue pour retourner un fragment de HTML qui doit être inclut dans une page entière.

Ce fragment va (une fois intégré dans la page complète) aura le rendu suivant :

![ Liste documents : rendu final ](50-20-liste-document-final.png "Liste documents : rendu final")

### Enregistrement de l'action {#quickstart:76d495c9-a264-4c73-9c67-18b559552868}

Ouvrez le fichier `./COGIP_AUDIT/COGIP_AUDIT.app` et modifiez le tableau `$action_desc`
pour qu'il contienne les entrées suivantes :

    [php]
    $action_desc = array(
        array(
            "name" => "DOCUMENT_LIST",
            "short_name" => N_("coa:document list"),
            "script" => "action.document_list.php",
            "function" => "document_list",
            "layout" => "document_list.html",
            "acl" => "BASIC"
        )
    );

La nouvelle action comporte les éléments suivants :

`"name" => "DOCUMENT_LIST"`
:   Le nom logique de l'application. Il est utilisé dans les URL d'appel de l'action.

`"short_name" => N_("coa:document list")`
:   la description de l'application.
    Elle est utilisée dans les interfaces pour faire référence à l'action.
    Elle est traduite.

`"script" => "action.document_list.php"`
:   Le fichier PHP qui va contenir le code de l'action.

`"function" => "document_list"`
-   La fonctionphp qui est appelée lors du lancement de l'action.
    Cette fonction doit être contenue dans le fichier script.

`"layout" => "document_list.html"`
:   Le template de l'action.

`"acl" => "BASIC"`
:   Le nom d'une ACL que les utilisateurs voulant exécuter l'action doivent avoir.

<span class="flag inline nota-bene"></span>
Toutes les entrées du tableau `$action_desc` sont décrites dans la [documentation][DocumentationEnregistrementAction].

Vous pouvez trouver le fichier complété dans [les sources][tuto_application].

#### Ajout des fichiers {#quickstart:6af4c944-b263-484b-9615-0e044baac3e4}

Vous allez maintenant ajouter les fichiers que vous avez spécifié dans le chapitre précédent.

##### Code {#quickstart:434e733f-a883-4893-a1b4-4c495bec8f15}

Ajoutez le fichier `./COGIP_AUDIT/action.document_list.php`, ce fichier doit contenir le code suivant :

    [php]
    
    <?php
    
    function document_list(Action &$action) {
    
        $usage = new \ActionUsage($action);
    
        $type = $usage->addOptionalParameter("type", "type", array("ALL", "OPEN", "CLOSE"), "ALL");
        $offset = intval($usage->addOptionalParameter("offset", "offset", array(), 0));
        $slice = intval($usage->addOptionalParameter("slice", "slice", array(), 5));
        $keyWord = $usage->addOptionalParameter("keyword", "keyword", array(), false);
    
        try {
            $usage->verify(true);
    
            $inProgressStates = array(\Cogip\COGIP_AUDIT_AUDIT__WFL::e_brouillon,
                \Cogip\COGIP_AUDIT_AUDIT__WFL::e_redaction
            );
    
            $inProgressStates = array_map(function ($value) {
                return "'$value'";
            }, $inProgressStates);
    
            $inProgressStates = implode(",", $inProgressStates);
    
            $audits = array();
            $searchDoc = new \SearchDoc("", \Dcp\Family\Cogip_audit_audit::familyName);
            $searchDoc->setObjectReturn();
            if ($keyWord) {
                $searchDoc->addFilter("title ~* '%s'", $keyWord);
            }
            if ($type === "OPEN") {
                $searchDoc->addFilter("state in ($inProgressStates)");
            } elseif ($type === "CLOSE") {
                $searchDoc->addFilter("state not in ($inProgressStates)");
            }
            $searchDoc->setStart($offset*$slice);
            $searchDoc->setSlice($slice+1);
            $nbResult = $searchDoc->count();
            foreach ($searchDoc->getDocumentList() as $currentAudit) {
                /* @var \Dcp\Family\Cogip_audit_audit $currentAudit */
                $audits[] = array(
                    "TITLE" => $currentAudit->getTitle(),
                    "INITID" => $currentAudit->getPropertyValue("initid"),
                    "URL" => sprintf(
                        "?app=FDL&action=OPENDOC&id=%d&mode=view&latest=Y",
                        $currentAudit->getPropertyValue("initid")
                    ),
                    "STATE" => $currentAudit->getStatelabel(),
                    "COLOR" => $currentAudit->getStateColor()
                );
            }
            $isLast = ($nbResult < $slice + 1);
            if (!$isLast) {
                array_pop($audits);
            }
    
            $action->lay->eSet("FIRST", ($slice === 0));
            $action->lay->eSet("LAST", $isLast);
            $action->lay->eSet("OFFSET", $offset);
            $action->lay->eSet("KEYWORD", $keyWord);
            $action->lay->eSet("TYPE_ALL", $type === "ALL");
            $action->lay->eSet("TYPE_OPEN", $type === "OPEN");
            $action->lay->eSet("TYPE_CLOSE", $type === "CLOSE");
            $action->lay->eSetBlockData("AUDITS", $audits);
        } catch(Exception $exception) {
            header($exception->getMessage(), true, 500);
        }
    
    }

Le code ci-dessus a les spécificités suivantes :

-   [ActionUsage][DocumentationActionUsage] : le code utilise une instance d'`[ActionUsage][DocumentationActionUsage].
    Cette classe permet d'analyser les paramètres passés à l'action (que ça soit en CLI ou WEB)
    et de vérifier que tous les paramètres nécessaires sont bien présents.  
    Dans votre cas, les paramètres sont :
    -   `type` : permet de définir si vous souhaitez avoir les audits dans un état
        -   _terminal_ (_annulé_, _certifié_, etc.)
        -   ou _en cours d'audit_ (_brouillon_, _rédaction_),
    -   `offset` : la liste est dotée d'un tourne page, l'offset indique le numéro de la page souhaitée,
    -   `slice` : le slice est la taille d'une page,
    -   `keyword` : la liste peut-être filtrée par un mot clef sur les titres des documents.
-   l'action effectue ensuite une recherche sur les audits
    et prépare un tableau qui contient une entrée par audit trouvé et pour chacune de ces entrées prépare :
    -   le titre de l'audit,
    -   son identifiant de lignée (initid),
    -   l'url d'accès au document, celle-ci utilise l'action `[openDoc][DocumentationOpenDoc]`,
    -   l'étape en cours du document,
    -   la couleur de l'étape en cours du document,
-   finalement, l'action met en place des variables pour le moteur de template, qui vont servir dans le template
    décrit ci-dessous. Les variables sont affectées avec les fonctions [eSet][DocumentationeSet]
    et [eSetBlockData][DocumentationeSetBlockData] pour éviter l'injection HTML.

<span class="flag inline nota-bene"></span>
Vous avez pu remarquer que la recherche demande un document de plus que nécessaire,
cela permet de savoir si le bouton suivant du tourne-page doit être activé ou pas.

<span class="flag inline nota-bene"></span>
L'affectation du layout au moteur de template et le rendu du template sont automatiques.
Si toutefois, vous n'aviez pas de template à associé à l'action, vous devez le préciser avec le code suivant
en fin d'action (ici pour du retour en JSON) :

    [php]
    $action->lay->template = json_encode($return);
    $action->lay->noparse = true;
    header('Content-type: application/json');

Vous pouvez trouver le fichier complété dans [les sources][tuto_document_list].

##### Template {#quickstart:29e51122-8f66-4478-9f5d-4abd3f5f6e0a}

Ajoutez le fichier `./COGIP_AUDIT/Layout/document_list.html` :

    [html]
    <form class="js-list-form">
        <div class="row collapse">
            <div class="small-12 columns">
                <input name="keyword" type="text" placeholder="[TEXT:coa:titre]" value="[KEYWORD]">
            </div>
            <div class="small-2 columns">
    
            </div>
        </div>
        <div class="row collapse">
            <div class="large-12 columns">
                <label class="css-form-label">[TEXT:coa:State]&nbsp;:
                    <select class="css-form-select" name="type">
                        <option value="ALL" [IF TYPE_ALL]selected[ENDIF TYPE_ALL]>[TEXT:coa:All]</option>
                        <option value="OPEN" [IF TYPE_OPEN]selected[ENDIF TYPE_OPEN]>[TEXT:coa:In progress]</option>
                        <option value="CLOSE" [IF TYPE_CLOSE]selected[ENDIF TYPE_CLOSE]>[TEXT:coa:Closed]</option>
                    </select>
                </label>
            </div>
        </div>
        <input name="offset" type="hidden" value="[OFFSET]"/>
        <input type="submit" value="[TEXT:coa:search]" class="button postfix js-button-list-form">
    </form>
    <div class="pagination-centered">
        <ul class="pagination">
            <li class="arrow [IFNOT FIRST]unavailable[ENDIF FIRST] js-previous"><a href="#">&laquo;</a></li>
            <li class="current"><a href="">[OFFSET]</a></li>
            <li class="arrow [IFNOT LAST]unavailable[ENDIF LAST] js-next"><a href="#">&raquo;</a></li>
        </ul>
     </div>
    <ul class="off-canvas-list js-docs-list">
    [BLOCK AUDITS]
    <li title="[STATE]">
        <a class="js-doc-link" href="[URL]" data-initid="[INITID]">[TITLE]
            <span class="right" style="background-color : [COLOR];">&nbsp;</span>
        </a>
    </li>
    [ENDBLOCK AUDITS]
    </ul>

Le template fonctionne avec l'action ci-dessus et utilise les mots clefs du moteur de template interne de Dynacase.
Vous pouvez trouver la liste des mots clefs sur la [documentation][DocumentationTemplate].

Le template ci-dessus a les spécificités suivantes :

-   il contient un formulaire de recherche complété avec les paramètres courant de la recherche,
-   il contient un tourne-page complété avec les paramètres du tourne-page courant
    (numéro de la page courante, possibilité d'aller en avant, en arrière),
-   la liste des documents trouvés avec leur état et une couleur par état,
-   le code JavaScript permettant l'animation du formulaire n'est pas fourni avec
    mais sera mis en place sur la page principale.

Vous pouvez trouver le fichier complété dans [les sources][tuto_document_list_layout].

## Action : principale {#quickstart:ff2d40f6-f0af-40c1-b3cb-b5844e7fed92}

Vous allez maintenant mettre en place l'action principale de votre interface.

Cette action principale présente le layout global de l'application.
Elle ne contiendra pas de code PHP et fonctionnera principalement via du code JavaScript.

### Enregistrement de l'action {#quickstart:8f811c9e-a39d-46c4-a821-8974f581b771}

Ajoutez cette entrée au tableau `$action_desc` :

    [php]
    array(
        "name" => "MAIN",
        "short_name" => N_("coa:main interface"),
        "script" => "action.main.php",
        "function" => "main",
        "layout" => "main.html",
        "root" => "Y",
        "acl" => "BASIC"
    ),

La définition est similaire à l'action `DOCUMENT_LIST` à une différence près :
cette action est [`root`][DocumentationEnregistrementAction].
C'est donc l'action par défaut de l'application et elle peut-être appelée directement avec l'url `<context>/?app=COGIP_AUDIT`

Vous pouvez trouver le fichier complété dans [les sources][tuto_application].

#### Ajout des fichiers {#quickstart:2d0b4cca-a029-4e95-91e5-96704aaef9b9}

Vous allez maintenant ajouter les fichiers que vous avez spécifié dans le chapitre précédent et les assets (js, css).

##### Code {#quickstart:aa3f3171-8650-422e-84b3-5e237504f794}

Ajoutez le fichier `./COGIP_AUDIT/action.main.php`, ce fichier doit contenir le code suivant :

    [php]
    <?php

    function main(Action &$action) {
    
    }

Il n'y a pas de code dans la fonction, car le template associé est statique.

##### Template {#quickstart:ceb9a546-81cf-4fb3-b559-29665ea282ef}

Ajoutez le fichier `./COGIP_AUDIT/Layout/main.html` :

    [html]
    <!doctype html>
    <!--[if IE 9]><html class="lt-ie10" lang="fr"><![endif]-->
    <html lang="fr">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>[TEXT:coa:audits]</title>
        <link rel="icon" href="[DYNACASE_FAVICO]"/>
        <link rel="shortcut icon" href="[DYNACASE_FAVICO]"/>
        <link rel="stylesheet" href="COGIP_AUDIT/libs/css/normalize.css"/>
        <link rel="stylesheet" href="COGIP_AUDIT/libs/css/foundation.css"/>
        <link rel="stylesheet" href="COGIP_AUDIT/libs/css/main.css"/>
    </head>
    <body>
    <div class="fixed css-header">
        <nav class="top-bar" data-topbar data-options="sticky_on: large">
            <ul class="title-area">
                <li class="name">
                    <h1><a href="#" class="js-audits">[TEXT:coa:audits]</a></h1>
                </li>
            </ul>
            <section class="top-bar-section">
                <ul class="right">
                    <li class="has-form show-for-large-up">
                        <a href="#" class="button js-disconnect">
                            [TEXT:coa:disconnect]
                        </a>
                    </li>
                </ul>
             </section>
        </nav>
    </div>
    <div class="css-main js-main">
        <div class="off-canvas-wrap docs-wrap" data-offcanvas="">
            <div class="inner-wrap">
                <nav class="tab-bar css-main-tab-bar">
                    <section class="left-small">
                        <a class="left-off-canvas-toggle menu-icon js-document-menu"><span></span></a>
                    </section>
    
                    <section class="middle tab-bar-section">
                        <h1 class="title js-current-frame-title">[TEXT:coa:Select an audit]</h1>
                    </section>
                </nav>
    
                <aside class="left-off-canvas-menu">
                    <a href="?app=FDL&action=OPENDOC&famid=COGIP_AUDIT_AUDIT"
                       class="button small css-create-button js-create-button">
                        [TEXT:coa:Create audit]
                    </a>
                    <span class="js-document-list"></span>
                </aside>
    
                <section class="main-section css-doc-section">
                    <iframe id="main-doc" name="main-doc" src="" class="css-main-doc"></iframe>
                </section>
    
                <a class="exit-off-canvas"></a>
    
            </div>
        </div>
    </div>
    <form style="display:none;" action="?app=AUTHENT&action=LOGOUT" method="POST" name="disconnect"
          id="disconnect">
        <input type="hidden" name="SeenBefore" value="1">
        <input type="hidden" name="logout" value="Y">
    </form>
    <script type="text/javascript" src="COGIP_AUDIT/libs/js/jquery.js"></script>
    <script type="text/javascript" src="COGIP_AUDIT/libs/js/foundation.min.js"></script>
    <script type="text/javascript" src="COGIP_AUDIT/libs/js/main.js"></script>
    </body>
    </html>


Le template ci-dessus contient les spécificités suivantes :

-   les seules clefs du template sont des clefs en `[TEXT:coa:...]` qui permettent les traductions,
-   le template utilise un widget [foundation][zurbFoundation] [offcanvas][ZurbOffcanvas]
    qui permet d'avoir un menu contextuel,
-   les documents sont représentés dans l'iframe `main-doc`,
-   le formulaire `disconnect` permet de déconnecter l'utilisateur courant du contexte.

Vous pouvez trouver le fichier complété dans [les sources][tuto_layout_main].

##### Assets {#quickstart:fcd8773a-55b2-4978-a632-fcdb94a421db}

Il y a deux fichiers d'asset (un fichier CSS et un fichier JS).

###### CSS {#quickstart:263efe54-0f5a-48f4-a9c5-0cce3fd9cfc9}

Ajoutez le fichier `./COGIP_AUDIT/libs/css/main.css` :

    [css]
    .css-main-doc {
        width: 100%;
        border: none;
    }
    
    .css-doc-section {
        height: 100%;
    }
    
    .css-create-button {
        width : 100%;
    }
    
    .css-header {
        border-bottom: 1px solid #000000;
    }
    
    .css-form-label {
        color : white;
    }
    
    .css-form-select {
        color: #000000;
    }

La CSS ci-dessus reste très simple et apporte principalement de la mise en forme pour l'iframe centrale
et pour le formulaire des listes de documents.

Vous pouvez trouver le fichier complété dans [les sources][tuto_css_main].

###### JavaScript {#quickstart:0a80214f-4b5e-4097-bf7c-0a75b23f30ac}

Ajoutez le fichier `./COGIP_AUDIT/libs/js/main.js` :

    [javascript]
    !function () {
        $(window).ready(function () {
            var $mainDoc = $("#main-doc"),
                $mainSection = $(".css-doc-section"),
                $mainTabBar = $(".css-main-tab-bar"),
                setCurrentDocument, getDocumentList;
            /**********************************************************************************************************/
            /** Utilities                                                                                            **/
            /**********************************************************************************************************/
            /**
             * Set the current document in the main iframe
             * @param hash
             */
            setCurrentDocument = function (hash) {
                var doc = $mainDoc[0].contentDocument || $mainDoc[0].contentWindow.document,
                    currentInitid = $(doc).find("[name=document-initid]").attr("content");
                if (hash && currentInitid !== hash) {
                    $mainDoc.attr(
                        "src",
                        "?app=FDL&action=OPENDOC&mode=view&latest=Y&id=" + encodeURIComponent(hash)
                    );
                }
            };
            /**
             * Get the document list with a post XHR
             */
            getDocumentList = function () {
                var data = {}, $form = $(".js-list-form");
                if ($form.length > 0) {
                    data = $form.serialize();
                }
                $.post("?app=COGIP_AUDIT&action=DOCUMENT_LIST", data)
                    .done(function (data) {
                        var $data = $(data);
                        $data.find(".js-list-form").on("submit", function (event) {
                            event.preventDefault();
                            getDocumentList();
                        });
                        $(".js-document-list").html($data);
                    })
                    .fail(function (event) {
                        console.log("Unable to get document list");
                        console.log(event);
                    });
            };
            /**********************************************************************************************************/
            /** Events                                                                                               **/
            /**********************************************************************************************************/
            /**
             * Add the create document event
             */
            $(".js-create-button").on("click", function (event) {
                event.preventDefault();
                if (event.currentTarget.href) {
                    $("#main-doc").attr("src", event.currentTarget.href);
                }
            });
            /**
             * Listen the load event of the main iframe, update the docTitle
             */
            $mainDoc.on("load", function () {
                var doc = $mainDoc[0].contentDocument || $mainDoc[0].contentWindow.document,
                    title = doc.title || "",
                    initid = $(doc).find("[name=document-initid]").attr("content");
                $(".js-current-frame-title").text(title);
            });
            /**
             * Add a listener for the upper left audit button
             */
            $(".js-audits").on("click", function (event) {
                event.preventDefault();
                $(".js-document-menu").trigger("click");
            });
            /**
             * Add a listener for the disconnect button
             * Send the hidden disconnect form when there is a click on the button
             */
            $(".js-disconnect").on("click", function (event) {
                event.preventDefault();
                $("#disconnect").submit();
            });
            /**
             * Resize main element to take all the space
             */
            $(function () {
                var timer;
                $(window).resize(function () {
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        var offset = $(".js-main").offset(), size = $(window).height() - offset.top;
                        $('.inner-wrap').css("min-height", size + "px");
                        size = size - $mainTabBar.outerHeight();
                        $mainSection.height(size);
                        $mainDoc.height($mainSection.innerHeight() - 5);
                    }, 40);
                }).resize();
            });
            /**
             * Handle events on the audit list
             */
            $(".js-document-list").on("click", ".js-doc-link",function (event) {
                event.preventDefault();
                if (event.currentTarget.href) {
                    $("#main-doc").attr("src", event.currentTarget.href);
                }
            }).on("click", ".js-button-list-form",function (event) {
                event.preventDefault();
                getDocumentList();
            }).on("click", ".js-previous",function (event) {
                var $previous = $(event.currentTarget), $offset;
                event.preventDefault();
                if (!$previous.hasClass("unavailable")) {
                    $offset = $("[name=offset]");
                    $offset.val($offset.val() - 1);
                    getDocumentList();
                }
            }).on("click", ".js-next", function (event) {
                var $previous = $(event.currentTarget), $offset;
                event.preventDefault();
                if (!$previous.hasClass("unavailable")) {
                    $offset = $("[name=offset]");
                    $offset.val($offset.val() -   1);
                    getDocumentList();
                }
            });
            /**********************************************************************************************************/
            /** Initialisation                                                                                       **/
            /**********************************************************************************************************/
            /**
             * Use the hash to open a selected document
             */
            if (window.location.hash) {
                var hash = window.location.hash.slice(1);
                setCurrentDocument(hash);
            } else {
                $(".js-document-menu").trigger("click");
            }
    
            //Get the initial document list
            getDocumentList();
            //Init the foundation framework
            $(document).foundation();
    
        });
    }();

Le code JavaScript est lui aussi assez simple, il est structuré en plusieurs parties :

-   utilitaires :
    -   `setCurrentDocument` : cette fonction sélectionne l'iframe principale et la met à jour avec l'url d'un document,
    -   `getDocumentList` : cette fonction envoie une requête POST
        vers l'action que vous avez mise en place dans le chapitre précédent.
        Celle-ci vous retourne une liste de document en HTML que vous injectez dans la page principale,
-   événements : dans cette partie du code différents écouteurs sont mis en place sur l'interface
    pour lui permettre de réagir aux actions des utilisateurs.
    La fonction utilisée est le [`on`][jQueryOn],
-   initialisation : le code termine par une phase d'initialisation
    qui lance la première récupération de la liste et les widgets [foundation][zurbFoundation].

Une fois l'ensemble des fichiers initiés et le contexte mis à jour.
Rendez vous à l'adresse `<context>/?app=COGIP_AUDIT`, vous obtenez l'interface suivante :

![ Interface : rendu final ](50-20-interface-finale.gif "Interface : rendu final")

Vous pouvez trouver le fichier complété dans [les sources][tuto_js_main].

## Enregistrement de l'interface {#quickstart:d5124a6a-20f5-42ce-87b4-a5df9dff75a1}

Vous allez finir ce chapitre en enregistrant votre nouvelle action principale en tant qu'action par défaut,
ce qui permet aux utilisateurs d'arriver directement sur l'action.

Pour ce faire, ouvrez le fichier `info.xml` et ajoutez la ligne :

`<process command="./wsh.php --api=setApplicationParameter --appname=CORE --param=CORE_START_APP --value=COGIP_AUDIT"/>`

à la fin du process d'installation et de mise à jour.

<span class="flag inline nota-bene"></span>
Le paramètre [`CORE_START_APP`][DocumentationCoreStartApp] permet de spécifier l'application qui doit être lancée par défaut.

<span class="flag inline nota-bene"></span>
Le script [`setApplicationParameter`][DocumentationScriptSetApp] permet de définir la valeur d'un paramètre applicatif
lors l'installation d'un paquet.

Vous pouvez trouver le fichier complété dans [les sources][tuto_info_xml].

## Mise en place des modifications {#ddui-ref:9094da43-9be5-4918-bea7-af84e77a0564}

Vous allez maintenant déployer vos modifications :

    <devtool> deploy -s . --url http://admin:anakeen@<nomDeDomaine>/dynacase-control/ --port <port> --context dynacase

Vous pouvez ensuite consulter les modifications apportées via l'application `http://<nomDeDomaine>/dynacase/`.

## Conclusion {#quickstart:023d9e27-4170-46a5-b7f9-27e8a9e2a4f1}

Vous avez expérimenté le système d'application/action.
Vous pouvez simplement et rapidement étendre les fonctionnalités de la plateforme grâce à ce système
et notamment créer des interfaces dédiées aux besoins de vos utilisateurs.

Merci d'avoir complété ce tutoriel jusqu'à cette dernière étape. Nous vous souhaitons bonne chance et bon courage dans
le développement de vos applications.

Vous pouvez trouver les sources entièrement complétés sur [github][tuto_zip].

<!-- links -->

[jQuery]: http://jquery.com/ "JQuery"
[zurbFoundation]: http://foundation.zurb.com/ "Zurb foundation"
[DocumentationACL]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:a98b72ea-c063-4907-abc4-e5171ab55e59.html#core-ref:a98b72ea-c063-4907-abc4-e5171ab55e59 "Documentation : ACL applicative"
[DocumentationEnregistrementAction]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:e67d8aeb-939c-46e3-9be8-6fc3ba75ebc2.html#core-ref:90bf0711-7874-4c9d-bdf0-7d28becb7628 "Documentation : enregistrement d'une action"
[DocumentationActionUsage]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:7a8932eb-a59f-482a-9991-4ee1c634eae4.html#core-ref:7a8932eb-a59f-482a-9991-4ee1c634eae4 "Documentation : Action Usage"
[DocumentationOpenDoc]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:f9e68fa7-01b7-4903-9718-744271d63112.html#core-ref:f9e68fa7-01b7-4903-9718-744271d63112 "Documentation : openDoc"
[DocumentationeSet]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:2696710a-f491-4887-b953-e08d918ef4fb.html#core-ref:2696710a-f491-4887-b953-e08d918ef4fb "Documentation : eSet"
[DocumentationeSetBlockData]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:088e711c-ea91-45e7-841d-289ffc53c80b.html "Documentation : eSetBlockData"
[DocumentationTemplate]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:32dea245-37e6-4a4c-a65e-06c577c0effa.html#core-ref:32dea245-37e6-4a4c-a65e-06c577c0effa "Documentation : mots-clef template"
[jQueryOn]: https://api.jquery.com/on/ "jQuery : fonction on"
[DocumentationCoreStartApp]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:82f525dd-33a0-4b25-9efb-7fb50f251802.html#core-ref:82f525dd-33a0-4b25-9efb-7fb50f251802 "Documentation : CORE_START_APP"
[DocumentationScriptSetApp]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:75bd5f66-ad6b-470b-b217-7e926d7f960e.html#core-ref:75bd5f66-ad6b-470b-b217-7e926d7f960e "Documentation : setApplicationParameter"
[ZurbOffcanvas]: http://foundation.zurb.com/docs/components/offcanvas.html "Foundation : offcanvas"
[tuto_zip]: https://github.com/Anakeen/dynacase-quick-start-code/archive/3.2-after-50-20.zip
[tuto_libs]: https://github.com/Anakeen/dynacase-quick-start-code/tree/3.2-after-50-20/COGIP_AUDIT/libs
[tuto_application]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/COGIP_AUDIT.app
[tuto_document_list]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/action.document_list.php
[tuto_document_list_layout]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/Layout/document_list.html
[tuto_layout_main]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/Layout/main.html
[tuto_js_main]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/libs/js/main.js
[tuto_css_main]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/COGIP_AUDIT/libs/css/main.css
[tuto_info_xml]: https://github.com/Anakeen/dynacase-quick-start-code/blob/3.2-after-50-20/info.xml#L76-L77
[deploy_instruct]: #quickstart:e53aa0c3-6fa8-4083-8bb8-b64bd750ab9e
