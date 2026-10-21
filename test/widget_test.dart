import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ma_biblio/data/livres_data.dart';
import 'package:ma_biblio/main.dart';

void main() {
  setUp(() {
    biblio.remplacerLivres(livresParDefaut);
  });

  testWidgets('Le catalogue s\'affiche avec la navigation principale',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    expect(find.text('MaBiblio'), findsOneWidget);
    expect(find.text('Catalogue'), findsOneWidget);
    expect(find.text('Galerie'), findsOneWidget);
    expect(find.text('Ma liste'), findsOneWidget);
    expect(find.text('Le Petit Prince'), findsOneWidget);
  });

  testWidgets('La galerie affiche les livres dans une grille',
      (WidgetTester tester) async {
    // Surface plus haute pour que la grille construise plusieurs lignes.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaBiblioApp());

    await tester.tap(find.text('Galerie'));
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Le Petit Prince'), findsOneWidget);
    expect(find.text('Sapiens'), findsOneWidget);
    expect(find.text('Nouveau'), findsWidgets);
  });

  testWidgets('Cocher un livre dans Ma liste met à jour son état',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    await tester.tap(find.text('Ma liste'));
    await tester.pumpAndSettle();

    expect(find.text('Marquer tous les livres comme lus'), findsOneWidget);

    await tester.tap(find.text('Le Petit Prince'));
    await tester.pumpAndSettle();

    final CheckboxListTile tile =
        tester.widget(find.widgetWithText(CheckboxListTile, 'Le Petit Prince'));
    expect(tile.value, isTrue);
    expect(
      biblio.livres.firstWhere((livre) => livre.titre == 'Le Petit Prince').lu,
      isTrue,
    );
  });

  testWidgets('Le bouton « tout marquer comme lu » bascule l\'état tristate',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    await tester.tap(find.text('Ma liste'));
    await tester.pumpAndSettle();

    expect(biblio.tousLus, isFalse);

    await tester.tap(find.text('Marquer tous les livres comme lus'));
    await tester.pumpAndSettle();

    expect(biblio.tousLus, isTrue);
    expect(biblio.livres.every((livre) => livre.lu), isTrue);
  });

  testWidgets('Le favori peut être activé depuis la carte du catalogue',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    expect(biblio.favoris, isEmpty);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    expect(biblio.favoris, hasLength(1));
  });

  testWidgets('L\'écran Paramètres s\'ouvre depuis la barre d\'application',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Mon profil'), findsOneWidget);
  });

  testWidgets('L\'application démarre sans faire d\'E/S bloquante',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());

    // Le catalogue est immédiatement visible, sans attendre le JSON.
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Le Comte de Monte-Cristo'), findsOneWidget);
  });
}
