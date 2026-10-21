import 'package:flutter/material.dart';

/// Représente un livre de la bibliothèque.
///
/// L'objet est **immuable** : pour changer l'état de lecture ou de favori
/// on utilise [copyWith], ce qui évite de muter des objets partagés.
@immutable
class Livre {
  final int id;
  final String titre;
  final String auteur;
  final String genre; // Roman, Science, Histoire, Jeunesse, Informatique
  final int annee;
  final double note; // sur 5
  final Color couleur; // couleur de la « couverture »
  final bool nouveaute;
  final bool lu;
  final bool favori;

  const Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.annee,
    required this.note,
    required this.couleur,
    this.nouveaute = false,
    this.lu = false,
    this.favori = false,
  });

  /// Renvoie une copie du livre avec les champs modifiés.
  Livre copyWith({
    int? id,
    String? titre,
    String? auteur,
    String? genre,
    int? annee,
    double? note,
    Color? couleur,
    bool? nouveaute,
    bool? lu,
    bool? favori,
  }) {
    return Livre(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      auteur: auteur ?? this.auteur,
      genre: genre ?? this.genre,
      annee: annee ?? this.annee,
      note: note ?? this.note,
      couleur: couleur ?? this.couleur,
      nouveaute: nouveaute ?? this.nouveaute,
      lu: lu ?? this.lu,
      favori: favori ?? this.favori,
    );
  }

  @override
  String toString() => 'Livre($id, $titre)';
}
