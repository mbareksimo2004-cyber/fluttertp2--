import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';

/// Carte d'un livre, utilisée dans le catalogue.
///
/// Elle combine une [Card] (conteneur avec ombre et coins arrondis),
/// un [ListTile] (mise en page de la ligne) et un badge « Nouveau »
/// pour les sorties récentes. Le bouton cœur gère les favoris.
class LivreCard extends StatelessWidget {
  const LivreCard({super.key, required this.livre, this.onTap});

  /// Le livre affiché par la carte.
  final Livre livre;

  /// Action appelée quand on tape sur la carte.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: livre.couleur,
          child: Text(
            '${livre.id}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(livre.titre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${livre.auteur} • ${livre.genre} • ${livre.annee}'),
            if (livre.nouveaute) const _BadgeNouveau(),
          ],
        ),
        trailing: IconButton(
          tooltip: livre.favori ? 'Retirer des favoris' : 'Ajouter aux favoris',
          icon: Icon(
            livre.favori ? Icons.favorite : Icons.favorite_border,
            color: livre.favori ? Colors.red : null,
          ),
          onPressed: () => biblio.definirFavori(livre, !livre.favori),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Badge « Nouveau » affiché sous les sorties récentes.
class _BadgeNouveau extends StatelessWidget {
  const _BadgeNouveau();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
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
    );
  }
}
