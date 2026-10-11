import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';
import 'package:n_tana/features/items/data/item_model.dart';

/// Carrousel horizontal des objets récemment trouvés, avec flèches gauche/droite.
class RecentItemsCarousel extends StatefulWidget {
  const RecentItemsCarousel({
    super.key,
    required this.items,
    this.onItemTap,
    this.buttonColor = Colors.white,
    this.buttonTextColor = AppColors.primary,
    this.titleColor = Colors.white,
    this.descriptionColor = Colors.white,
  });

  final List<ItemModel> items;

  /// Appelé quand on touche « Voir détails » sur un objet.
  final ValueChanged<ItemModel>? onItemTap;

  final Color buttonColor;
  final Color buttonTextColor;
  final Color titleColor;
  final Color descriptionColor;

  @override
  State<RecentItemsCarousel> createState() => _RecentItemsCarouselState();
}

class _RecentItemsCarouselState extends State<RecentItemsCarousel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) return;
    final ScrollPosition position = _scrollController.position;
    final double target = (_scrollController.offset + delta)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: widget.buttonColor, size: 30),
            onPressed: () => _scrollBy(-150),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final ItemModel item = widget.items[index];
                return _CarouselCard(
                  item: item,
                  buttonColor: widget.buttonColor,
                  buttonTextColor: widget.buttonTextColor,
                  titleColor: widget.titleColor,
                  descriptionColor: widget.descriptionColor,
                  onTap: widget.onItemTap == null
                      ? null
                      : () => widget.onItemTap!(item),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: widget.buttonColor, size: 30),
            onPressed: () => _scrollBy(150),
          ),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    required this.item,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.titleColor,
    required this.descriptionColor,
    this.onTap,
  });

  final ItemModel item;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color titleColor;
  final Color descriptionColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              item.imagePath,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 95,
                height: 95,
                color: Colors.black12,
                child: Icon(Icons.image_not_supported, color: titleColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: descriptionColor),
                ),
                const SizedBox(height: 7),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: buttonTextColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: const Text('Voir détails'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
