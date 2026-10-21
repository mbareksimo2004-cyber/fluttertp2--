import 'package:flutter/material.dart';

import '../models/livre.dart';

/// Jeu de données par défaut.
///
/// Il sert de repli lorsque le fichier `assets/livres.json` n'a pas encore été
/// chargé (ou n'a pas pu l'être). La source de vérité reste le JSON.
const List<Livre> livresParDefaut = <Livre>[
  Livre(
    id: 1,
    titre: 'Le Petit Prince',
    auteur: 'A. de Saint-Exupéry',
    genre: 'Jeunesse',
    annee: 1943,
    note: 4.8,
    couleur: Color(0xFF0288D1),
  ),
  Livre(
    id: 2,
    titre: "L'Étranger",
    auteur: 'Albert Camus',
    genre: 'Roman',
    annee: 1942,
    note: 4.3,
    couleur: Color(0xFFE64A19),
  ),
  Livre(
    id: 3,
    titre: 'Une brève histoire du temps',
    auteur: 'Stephen Hawking',
    genre: 'Science',
    annee: 1988,
    note: 4.5,
    couleur: Color(0xFF283593),
    nouveaute: true,
  ),
  Livre(
    id: 4,
    titre: 'Sapiens',
    auteur: 'Yuval Noah Harari',
    genre: 'Histoire',
    annee: 2011,
    note: 4.6,
    couleur: Color(0xFF6D4C41),
    nouveaute: true,
  ),
  Livre(
    id: 5,
    titre: 'Clean Code',
    auteur: 'Robert C. Martin',
    genre: 'Informatique',
    annee: 2008,
    note: 4.4,
    couleur: Color(0xFF2E7D32),
    nouveaute: true,
  ),
  Livre(
    id: 6,
    titre: 'Le Comte de Monte-Cristo',
    auteur: 'Alexandre Dumas',
    genre: 'Roman',
    annee: 1844,
    note: 4.9,
    couleur: Color(0xFF5E35B1),
  ),
  Livre(
    id: 7,
    titre: 'Cosmos',
    auteur: 'Carl Sagan',
    genre: 'Science',
    annee: 1980,
    note: 4.5,
    couleur: Color(0xFF00838F),
  ),
  Livre(
    id: 8,
    titre: 'La Muqaddima',
    auteur: 'Ibn Khaldoun',
    genre: 'Histoire',
    annee: 1377,
    note: 4.7,
    couleur: Color(0xFFF9A825),
  ),
  Livre(
    id: 9,
    titre: "Harry Potter à l'école des sorciers",
    auteur: 'J. K. Rowling',
    genre: 'Jeunesse',
    annee: 1997,
    note: 4.7,
    couleur: Color(0xFFC2185B),
    nouveaute: true,
  ),
  Livre(
    id: 10,
    titre: 'The Pragmatic Programmer',
    auteur: 'Hunt & Thomas',
    genre: 'Informatique',
    annee: 1999,
    note: 4.6,
    couleur: Color(0xFF455A64),
  ),
  Livre(
    id: 11,
    titre: 'Les Misérables',
    auteur: 'Victor Hugo',
    genre: 'Roman',
    annee: 1862,
    note: 4.8,
    couleur: Color(0xFFAD1457),
  ),
  Livre(
    id: 12,
    titre: 'Le Gène égoïste',
    auteur: 'Richard Dawkins',
    genre: 'Science',
    annee: 1976,
    note: 4.2,
    couleur: Color(0xFF558B2F),
  ),
];

/// Magasin d'état de l'application (pattern [ChangeNotifier]).
///
/// Il remplace l'ancienne liste globale mutable : toute modification passe
/// par [definirLu], [definirFavori] ou [definirTousLus], qui notifient les
/// widgets abonnés via `ListenableBuilder`.
class BiblioStore extends ChangeNotifier {
  BiblioStore({List<Livre>? livres})
      : _livres = List<Livre>.of(livres ?? livresParDefaut);

  List<Livre> _livres;

  /// Liste des livres (non modifiable par l'appelant).
  List<Livre> get livres => List<Livre>.unmodifiable(_livres);

  /// Remplace l'ensemble des livres (utilisé après le chargement du JSON).
  void remplacerLivres(List<Livre> nouveaux) {
    _livres = List<Livre>.of(nouveaux);
    notifyListeners();
  }

  /// Marque un livre comme lu / non lu.
  void definirLu(Livre livre, bool valeur) {
    final index = _indexDe(livre);
    if (index == -1) return;
    _livres[index] = livre.copyWith(lu: valeur);
    notifyListeners();
  }

  /// Ajoute / retire un livre des favoris.
  void definirFavori(Livre livre, bool valeur) {
    final index = _indexDe(livre);
    if (index == -1) return;
    _livres[index] = livre.copyWith(favori: valeur);
    notifyListeners();
  }

  /// Marque tous les livres comme lus / non lus.
  void definirTousLus(bool valeur) {
    _livres = [for (final livre in _livres) livre.copyWith(lu: valeur)];
    notifyListeners();
  }

  /// `true` si tous les livres sont lus, `false` si aucun ne l'est,
  /// `null` si c'est partiel (état « tristate » du CheckboxListTile).
  bool? get tousLus {
    if (_livres.isEmpty) return false;
    final lus = _livres.where((livre) => livre.lu).length;
    if (lus == 0) return false;
    if (lus == _livres.length) return true;
    return null;
  }

  /// Sous-ensemble des livres mis en favori.
  List<Livre> get favoris =>
      _livres.where((livre) => livre.favori).toList(growable: false);

  int _indexDe(Livre livre) =>
      _livres.indexWhere((element) => element.id == livre.id);
}

/// Instance unique du magasin, accessible depuis toute l'application.
final BiblioStore biblio = BiblioStore();
