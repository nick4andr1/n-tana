enum ItemType { lost, found }

/// Un objet déclaré perdu ou trouvé.
/// (Version minimale : sera complétée avec date, lieu, déclarant, statut…)
class ItemModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final ItemType type;

  const ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.type = ItemType.found,
  });
}
