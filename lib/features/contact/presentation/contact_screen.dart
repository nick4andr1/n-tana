import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';

/// Onglet « Contactez-nous » : espace réservé en attendant la maquette.
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.phone, size: 64, color: AppColors.primary),
          SizedBox(height: 12),
          Text(
            'Contactez-nous',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('Écran à venir'),
        ],
      ),
    );
  }
}
