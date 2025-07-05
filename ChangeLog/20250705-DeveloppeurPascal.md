# 20250705 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

* mise à jour des dependances
* mise à jour des docs fr/en
* ajout des paramètrages pour DocInsight
* mise à jour du projet en Delphi 12.3 Athens
* mise à niveau des librairies et du SDK Android API 35
* changement du libellé de l'application en DEBUG pour la distinguer de la version de production sur macOS, iOS et Android
* mise à jour des droits et permissions nécessaires à l'applications en RELEASE
* mise à jour des commentaires de copyright et horodatage suite au changement de version de C2PP
* simplification du référencement des scènes disponibles
* simplification du chargement et de l'accès aux données du jeu par correction de la création et de l'accès à son instance (TDigikooGameData.Current au lien de transtyper TDigikooGameData.DefaultGameData)
* mise à jour du format du texte affiché dans les crédits du jeu pour reprendre la structure de Bidioo et des autres jeux avec aussi l'affichage de la licence et des infos de version et copyright.
* repositionnement de la zone d'affichage (viewport) des ascenseurs horizontaux pour toujours repartir en haut d'écran lors de l'affichage d'une scène (exemple pour les crédits du jeu).
* centrage des chiffres restant à poser plutôt que les laisser cadrés à gauche dans l'écran de jeu
* ajout d'une ligne de séparation entre chiffres à poser et grille dans l'écran de jeu
* ajout d'une ombre sur l'icone affichée sur les boutons n'ayant qu'une image pour leur donner un peu de relief
* correction de l'initialisation du bouton "music on/off" de l'écran de jeu qui utilisait les infos des effets sonores au lieu de la musique de fond
* modification de l'action sur le bouton d'activation/arrêt de la musique de fond sur l'écran de jeu pour utiliser l'état actuel de la musique plutôt que le paramètre de configuration (ils sont censés être identiques mais ça ne le serait pas si le fichier son est absent)
* désactivation de l'ombre sur les icones de sboutons images pour iOS et Android en attendant la correction d'un bogue de réaffichage soumis à Embarcadero (cf https://github.com/DeveloppeurPascal/Digikoo-v2-Delphi/issues/69)
* déploiement de la version 2.2 - 20250705
* génération de la documentation développeur du projet avec DocInsight
