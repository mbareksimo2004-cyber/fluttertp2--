# MaBiblio — Structure du projet

TP Flutter 2 : construction d'une application de bibliothèque personnelle
avec les widgets `ListTile`, `ListView`, `CheckboxListTile`, `Card`,
`GridView` et le chargement de données JSON.

## Arborescence

```
mabiblio/
├── assets/
│   └── livres.json          # Source de vérité des données (12 livres)
├── lib/
│   ├── main.dart            # Point d'entrée, MaterialApp, HomePage (FutureBuilder)
│   ├── data/
│   │   └── livres_data.dart # BiblioStore (ChangeNotifier) + jeu de données par défaut
│   ├── models/
│   │   └── livre.dart       # Modèle immuable Livre (+ copyWith)
│   ├── screens/
│   │   ├── catalogue_screen.dart # ListView.separated
│   │   ├── galerie_screen.dart   # GridView.builder
│   │   ├── ma_liste_screen.dart   # CheckboxListTile (tristate)
│   │   └── parametres_screen.dart # ListTile
│   ├── services/
│   │   └── livre_service.dart     # Lecture + conversion de assets/livres.json
│   └── widgets/
│       └── livre_card.dart        # Card + ListTile (badge « Nouveau », favori)
├── test/
│   ├── widget_test.dart     # Tests widget
│   └── livre_service_test.dart # Tests unitaires du service JSON
├── android/ ios/ linux/ macos/ web/ windows/   # Plateformes
├── analysis_options.yaml
├── pubspec.yaml
└── README_PROJECT_STRUCTURE.md
```

## Architecture

| Couche | Fichiers | Rôle |
|---|---|---|
| Modèle | `lib/models/livre.dart` | Objet `Livre` immuable |
| Données | `lib/data/livres_data.dart` | `BiblioStore` (`ChangeNotifier`) : source de vérité de l'état de l'UI |
| Service | `lib/services/livre_service.dart` | Lit `assets/livres.json` et le convertit en `List<Livre>` |
| UI | `lib/screens/`, `lib/widgets/` | Écrans et widgets, branchés sur `biblio` via `ListenableBuilder` |

### Flux de données

1. `main.dart` lance `LivreService.chargerLivresDepuisAssets()` (un `Future`).
2. Le `FutureBuilder` affiche immédiatement le jeu de données par défaut
   (aucun blocage de l'interface), puis remplace la liste dès que le JSON est lu.
3. Toute modification (lu / favori) passe par `BiblioStore`, qui notifie les
   écrans via `ListenableBuilder`.

## Lancement

```bash
flutter pub get      # installer les dépendances
flutter analyze      # analyse statique (0 erreur, 0 avertissement)
flutter test         # 11 tests
flutter run          # lancer l'application
```

## Plateforme Android

- Gradle **8.12** (version supportée par Flutter 3.35.x)
- Android Gradle Plugin **8.9.1**, Kotlin **2.1.0**
- `applicationId` / `namespace` : `com.mabiblio.app`
