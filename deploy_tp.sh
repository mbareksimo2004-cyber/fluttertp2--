#!/bin/bash

echo "===================================================="
echo " Démarrage de l'automatisation du TP MaBiblio"
echo "===================================================="

# Note: Remplacez VOTRE-COMPTE par votre nom d'utilisateur GitHub avant d'exécuter.

# --- PARTIE 00 ---
echo ""
echo "⏳ [1/8] Traitement : Partie 00 (Mise en place)"
git add .
git commit -m "Partie 00 : création du projet MaBiblio"
git push -u origin main
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 01 ---
echo ""
echo "⏳ [2/8] Traitement : Partie 01 (ListTile)"
git add lib/screens/parametres_screen.dart
git commit -m "Partie 01 : ListTile – écran Paramètres et livreTile()"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 02 ---
echo ""
echo "⏳ [3/8] Traitement : Partie 02 (ListView)"
git add lib/screens/catalogue_screen.dart
git commit -m "Partie 02 : ListView – listes défilables, builder et separated"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 03 ---
echo ""
echo "⏳ [4/8] Traitement : Partie 03 (CheckboxListTile)"
git add lib/screens/ma_liste_screen.dart
git commit -m "Partie 03 : CheckboxListTile – choix multiples et état tristate"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 04 ---
echo ""
echo "⏳ [5/8] Traitement : Partie 04 (Card)"
git add lib/widgets/livre_card.dart
git commit -m "Partie 04 : Card – mise en forme et structuration des livres"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 05 & 06 ---
echo ""
echo "⏳ [6/8] Traitement : Partie 05 & 06 (GridView)"
git add lib/screens/galerie_screen.dart
git commit -m "Partie 05 et 06 : GridView – grilles dynamiques et délégués"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 07 ---
echo ""
echo "⏳ [7/8] Traitement : Partie 07 (JSON)"
git add lib/services/livre_service.dart assets/livres.json
git commit -m "Partie 07 : JSON – chargement des données et FutureBuilder"
git push
echo "💤 Pause de 3 minutes..."
sleep 180

# --- PARTIE 08 ---
echo ""
echo "⏳ [8/8] Traitement : Partie 08 (Intégration finale)"
git add .
git commit -m "Partie 08 : Intégration finale de l'application MaBiblio"
git push
git tag v1.0
git push origin v1.0

echo ""
echo "===================================================="
echo "🎉 TP MaBiblio entièrement terminé et poussé avec succès !"
echo "===================================================="
