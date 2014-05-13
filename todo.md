# À faire

## Dans les sources

-   renommer les classes des familles de `COGIP_AUDIT_FAMILLE` en `CogipAudit\Famille`
    +   Renommer la classe dans les `__CLASS`
    +   Renommer la classe dans les `__STRUCT`
    +   Renommer les fichiers
    +   mettre à jour les `info.xml`
-   utiliser `___()` à la place de `_()`
-   utiliser `importDocuments` avec l'option `--csv-enclosure='"'`
-   créer les groupes pour les rôles
-   renommer les `*_INIT_DATA` en `*__INIT_DATA`
-   extraire la branche de sources en un repo autonome, et refaire les différentes étapes
-   Changer le minuteur référencé dans `40-Cycle/30-param.md` en minuteur d'état
-   pour tous les profils, s'assurer que les administrateurs on les droits.

## Dans la doc

-   une fois les familles renommées, mettre à jour tous les extraits de `info.xml` impactés
-   utiliser `importDocuments` avec l'option `--csv-enclosure='"'` dans tous les extraits de `info.xml`
-   Changer les captures d'écran du minuteur référencé dans `40-Cycle/30-param.md` une fois qu'il a été changé en minuteur d'état
-   remplacer tous les usages du **developer toolkit** graphique par du CLI

## Dynacase

-   problème du thead sur les tableaux avec vue de rangée de tableau sans header (cf https://github.com/Anakeen/dynacase-quick-start/blob/documentation/Contents/images/30-60-rowviewzone.png)

## Diffusion

-   préparer une VM VirtualBox
-   préparer une VM VMWare
-   référencer les 2 vms sur vagrantCloud (on les héberge chez nous)
-   Manuels
    +   initialisation de la VM vagrant depuis vagrantCloud
    +   Pour ceux qui n'ont pas vagrant
        *   préparation manuelle de la VM VirtualBox
        *   préparation manuelle de la VM VMWare
