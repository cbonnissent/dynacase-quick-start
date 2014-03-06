# Familles et documents

La notion de famille et celle associée de documents sont fondamentales dans Dynacase.  

Les familles et les documents sont le système utilisé par Dynacase pour produire des formulaire intuitifs et une solution de persistances évolutives.  

Dans ce chapitre, vous allez apprendre à créer vos familles et mettre en forme les documents produits, gérer la sécurité, traduire les formulaire, etc.

## Théorie

La construction d'une famille passe par plusieurs étapes :

* Structure : la structure est la définition de l'arborescence des familles via le mécanisme d'héritage et du contenu de la famille via l'ajout d'attributs au sein de celle-ci,
* Paramétrage : le paramétrage de la famille consiste en l'ajout d'éléments permettant de définir des éléments de représentation (titre, icône), son contenu (valeur par défaut, etc.) et le code métier associé,
* Sécurité : la sécurité permet de définir qui peut faire les différentes étapes du CRUD (Create : Créer, Read : Voir, Update : Mettre à jour, Delete : Supprimer), ainsi que quelle représentation est présentée pour quel utilisateur,
* Vue : la définition des différentes vues présentée pour les documents de la famille. 

## Voir aussi

* [Introduction aux notions][ManualIntro]

[ManualIntro]: https://docs.anakeen.com/dynacase/3.2/dynacase-doc-core-reference/website/book/core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55.html#core-ref:e01bf76d-481b-41fd-ac64-167a68d34c55 "Manuel Dynacase : Présentation des notions"

