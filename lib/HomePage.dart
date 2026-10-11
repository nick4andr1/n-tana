import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_tana/Actualities.dart';
import 'package:n_tana/RecentObjectsCarousel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear(); // Efface le texte du champ
    });
  }

  int _selectedIndex = 1; // Par défaut, l'accueil est sélectionné

  // Liste des pages
  final List<Widget> _pages = [
    Actualities(),
    HomePage(),
    //ContactPage(),
  ];

  // Fonction pour changer d'onglet
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Pousse la page correspondante via Navigator.push
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Bienvenue")),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          )
        ],
        backgroundColor: Color(0xFF15ABC6),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF15ABC6),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 26),
                  Text(
                    'Nicky Larson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Accueil'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Paramètre'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.PNG",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Rechercher un objet...",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.white),
                      onPressed: _clearSearch,
                    )
                        : null,
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {}); // Met à jour dynamiquement l'affichage du bouton "clear"
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Dans quelle situation êtes-vous?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 16),
                _buildButton(context, "J'ai perdu un objet", CupertinoIcons.doc_text_search, Color(0xFF15ABC6)),
                SizedBox(height: 16),
                _buildButton(context, "J'ai trouvé un objet", Icons.search_sharp, Colors.white, textColor: Color(0xFF15ABC6)),
                SizedBox(height: 22),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Color(0xFF15ABC6).withOpacity(0.5),
                      ),
                    ),
                    Stack(
                      children: [
                        // L'image de fond placée derrière le texte
                        Positioned(// Place l'image à droite
                            bottom: 2,    // Décale l'image de 50 pixels du haut
                            right: 0,
                            child: Image.asset(
                            "assets/images/magnifying_glass.png", // Image de fond
                            width: 60,
                            height: 60,
                          ),
                        ),
                        // Le contenu principal (punchline, etc.)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            //color: Color(0xFF15ABC6).withOpacity(0.5), // Couleur de fond pour le punchline
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ne perdez pas espoir !",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Votre objet a peut-être été retrouvé. Cherchez-le ou aidez quelqu'un en déclarant un objet trouvé !",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Récemment trouvés",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext newContext) => Actualities()),
                          );
                        },
                        child: Text("Voir tout",
                        style: TextStyle(color: Color(0xFF15ABC6), fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Color(0xFF15ABC6)),
                        )
                    )
                   ]
                ),
                SizedBox(height: 10),
                RecentObjectsCarousel(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF15ABC6),
        unselectedItemColor: Color(0xFFE9E5E5),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // événement de clic
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contactez-nous',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.message,
          color: Color(0xFF15ABC6),
          size: 30,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, Color bgColor, {Color textColor = Colors.white}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext newContext) => Actualities()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: bgColor,
          foregroundColor: textColor,
        ),
        icon: Icon(icon),
        label: Text(
          text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
