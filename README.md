# MaBiblio

Application Flutter de bibliothèque personnelle réalisée dans le cadre du
**TP Flutter 2**.

MaBiblio permet de parcourir un catalogue de livres, de les parcourir en
galerie, de marquer ceux que l'on a lus et de gérer ses favoris.

## Fonctionnalités

| Écran | Widgets mis en œuvre |
|---|---|
| **Catalogue** | `ListView.separated`, `ListTile`, `Card` |
| **Galerie** | `GridView.builder`, `SliverGridDelegateWithFixedCrossAxisCount` |
| **Ma liste** | `CheckboxListTile` avec état `tristate` |
| **Paramètres** | `ListTile` (profil, notifications, langue, à propos) |
| **Données** | `FutureBuilder` + lecture de `assets/livres.json` via `rootBundle` |

## Structure du projet

Voir [`README_PROJECT_STRUCTURE.md`](README_PROJECT_STRUCTURE.md) pour le
détail de l'arborescence et de l'architecture (modèle, service, magasin d'état
`BiblioStore`, écrans).

## Installation et exécution

```bash
flutter pub get
flutter run
```

## Qualité du code

```bash
flutter analyze   # 0 erreur, 0 avertissement
flutter test      # 11 tests (widget + unitaires)
```

## Plateforme Android

- Gradle **8.12**, Android Gradle Plugin **8.9.1**, Kotlin **2.1.0**
- `applicationId` / `namespace` : `com.mabiblio.app`
- `minSdk` / `targetSdk` / `compileSdk` pilotés par Flutter (`flutter.minSdkVersion`, …)

## Historique du TP

Le dépôt suit le découpage du TP en huit parties (une partie = un commit) :
`ListTile` → `ListView` → `CheckboxListTile` → `Card` → `GridView` → `JSON`
→ intégration finale. Le script d'automatisation est disponible dans
[`deploy_tp.sh`](deploy_tp.sh).
