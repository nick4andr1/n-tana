import 'package:flutter/material.dart';
import 'package:n_tana/HomePage.dart';
import 'package:n_tana/LoginScreen.dart';

void main() => runApp(
    const MyApp()
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


