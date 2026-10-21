import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';

/// Écran « Ma liste » : les livres que l'on a lus (ou pas).
///
/// Deux widgets sont utilisés :
/// - un [CheckboxListTile] `tristate` en tête, qui pilote toute la liste
///   (non lu / partiellement lu / tout lu) ;
/// - un [CheckboxListTile] par livre, pour cocher/décocher un ouvrage.
class MaListeScreen extends StatelessWidget {
  const MaListeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: biblio,
        builder: (BuildContext context, Widget? child) {
          final List<Livre> livres = biblio.livres;
          return Column(
            children: <Widget>[
              CheckboxListTile(
                tristate: true,
                title: const Text('Marquer tous les livres comme lus'),
                subtitle: Text(_resume(livres)),
                value: biblio.tousLus,
                onChanged: (bool? value) {
                  biblio.definirTousLus(value ?? false);
                },
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: livres.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Livre livre = livres[index];
                    return CheckboxListTile(
                      title: Text(livre.titre),
                      subtitle: Text(livre.auteur),
                      value: livre.lu,
                      onChanged: (bool? value) {
                        biblio.definirLu(livre, value ?? false);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Résumé de l'avancement de la lecture (ex. « 3 / 12 »).
  static String _resume(List<Livre> livres) {
    final int lus = livres.where((Livre livre) => livre.lu).length;
    return '$lus / ${livres.length} lus';
  }
}
