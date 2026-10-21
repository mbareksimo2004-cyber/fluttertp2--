import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';

/// Écran « Catalogue » : la liste complète de la bibliothèque.
///
/// La liste défile grâce à un [ListView.separated] construit à la volée
/// (motif « builder ») : seules les lignes visibles sont créées, ce qui
/// reste fluide même avec une bibliothèque de plusieurs centaines de livres.
/// Chaque ligne est présentée par une [LivreCard] (voir `lib/widgets`).
class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: biblio,
        builder: (BuildContext context, Widget? child) {
          final List<Livre> livres = biblio.livres;
          return ListView.separated(
            itemCount: livres.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 1),
            itemBuilder: (BuildContext context, int index) {
              final Livre livre = livres[index];
              return LivreCard(
                livre: livre,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Livre sélectionné : ${livre.titre}')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
