import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';
import 'package:n_tana/core/utils/snackbars.dart';
import 'package:n_tana/features/items/data/item_model.dart';
import 'package:n_tana/features/items/data/mock_items.dart';
import 'package:n_tana/features/items/presentation/widgets/recent_items_carousel.dart';
import 'package:n_tana/shared/widgets/search_bar_field.dart';

/// Contenu de l'onglet « Accueil ».
/// L'AppBar, le menu et la barre du bas sont fournis par MainScaffold.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onSearch,
    required this.onSeeAll,
  });

  /// Appelé quand l'utilisateur valide une recherche (le clavier « loupe »).
  final ValueChanged<String> onSearch;

  /// Appelé par le lien « Voir tout » (ouvre l'onglet Actualités).
  final VoidCallback onSeeAll;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch(String value) {
    final String query = value.trim();
    if (query.isEmpty) return;
    widget.onSearch(query);
  }

  void _declare(ItemType type) {
    // TODO: ouvrir l'écran de déclaration (maquette à réaliser).
    showComingSoon(
      context,
      type == ItemType.lost
          ? "Déclaration d'un objet perdu"
          : "Déclaration d'un objet trouvé",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const ColoredBox(color: AppColors.primaryDark),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(color: Colors.black.withAlpha(128)),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarField(
                controller: _searchController,
                onDark: true,
                onSubmitted: _submitSearch,
              ),
              const SizedBox(height: 20),
              const Text(
                'Dans quelle situation êtes-vous?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _ActionButton(
                label: "J'ai perdu un objet",
                icon: CupertinoIcons.doc_text_search,
                backgroundColor: AppColors.primary,
                onPressed: () => _declare(ItemType.lost),
              ),
              const SizedBox(height: 16),
              _ActionButton(
                label: "J'ai trouvé un objet",
                icon: Icons.search_sharp,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                onPressed: () => _declare(ItemType.found),
              ),
              const SizedBox(height: 22),
              _buildHopeBanner(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Récemment trouvés',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onSeeAll,
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RecentItemsCarousel(
                items: mockItems,
                onItemTap: (item) =>
                    showComingSoon(context, 'Détails de « ${item.title} »'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHopeBanner() {
    return Container(
      width: double.infinity,
      color: AppColors.primary.withAlpha(128),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 0,
            child: Image.asset(
              'assets/images/magnifying_glass.png',
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox(width: 60, height: 60),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ne perdez pas espoir !',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Votre objet a peut-être été retrouvé. Cherchez-le ou aidez quelqu'un en déclarant un objet trouvé !",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    this.foregroundColor = Colors.white,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        icon: Icon(icon),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
