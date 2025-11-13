# SpaceX Tracker

Une application mobile développée avec Flutter permettant de suivre les lancements de SpaceX. Ce projet a été réalisé dans le cadre du module d'introduction au développement mobile en FIL A2 à l'IMT Atlantique.

## Fonctionnalités

-   **Affichage des derniers lancements** : Récupère et affiche la liste de tous les lancements SpaceX via l'API officielle.
-   **Double mode d'affichage** :
    -   Une vue **liste** compacte.
    -   Une vue **grille** plus visuelle.
    -   Un bouton permet de basculer facilement entre les deux modes.
-   **Détails complets** : Affiche un écran détaillé pour chaque lancement, incluant :
    -   Nom, date et description de la mission.
    -   Statut de la mission (succès ou échec).
    -   Le patch (image) de la mission.
    -   Des informations sur la fusée utilisée.
    -   Une galerie photo et les liens vers les articles/vidéos.
-   **Gestion des favoris** : Possibilité d'ajouter ou de retirer un lancement de sa liste de favoris.
-   **Recherche et Tri** :
    -   Un champ de recherche pour filtrer les lancements par nom.
    -   Plusieurs options de tri : par date (ascendant/descendant), par nom (A-Z/Z-A) et pour n'afficher que les favoris.
-   **Onboarding utilisateur** : Un écran d'accueil simple est présenté au premier lancement pour guider l'utilisateur à travers les fonctionnalités principales.

## Architecture

Le projet adopte l'architecture suivante :

-   `lib/`
    -   `data/`: Gère toute la logique de données.
        -   `api/`: Contient le service responsable de la communication avec l'API SpaceX.
        -   `models/`: Définit les objets Dart qui structurent les données reçues de l'API.
    -   `ui/`: Contient toute l'interface utilisateur.
        -   `pages/`: Écrans principaux de l'application.
        -   `widgets/`: Composants réutilisables utilisés à travers l'application.
    -   `utils/`: Classes utilitaires diverses.

## Stack Technique

-   **Framework** : Flutter
-   **Langage** : Dart
-   **API** : SpaceX-API v4
-   **Principaux packages** :
    -   `http` : Pour effectuer les appels réseau vers l'API.
    -   `shared_preferences` : Pour mémoriser si l'onboarding a déjà été affiché.
    -   `flutter_speed_dial` : Pour le menu flottant des options de tri.
    -   `intl` : Pour le formatage des dates.

## Installation et Lancement

### Prérequis

-   Avoir le SDK Flutter installé sur votre machine.
-   Un émulateur (Android/iOS) ou un appareil physique.

### Étapes

1.  **Clonez le dépôt :**
    git clone https://github.com/Zaphhhhh/SpaceXTracker

2.  **Accédez au dossier du projet :**
    cd SpaceXTracker


3.  **Installez les dépendances :**
    flutter pub get


4.  **Lancez l'application :**
    flutter run


## Auteur

-   **Noé CHARLES** - *https://github.com/Zaphhhhh* - Etudiant en FIL A2 à l'IMT Atlantique & Apprenti ingénieur logiciel chez ArianeGroup