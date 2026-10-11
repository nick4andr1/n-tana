import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';
import 'package:n_tana/core/utils/snackbars.dart';
import 'package:n_tana/features/items/data/item_model.dart';
import 'package:n_tana/features/items/data/mock_items.dart';
import 'package:n_tana/features/items/presentation/widgets/item_card.dart';
import 'package:n_tana/features/items/presentation/widgets/recent_items_carousel.dart';
import 'package:n_tana/shared/widgets/search_bar_field.dart';

/// Contenu de l'onglet « Actualités » : recherche, récents et liste des objets trouvés.
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.searchQuery});

  /// Texte de recherche venant de l'accueil (via MainScaffold).
  final ValueNotifier<String> searchQuery;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static const TextStyle _sectionStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery.value;
    widget.searchQuery.addListener(_syncQuery);
  }

  @override
  void didUpdateWidget(covariant NewsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      oldWidget.searchQuery.removeListener(_syncQuery);
      widget.searchQuery.addListener(_syncQuery);
      _syncQuery();
    }
  }

  @override
  void dispose() {
    widget.searchQuery.removeListener(_syncQuery);
    _searchController.dispose();
    super.dispose();
  }

  void _syncQuery() {
    if (_searchController.text != widget.searchQuery.value) {
      _searchController.text = widget.searchQuery.value;
    }
  }

  List<ItemModel> _filter(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return mockItems;
    return mockItems
        .where((item) =>
            item.title.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q))
        .toList();
  }

  void _openDetails(ItemModel item) {
    // TODO: ouvrir l'écran « Détails objet » (maquette Figma prête).
    showComingSoon(context, 'Détails de « ${item.title} »');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(25),
      children: [
        SearchBarField(controller: _searchController),
        const SizedBox(height: 10),
        const Text('Récemment trouvés', style: _sectionStyle),
        RecentItemsCarousel(
          items: mockItems,
          onItemTap: _openDetails,
          buttonColor: AppColors.primary,
          buttonTextColor: Colors.white,
          titleColor: Colors.black,
          descriptionColor: Colors.black,
        ),
        const SizedBox(height: 4),
        const Text('Liste des objets trouvés', style: _sectionStyle),
        const SizedBox(height: 8),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _searchController,
          builder: (context, value, _) {
            final List<ItemModel> results = _filter(value.text);
            if (results.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('Aucun objet trouvé')),
              );
            }
            return Column(
              children: [
                for (final ItemModel item in results)
                  ItemCard(item: item, onTap: () => _openDetails(item)),
              ],
            );
          },
        ),
      ],
    );
  }
}
