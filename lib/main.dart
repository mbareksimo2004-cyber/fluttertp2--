import 'package:flutter/material.dart';

import 'data/livres_data.dart';
import 'models/livre.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';
import 'services/livre_service.dart';

/// Point d'entrée de l'application MaBiblio.
void main() {
  runApp(const MaBiblioApp());
}

/// Application : thème Material 3 et page d'accueil.
class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

/// Page d'accueil : barre d'application, navigation entre les trois écrans
/// de la bibliothèque et accès aux paramètres.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Index de l'onglet affiché.
  int _index = 0;

  /// Chargement du catalogue JSON (asynchrone).
  late final Future<List<Livre>> _chargement;

  /// Les trois écrans de l'application : seul l'onglet actif est construit.
  static const List<Widget> _ecrans = <Widget>[
    CatalogueScreen(),
    GalerieScreen(),
    MaListeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Le fichier JSON est lu en arrière-plan : l'interface affiche tout de
    // suite le jeu de données par défaut (aucun blocage), puis le magasin
    // `biblio` est alimenté par les données du fichier dès qu'il est lu.
    _chargement = LivreService.chargerLivresDepuisAssets()
        .then((List<Livre> livres) {
      biblio.remplacerLivres(livres);
      return livres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _chargement,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Livre>> snapshot,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MaBiblio'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Paramètres',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ParametresScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: _ecrans[_index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (int index) => setState(() => _index = index),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Catalogue',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Galerie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add_check),
                label: 'Ma liste',
              ),
            ],
          ),
        );
      },
    );
  }
}
