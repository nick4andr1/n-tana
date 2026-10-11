import 'package:flutter/material.dart';

class RecentObjectsCarousel extends StatefulWidget {
       final Color buttonColor;
       final Color buttonTextColor;
       final Color titleColor;
       final Color descriptionColor;

       const RecentObjectsCarousel({
              super.key,
              this.buttonColor = Colors.white,
              this.buttonTextColor = const Color(0xFF15ABC6),
              this.titleColor = Colors.white,
              this.descriptionColor = Colors.white,
       });

       @override
       _RecentObjectsCarouselState createState() => _RecentObjectsCarouselState();
}

class _RecentObjectsCarouselState extends State<RecentObjectsCarousel> {
       final ScrollController _scrollController = ScrollController();

       final List<Map<String, String>> foundObjects = [
              {
                     "image": "assets/images/clé-perdue-5048877 1.png",
                     "title": "Clés de voiture",
                     "description": "Trouvé près du parc central"
              },
              {
                     "image": "assets/images/MontrePerdu.PNG",
                     "title": "Sac à dos",
                     "description": "Oublié à la gare"
              },
              {
                     "image": "assets/images/wallet.png",
                     "title": "Portefeuille",
                     "description": "hita teny anarabe"
              },
              {
                     "image": "assets/images/480716276_605788358921741_3238540447687043638_n.jpg",
                     "title": "Loup",
                     "description": "Trouvé dans un café"
              },
       ];

       void _scrollLeft() {
              _scrollController.animateTo(
                     _scrollController.offset - 150, // Défilement vers la gauche
                     duration: Duration(milliseconds: 300),
                     curve: Curves.easeInOut,
              );
       }

       void _scrollRight() {
              _scrollController.animateTo(
                     _scrollController.offset + 150, // Défilement vers la droite
                     duration: Duration(milliseconds: 300),
                     curve: Curves.easeInOut,
              );
       }

       @override
       Widget build(BuildContext context) {
              return Container(
                     height: 220, // Hauteur totale du carrousel
                     child: Row(
                            children: [
                                   // Flèche gauche rapprochée
                                   Padding(
                                          padding: const EdgeInsets.only(right: 0.2), // Moins d'espace entre la flèche et les images
                                          child: IconButton(
                                                 icon: Icon(Icons.arrow_back_ios, color: widget.buttonColor, size: 30),
                                                 onPressed: _scrollLeft,
                                          ),
                                   ),

                                   // Carrousel des objets
                                   Expanded(
                                          child: SingleChildScrollView(
                                                 controller: _scrollController,
                                                 scrollDirection: Axis.horizontal, // Défilement horizontal
                                                 child: Row(
                                                        children: foundObjects.map((object) {
                                                               return Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0), // Réduction de l'espace horizontal
                                                                      child: Card(
                                                                             color: Colors.transparent, // Supprime le fond blanc
                                                                             shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                             ),
                                                                             elevation: 0,
                                                                             child: Column(
                                                                                    children: [
                                                                                           ClipRRect(
                                                                                                  borderRadius:
                                                                                                  BorderRadius.vertical(top: Radius.circular(5)),
                                                                                                  child: Image.asset(
                                                                                                         object["image"]!,
                                                                                                         width: 95,
                                                                                                         height: 95, // Taille des images
                                                                                                         fit: BoxFit.fitWidth,
                                                                                                  ),
                                                                                           ),
                                                                                           Padding(
                                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                                  child: Column(
                                                                                                         crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                         children: [
                                                                                                                Text(object["title"]!,
                                                                                                                    style: TextStyle(
                                                                                                                        fontSize: 16,
                                                                                                                        color: widget.titleColor,
                                                                                                                        fontWeight: FontWeight.bold)),
                                                                                                                SizedBox(height: 5),
                                                                                                                Text(object["description"]!,
                                                                                                                    style: TextStyle(
                                                                                                                        fontSize: 12, color: widget.descriptionColor,
                                                                                                                    ),
                                                                                                                ),
                                                                                                                SizedBox(height: 7),
                                                                                                                ElevatedButton(
                                                                                                                       onPressed: () {
                                                                                                                              // Ajouter la navigation vers la page de détails ici
                                                                                                                       },
                                                                                                                       style: ElevatedButton.styleFrom(
                                                                                                                              backgroundColor: widget.buttonColor,
                                                                                                                              foregroundColor: widget.buttonTextColor,
                                                                                                                       ),
                                                                                                                       child: Text("Voir détails"),
                                                                                                                ),
                                                                                                         ],
                                                                                                  ),
                                                                                           ),
                                                                                    ],
                                                                             ),
                                                                      ),
                                                               );
                                                        }).toList(),
                                                 ),
                                          ),
                                   ),

                                   // Flèche droite rapprochée
                                   Padding(
                                          padding: const EdgeInsets.only(left: 0), // Moins d'espace entre la flèche et les images
                                          child: IconButton(
                                                 icon: Icon(Icons.arrow_forward_ios_rounded, color: widget.buttonColor, size: 30),
                                                 onPressed: _scrollRight,
                                          ),
                                   ),
                            ],
                     ),
              );
       }
}
