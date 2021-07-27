import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startapp/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final wordPair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
      home: HomePage()
    );
  }
}
