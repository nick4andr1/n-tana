import 'package:flutter/material.dart';
import 'package:n_tana/core/constants/app_colors.dart';
import 'package:n_tana/core/utils/snackbars.dart';
import 'package:n_tana/features/auth/presentation/login_screen.dart';
import 'package:n_tana/features/contact/presentation/contact_screen.dart';
import 'package:n_tana/features/items/presentation/home_screen.dart';
import 'package:n_tana/features/items/presentation/news_screen.dart';

/// Coquille de l'application une fois connecté : AppBar, menu latéral,
/// barre de navigation du bas et les 3 onglets (Actualités, Accueil, Contact).
/// Les onglets sont gardés en mémoire (IndexedStack) : plus d'empilement de pages.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key, this.initialIndex = 1});

  /// 0 = Actualités, 1 = Accueil, 2 = Contact.
  final int initialIndex;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  static const List<String> _titles = [
    'Actualités',
    'Bienvenue',
    'Contactez-nous',
  ];

  // TODO: remplacer par l'utilisateur connecté (AuthController).
  static const String _demoUserName = 'Nicky Larson';

  late int _index = widget.initialIndex;
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  void _goToTab(int index) => setState(() => _index = index);

  void _search(String query) {
    // On repasse par '' pour forcer la mise à jour même si le texte est identique.
    _searchQuery.value = '';
    _searchQuery.value = query;
    _goToTab(0);
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => showComingSoon(context, 'Profil'),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _index,
        children: [
          NewsScreen(searchQuery: _searchQuery),
          HomeScreen(onSearch: _search, onSeeAll: () => _goToTab(0)),
          const ContactScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _goToTab,
        backgroundColor: AppColors.primary,
        unselectedItemColor: AppColors.fieldFill,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone), label: 'Contactez-nous'),
        ],
      ),
      floatingActionButton: _index == 1
          ? FloatingActionButton(
              onPressed: () => showComingSoon(context, 'Messagerie'),
              child: const Icon(
                Icons.message,
                color: AppColors.primary,
                size: 30,
              ),
            )
          : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person, color: Colors.black, size: 40),
                ),
                SizedBox(width: 26),
                Expanded(
                  child: Text(
                    _demoUserName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              Navigator.pop(context);
              _goToTab(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Actualités'),
            onTap: () {
              Navigator.pop(context);
              _goToTab(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètre'),
            onTap: () {
              Navigator.pop(context);
              showComingSoon(context, 'Paramètres');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              _logout();
            },
          ),
        ],
      ),
    );
  }
}
