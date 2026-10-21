import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/livre.dart';

/// Service responsable du chargement des données de la bibliothèque.
///
/// La source de vérité est le fichier `assets/livres.json` : il est lu via
/// [rootBundle] puis converti en une liste d'objets [Livre] (voir
/// [convertirJson]).
class LivreService {
  const LivreService._();

  /// Chemin du fichier JSON dans les assets de l'application.
  static const String cheminAssets = 'assets/livres.json';

  /// Couleur utilisée lorsqu'une couleur est absente ou invalide.
  static const Color couleurParDefaut = Color(0xFF0288D1);

  /// Lit `assets/livres.json` et renvoie les livres correspondants.
  static Future<List<Livre>> chargerLivresDepuisAssets() async {
    final String contenu = await rootBundle.loadString(cheminAssets);
    return convertirJson(contenu);
  }

  /// Convertit le contenu JSON d'un catalogue en liste de [Livre].
  ///
  /// Chaque entrée accepte les champs `id`, `titre`, `auteur`, `genre`,
  /// `annee`, `note`, `couleur` (hexadécimal) et `nouveaute` (optionnel).
  static List<Livre> convertirJson(String contenu) {
    final Object? donnees = json.decode(contenu);
    if (donnees is! List) return <Livre>[];

    return donnees
        .whereType<Map<String, dynamic>>()
        .map(_versLivre)
        .toList(growable: false);
  }

  /// Transforme une entrée JSON en [Livre].
  static Livre _versLivre(Map<String, dynamic> json) {
    return Livre(
      id: (json['id'] as num?)?.toInt() ?? 0,
      titre: json['titre'] as String? ?? 'Titre inconnu',
      auteur: json['auteur'] as String? ?? 'Auteur inconnu',
      genre: json['genre'] as String? ?? 'Genre inconnu',
      annee: (json['annee'] as num?)?.toInt() ?? 0,
      note: (json['note'] as num?)?.toDouble() ?? 0,
      couleur: _versCouleur(json['couleur']),
      nouveaute: json['nouveaute'] as bool? ?? false,
    );
  }

  /// Convertit une couleur hexadécimale (`#RRGGBB` ou `#AARRGGBB`) en [Color].
  static Color _versCouleur(Object? valeur) {
    if (valeur is! String) return couleurParDefaut;

    final String hexa = valeur.trim().replaceFirst('#', '');
    try {
      if (hexa.length == 6) {
        return Color(int.parse('FF$hexa', radix: 16));
      }
      if (hexa.length == 8) {
        return Color(int.parse(hexa, radix: 16));
      }
    } on FormatException {
      return couleurParDefaut;
    }
    return couleurParDefaut;
  }
}
