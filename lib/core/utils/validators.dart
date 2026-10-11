/// Validateurs de formulaires : renvoient un message d'erreur, ou null si valide.
class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(
    String? value, [
    String message = 'Ce champ est obligatoire',
  ]) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < minLength) {
      return 'Le mot de passe doit avoir au moins $minLength caractères';
    }
    return null;
  }
}
