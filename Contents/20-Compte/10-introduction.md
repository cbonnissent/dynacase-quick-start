# La gestion des utilisateurs

Dans Dynacase la gestion des utilisateurs passe par la notion de compte. Ceux ci se répartissent en trois catégories :

* les utilisateurs : ce type de compte identifie une personne et permet à celle-ci de se connecter sur la plateforme,
* les groupes : un groupe est un ensemble d'utilisateurs. 
    * Il peut contenir d'autres groupes ou être contenu dans des groupes, 
    * La liste des utilisateurs d'un groupe est de deux natures : 
        * les utilisateurs directement contenu dans le groupe, 
        * les utilisateurs contenu dans le groupe et les sous groupe du groupe,
* les rôles : un rôle a pour but de faire le lien entre les utilisateurs, les groupes et les droits. En effet, les droits sont affectés à un rôle et les rôles sont ensuite affectés aux groupes ou aux utilisateurs.

NB : Il est à noter que dans le cas de projet intégrés au sein d'un système d'information, Dynacase peut utiliser un LDAP/AD comme base de référence pour les utilisateurs et un SSO comme système d'identification des utilisateurs. Mais ce point dépasse le tutoriel.

Dans ce chapitre, vous allez apprendre à créer, initialiser et associer les différents comptes utilisateurs.
