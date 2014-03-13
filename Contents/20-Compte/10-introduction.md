# La gestion des utilisateurs {#quickstart:7c5b312e-42cf-44e2-b68f-9ddce9b48d71}

Dans Dynacase la gestion des utilisateurs passe par la notion de compte (account dans la
documentation de référence). Ceux ci se répartissent en trois catégories :

* les utilisateurs : ce type de compte identifie une personne et permet à celle-ci de se connecter sur la plateforme,
* les groupes : un groupe est un ensemble d'utilisateurs. 
    * Il peut contenir d'autres groupes
	* Il peut être contenu dans d'autres groupes, 
    * La liste des utilisateurs d'un groupe est de deux natures : 
        * les utilisateurs directement contenu dans le groupe, 
        * les utilisateurs contenu dans le groupe et les sous groupes du groupe,
* les rôles : un rôle a pour but de faire le lien entre les utilisateurs, les groupes et les droits :
    * les droits sont posés sur les rôles
	* les rôles sont ensuite affectés aux groupes ou aux utilisateurs.

<span class="flag inline nota-bene"></span> Il est à noter que dans le cas de projet intégrés au sein d'un système d'information, Dynacase peut utiliser un LDAP/AD comme base de référence pour les utilisateurs et un SSO comme système d'identification des utilisateurs. Ce point n'est pas abordé dans ce tutoriel.

Dans ce chapitre, vous allez apprendre à créer, initialiser et associer les différents comptes utilisateurs.
