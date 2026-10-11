
import 'package:flutter/material.dart';
import 'package:n_tana/RecentObjectsCarousel.dart';

class Actualities extends StatelessWidget{
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Actualités')),
        backgroundColor: Color(0xFF15ABC6),
        foregroundColor: Colors.white,
      ),
      body: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Rechercher un objet...",
                          hintStyle: TextStyle(color: Color(0xFFC3C0C0)),
                          prefixIcon:Icon(Icons.search,color: Colors.grey,),
                          filled: true,
                          fillColor: Color(0xFFE9E5E5), //.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none
                          ),
                          suffixIcon: _searchController.text.isNotEmpty ? IconButton(
                                            icon: Icon(Icons.clear, color: Colors.grey),
                                                    onPressed: _searchController.dispose
                            , ) :
                          null,),
                          style: TextStyle(color: Colors.grey), onChanged: (value) {
                                  _searchController.clear; // Met à jour dynamiquement l'affichage du bouton "clear"
                          },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Récemment trouvés",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      RecentObjectsCarousel(
                        buttonColor: Color(0xFF15ABC6),
                        buttonTextColor: Colors.white,
                        titleColor: Colors.black,
                        descriptionColor: Colors.black,
                      ),
                      SizedBox(height: 0),
                      Text(
                        "Liste des objets trouvés",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
              )
            ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Color(0xFF15ABC6),
        unselectedItemColor: Color(0xFFE9E5E5),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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
    );
  }
}