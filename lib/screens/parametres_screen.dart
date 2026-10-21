import 'package:flutter/material.dart';

/// Écran « Paramètres ».
///
/// Il met en œuvre le widget [ListTile] sous toutes ses formes :
/// icône de tête (`leading`), sous-titre (`subtitle`), icône de fin
/// (`trailing`), couleur de fond (`tileColor`), couleur des icônes
/// (`iconColor`), couleur du texte (`textColor`), forme (`shape`),
/// densité (`dense`) et action (`onTap`).
class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            tileColor: Colors.grey.shade100,
            iconColor: Colors.blue,
            textColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications activées')),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
            subtitle: Text('MaBiblio — TP Flutter 2'),
            dense: true,
            isThreeLine: false,
            enabled: true,
          ),
        ],
      ),
    );
  }
}
