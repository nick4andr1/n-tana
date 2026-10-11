import 'package:flutter/material.dart';

/// Affiche un message temporaire pour les fonctionnalités pas encore codées.
void showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$feature : bientôt disponible')));
}
