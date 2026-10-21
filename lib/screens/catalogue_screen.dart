import 'package:flutter/material.dart';

import '../data/livres_data.dart';

/// Écran « Catalogue » : la liste complète de la bibliothèque.
///
/// La liste défile grâce à un [ListView.separated] construit à la volée
/// (motif « builder ») : seules les lignes visibles sont créées, ce qui
/// reste fluide même avec une bibliothèque de plusieurs centaines de livres.
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
              return ListTile(
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
                subtitle: Text(
                  '${livre.auteur} • ${livre.genre} • ${livre.annee}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      livre.lu ? Icons.check_circle : Icons.circle_outlined,
                      size: 18,
                      color: livre.lu ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${livre.note.toStringAsFixed(1)} ★',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
