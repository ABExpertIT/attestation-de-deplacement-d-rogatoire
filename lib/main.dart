import 'package:flutter/material.dart';
import 'package:attestation/ui/login_page.dart';
import 'package:attestation/ui/raisonsortie_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Attestation_de_deplacement',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      // This must be edited later ! 
      home: new LoginPage(),
    );
  }
}