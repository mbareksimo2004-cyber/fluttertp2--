import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';

/// Écran « Galerie » : les livres présentés sous forme de grille.
///
/// La grille est construite par un [GridView.builder] (motif « builder »)
/// dont le délégué [SliverGridDelegateWithFixedCrossAxisCount] est calculé
/// dynamiquement : le nombre de colonnes s'adapte à la largeur de l'écran
/// (1 colonne en portrait étroit, 2 en standard, 4 sur tablette).
class GalerieScreen extends StatelessWidget {
  const GalerieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: biblio,
        builder: (BuildContext context, Widget? child) {
          final List<Livre> livres = biblio.livres;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int colonnes = _nombreColonnes(constraints.maxWidth);
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colonnes,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemCount: livres.length,
                itemBuilder: (BuildContext context, int index) {
                  final Livre livre = livres[index];
                  return _GrilleLivre(livre: livre);
                },
              );
            },
          );
        },
      ),
    );
  }

  /// Nombre de colonnes en fonction de la largeur disponible.
  static int _nombreColonnes(double largeur) {
    if (largeur >= 900) return 4;
    if (largeur >= 600) return 3;
    if (largeur >= 380) return 2;
    return 1;
  }
}

/// Case de la grille : une [Card] colorée avec la couverture du livre.
class _GrilleLivre extends StatelessWidget {
  const _GrilleLivre({required this.livre});

  final Livre livre;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: livre.couleur.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              livre.titre,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              livre.auteur,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            if (livre.nouveaute) ...<Widget>[
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Nouveau',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
