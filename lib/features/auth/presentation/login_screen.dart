import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_tana/core/constants/app_colors.dart';
import 'package:n_tana/core/utils/snackbars.dart';
import 'package:n_tana/core/utils/validators.dart';
import 'package:n_tana/features/auth/presentation/register_screen.dart';
import 'package:n_tana/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:n_tana/features/auth/presentation/widgets/social_login_button.dart';
import 'package:n_tana/shared/widgets/main_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // TODO(auth): appeler AuthRepository.login(email, mot de passe) avant de naviguer.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainScaffold()),
    );
  }

  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDark, AppColors.primary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(45),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/magnifying_glass.png',
                      height: 158,
                      width: 178,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.search, size: 100, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Authentification',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthTextField(
                      controller: _emailController,
                      label: 'Adresse Email',
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _passwordController,
                      label: 'Mot de passe',
                      prefixIcon: Icons.lock,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _login(),
                      validator: (value) => Validators.required(
                        value,
                        'Veuillez entrer votre mot de passe',
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black38,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          showComingSoon(context, 'Mot de passe oublié'),
                      child: const Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white54)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child:
                              Text('OU', style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(child: Divider(color: Colors.white54)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SocialLoginButton(
                      label: 'Se connecter avec Google',
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      icon: SvgPicture.asset(
                        'assets/images/icons8-logo-google-96.svg',
                        height: 43,
                        width: 43,
                      ),
                      onPressed: () =>
                          showComingSoon(context, 'Connexion Google'),
                    ),
                    const SizedBox(height: 20),
                    SocialLoginButton(
                      label: 'Se connecter avec Facebook',
                      backgroundColor: AppColors.facebook,
                      foregroundColor: Colors.white,
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () =>
                          showComingSoon(context, 'Connexion Facebook'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pas encore inscrit ?',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _goToRegister,
                        child: const Text(
                          'Créer un compte',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
