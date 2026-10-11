import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';

/// Champ de recherche partagé (Accueil sur fond sombre, Actualités sur fond clair).
/// La croix « effacer » apparaît/disparaît toute seule selon le contenu.
class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onDark = false,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// true = style blanc translucide (fond sombre de l'accueil).
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = onDark ? Colors.white : Colors.grey;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: TextInputAction.search,
          style: TextStyle(color: onDark ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            hintText: 'Rechercher un objet...',
            hintStyle: TextStyle(color: onDark ? Colors.white : AppColors.hint),
            prefixIcon: Icon(Icons.search, color: iconColor),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(Icons.clear, color: iconColor),
                    onPressed: () {
                      controller.clear();
                      onChanged?.call('');
                    },
                  ),
            filled: true,
            fillColor: onDark ? Colors.white.withAlpha(51) : AppColors.fieldFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}
