# Cycle de vie {#quickstart:64fac308-94ce-4717-96c7-56e2336c7791}

Vous allez maintenant configurer les cycles de vie de votre application.

Le cycle de de vie est un élément de Dynacase qui permet d'encadrer la vie d'un document via un ensemble d'étapes
et de transitions. À chaque étape, le développeur peut spécifier :

-   la mise en forme du document (visibilités, formulaire de modification, consultation spécifiques, etc...),
-   qui peut voir, modifier, supprimer le document,
-   envoyer un mail,
-   définir une action à exécuter passé un certain délai (par exemple, envoyer un mail si jamais le document
    est toujours dans la même étape 15 jours après l'entrée dans cette étape, etc.),
-   qui peut utiliser quelle transition pour changer d'étape,
-   du code exécuté lors du changement d'étape.

Les cycles de vie de votre application vous permettent donc de structurer votre application
et de définir des parcours guidant les utilisateurs lors de la complétion de leurs documents métiers.
