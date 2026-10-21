import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/services/livre_service.dart';

void main() {
  group('LivreService', () {
    test('Le fichier assets/livres.json est valide', () {
      final String contenu =
          File(LivreService.cheminAssets).readAsStringSync();
      final List<Livre> livres = LivreService.convertirJson(contenu);

      expect(livres, hasLength(12));
      expect(livres.first.titre, 'Le Petit Prince');
      expect(livres.first.auteur, 'A. de Saint-Exupéry');
      expect(livres.first.genre, 'Jeunesse');
      expect(livres.first.annee, 1943);
      expect(livres.first.note, 4.8);
    });

    test('Les couleurs hexadécimales sont correctement converties', () {
      final List<Livre> livres = LivreService.convertirJson('''
        [
          {"id": 1, "titre": "A", "auteur": "B", "genre": "Roman",
           "annee": 2000, "note": 4.5, "couleur": "#FF0288D1"}
        ]
      ''');

      expect(livres.single.couleur, const Color(0xFF0288D1));
    });

    test('Une couleur absente ou invalide utilise la couleur par défaut', () {
      final List<Livre> livres = LivreService.convertirJson('''
        [
          {"id": 1, "titre": "A", "auteur": "B", "genre": "Roman",
           "annee": 2000, "note": 4.5},
          {"id": 2, "titre": "C", "auteur": "D", "genre": "Roman",
           "annee": 2001, "note": 4.0, "couleur": "nawak"}
        ]
      ''');

      expect(livres.first.couleur, LivreService.couleurParDefaut);
      expect(livres.last.couleur, LivreService.couleurParDefaut);
    });

    test('Les champs optionnels valent false par défaut', () {
      final List<Livre> livres = LivreService.convertirJson('''
        [
          {"id": 1, "titre": "A", "auteur": "B", "genre": "Roman",
           "annee": 2000, "note": 4}
        ]
      ''');

      expect(livres.single.note, 4.0);
      expect(livres.single.nouveaute, isFalse);
      expect(livres.single.lu, isFalse);
      expect(livres.single.favori, isFalse);
    });
  });
}
