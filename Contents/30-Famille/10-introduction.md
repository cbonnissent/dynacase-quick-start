# Familles et documents {#quickstart:f43b95f5-71d4-4c40-bd28-3fff24a3261f}

Les notions de famille et, celle associée, de document sont fondamentales dans Dynacase.

Les familles et les documents sont le système utilisé par Dynacase pour produire des formulaire intuitifs et une solution de persistance évolutives.

Dans ce chapitre, vous allez apprendre à créer vos familles, mettre en forme les documents produits, gérer la sécurité, traduire les formulaire, etc.

## Théorie {#quickstart:ab8489d7-a9cf-4b3d-9470-fcb975e322fe}

La construction d'une famille est réalisée par la mise en place :

de la *structure*
:   elle est définie par ses attributs propres et éventuellement par les attributs de la famille dont elle hérite,

du *paramétrage*
:   le paramétrage de la famille consiste à ajouter des éléments de représentation (titre, icône, etc.),
    son contenu (valeur par défaut, etc.) et le code métier associé,

de la *sécurité*
:   la sécurité permet de définir qui peut faire les différentes étapes du CRUD (Create : Créer, Read : Voir, Update : Mettre à jour, Delete : Supprimer),
    ainsi que quelle représentation est utilisée pour quel utilisateur,

des *vues*
:   les différentes représentations du document sont définies.

Une famille peut produire des documents. Un document est une instance d'une famille (de la même manière qu'un objet est une instance d'une classe). 
Dans Dynacase, le document est matérialisé par :

-   la base de données : un document est stocké dans une ligne de la table de sa famille,
-   du code PHP : un document est un objet instance de la classe de sa famille,
-   des IHM : il a, a minima, deux représentations :
    -   en édition : c'est un formulaire web permettant la saisie de données -assistée et contrôlée-,
    -   en consultation : c'est une page web présentant les informations qu'il contient.

### Voir aussi {#quickstart:f63c146c-a9ba-4b31-be7f-b1ef4d010436}

* [Présentation détaillée des concepts de famille, document et attribut][ManualIntro]

[ManualIntro]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55.html#core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55 "Manuel de référence Core : famille, document et attribut"

