import 'package:n_tana/features/items/data/item_model.dart';

/// Données de démonstration, en attendant le backend.
/// Les chemins d'images sont ceux déjà présents dans assets/images/.
const List<ItemModel> mockItems = [
  ItemModel(
    id: '1',
    title: 'Clés de voiture',
    description: 'Trouvé près du parc central',
    imagePath: 'assets/images/cles_perdues.png',
  ),
  ItemModel(
    id: '2',
    title: 'Sac à dos',
    description: 'Oublié à la gare',
    imagePath: 'assets/images/montre_perdue.png',
  ),
  ItemModel(
    id: '3',
    title: 'Portefeuille',
    description: 'hita teny anarabe',
    imagePath: 'assets/images/wallet.png',
  ),
  ItemModel(
    id: '4',
    title: 'Loup',
    description: 'Trouvé dans un café',
    imagePath:
        'assets/images/480716276_605788358921741_3238540447687043638_n.jpg',
  ),
];
