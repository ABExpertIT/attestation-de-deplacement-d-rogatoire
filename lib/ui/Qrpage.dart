import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// the classe ofor the reason of going out ! 
class Sortie {
  String name;
  String  bday;
  String bplace;
  String adresse;
  String reason;
  String date;
  String time;
  Sortie(this.name,this.bday,this.bplace,this.adresse,this.reason,this.date,this.time);
   Map<String, dynamic> toJson() =>
    {
      'name': name,
      'birthday': bday,
      'birth_place' : bplace,
      'adresse':adresse,
      'reason': reason,
      'date':date,
      'time':time
    };
}
class MainScreen extends StatefulWidget {
  String name,bday,bplace,adresse,reason,date,time;
   MainScreen({Key key,this.name,this.bday,this.bplace,this.adresse,this.reason,this.date,this.time}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}
/*
generateqrcode(Sortie sortie){
    String message = jsonEncode(sortie);
    
  }
*/
class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    //data to put in the Qr code ! 
    Sortie s = Sortie(widget.name, widget.bday,widget.bplace,widget.adresse,widget.reason,widget.date,widget.time);
    final sortie =jsonEncode(s);
  // Qr future builder ! 
    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data:  sortie,
            version: QrVersions.auto,
            // size: 320.0,
          ),
        );
      },
    );

    return new Scaffold(
       appBar: AppBar(      
            title: Text('Attestation de déplacement'),
            backgroundColor: Colors.teal,
          ),
          body:  
          Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text('')),
              Container(
                      color: Colors.transparent,
                      width: 350,
                      height: 100,
                      
                      child: Card(                          
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text('Qr code'),
                          subtitle: Text('\nVous devez présenter ce QR-Code en cas de contrôle'),
                          )
                      ],
                    ),
                  ),

                    ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    child: qrFutureBuilder,
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    )
   ,

    );
    
    
  
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    //add an image to display on the top of the QRcode
    final byteData = await rootBundle.load('');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}