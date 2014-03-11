# Familles et documents {#quickstart:f43b95f5-71d4-4c40-bd28-3fff24a3261f}

La notion de famille et celle associée de documents sont fondamentales dans Dynacase.  

Les familles et les documents sont le système utilisé par Dynacase pour produire des formulaire intuitifs et une solution de persistances évolutives.  

Dans ce chapitre, vous allez apprendre à créer vos familles et mettre en forme les documents produits, gérer la sécurité, traduire les formulaire, etc.

## Théorie {#quickstart:ab8489d7-a9cf-4b3d-9470-fcb975e322fe}

La construction d'une famille passe par plusieurs étapes :

* Structure : la structure est la définition de l'arborescence des familles via le mécanisme d'héritage et du contenu de la famille via l'ajout d'attributs au sein de celle-ci,
* Paramétrage : le paramétrage de la famille consiste en l'ajout d'éléments permettant de définir des éléments de représentation (titre, icône), son contenu (valeur par défaut, etc.) et le code métier associé,
* Sécurité : la sécurité permet de définir qui peut faire les différentes étapes du CRUD (Create : Créer, Read : Voir, Update : Mettre à jour, Delete : Supprimer), ainsi que quelle représentation est présentée pour quel utilisateur,
* Vue : la définition des différentes vues présentée pour les documents de la famille.

Une fois une famille construite, elle peut produire des documents. Un document est une instance d'une famille (de la même manière qu'un objet est une instance d'une classe). Dans Dynacase, vous pouvez le retrouver sous les formes suivantes :

* Base de données : un document est stocké dans une ligne de la table de sa famille,
* PHP : un document est un objet instance de la classe de sa famille,
* IHM : il a plusieurs représentation :
    - en édition : c'est un formulaire web permettant la saisie de donnée,
    - en consultation : c'est une page web présentant les informations qu'il contient.

### Voir aussi {#quickstart:f63c146c-a9ba-4b31-be7f-b1ef4d010436}

* [Introduction aux notions][ManualIntro]

[ManualIntro]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55.html#core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55 "Manuel Dynacase : Présentation des notions"

