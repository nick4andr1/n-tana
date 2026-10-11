import 'package:flutter/material.dart';
import 'package:n_tana/HomePage.dart';
import 'package:n_tana/SignUpScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(0xFF054955),
          foregroundColor : Colors.white,
           centerTitle: true,
      ), */
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF054955), // Première couleur du dégradé (bleu)
              Color(0xFF15ABC6) // Deuxième couleur du dégradé (vert)
            ],
            begin: Alignment.topCenter, // Début du dégradé
            end: Alignment.bottomCenter, // Fin du dégradé
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image au-dessus du titre
              Image.asset(
                'assets/images/magnifying_glass.png', // Chemin de l'image
                height: 158, // Ajuste la hauteur de l'image selon tes besoins
                width: 178
              ),
              SizedBox(height: 10),
              Text(
                'Authentification',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Adresse Email',
                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20), // Texte du label en blanc
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.black87), // Icône bonhomme à gauche
                  fillColor: Color(0xFFE9E7E7), // Fond personnalisé (ici une couleur bleu clair)
                  filled: true, // Active le fond
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.grey,fontSize: 20), // Texte du label en blanc
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: Icon(Icons.visibility, color: Colors.black38), // Icône en blanc
                  prefixIcon: Icon(Icons.lock, color: Colors.black87), // Icône bonhomme à gauche
                  fillColor: Color(0xFFE9E7E7), // Fond personnalisé (ici une couleur bleu clair)
                  filled: true, // Active le fond
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext newContext) => HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Color(0xFF15ABC6),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Se connecter',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //API  de passe oublié
                },
                child: Text('Mot de passe oublié ?',
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('______________________ OU ______________________',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              // Google Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implémentation de la connexion Google
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons8-logo-google-96.svg', // Chemin vers le fichier SVGh
                    //color: Colors.red, // Applique une couleur à l'icône SVG
                    height: 43,
                    width: 43,
                  ),
                  label: Text('Se connecter avec Google', style: TextStyle(color: Colors.black,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fond transparent pour appliquer le dégradé
                    foregroundColor: Colors.black, // Texte en blanc
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Facebook Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implémentation de la connexion Facebook
                  },
                  icon: FaIcon(FontAwesomeIcons.squareFacebook, color: Colors.white, size : 35),
                  label: Text('Se connecter avec Facebook',
                      style: TextStyle(color: Colors.white,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B5998), // Fond transparent pour appliquer le dégradé
                    foregroundColor: Colors.white, // Texte en blanc
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              // Lien inscription
              TextButton(
                onPressed: () {                },
                child: Text('Pas encore inscrit ?', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext newContext) => SignUpScreen()),
                    );
                  },
                  label: Text(' Crée un compte', style: TextStyle(color: Colors.black, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF15ABC6), // Fond transparent pour appliquer le dégradé
                    //foregroundColor: Colors.white, // Texte en blanc
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
