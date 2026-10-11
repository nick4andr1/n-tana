# n_tana — étapes 1 et 2 (corrections + rangement)

## Comment appliquer

1. **Commitez d'abord votre état actuel** (`git add . && git commit -m "avant refactor"`) pour pouvoir revenir en arrière.
2. Dans votre projet `n_tana/` :
   - supprimez **les anciens fichiers de `lib/`** : `Actualities.dart`, `HomePage.dart`, `LoginScreen.dart`, `SignUpScreen.dart`, `RecentObjectsCarousel.dart`, `_SearchScreenState.dart`, `main.dart` ;
   - copiez le dossier `lib/` de ce zip à la place ;
   - remplacez `pubspec.yaml` et `test/widget_test.dart` par ceux du zip (ne touchez pas à `assets/`, `android/`, `ios/`…).
3. Dans le terminal :
   ```
   flutter clean
   flutter pub get
   flutter analyze
   flutter run
   ```

## Ce qui a été corrigé

| Problème | Correction |
|---|---|
| Barre du bas : `Navigator.push` empilait les pages, morte dans Actualités | `MainScaffold` + `IndexedStack` : 3 onglets, une seule barre |
| Croix de recherche appelait `dispose()` (crash) | `SearchBarField` partagé, croix gérée par `ValueListenableBuilder` |
| `_SearchScreenState.dart` (build = `UnimplementedError`) | supprimé |
| Débordement d'écran (Login, Accueil) | contenu scrollable |
| Connexion sans contrôleurs ni validation | `Form` + `Validators` ; « Se connecter » utilise `pushReplacement` |
| Œil du mot de passe inerte | bascule affichage/masquage |
| Boutons « J'ai perdu / trouvé » menaient tous deux à Actualités | message « bientôt disponible » (écrans à créer) |
| Contrôleurs jamais libérés | `dispose()` partout |
| Couleur `0xFF15ABC6` répétée ~20 fois | `AppColors` + `AppTheme` |
| `flutter_svg 0.22` (2021) et `carousel_slider` inutilisé | `flutter_svg ^2`, `carousel_slider` retiré |
| Données du carrousel en dur dans le widget | `ItemModel` + `mock_items.dart` |

## À vérifier à la main

- Les images ont été renommées en `snake_case` sans accent ni espace :
   `cles_perdues.png`, `montre_perdue.png` et `background.png`.
- Vérifier les droits de la photo `480716276_..._n.jpg` (nom typique d'une image Facebook).
- Le nom « Nicky Larson » du menu est une constante de démonstration dans `main_scaffold.dart`.

## Prochaine étape

Écran « Détails objet », puis déclaration d'un objet, puis couche API (`dio`).

> Ces fichiers n'ont pas pu être compilés dans mon environnement (pas de Flutter installé).
> Si `flutter analyze` signale une erreur, envoyez-moi le message exact.
