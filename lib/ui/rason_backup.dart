import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:certificate_app/style/theme.dart' as Theme;
import 'package:certificate_app/utils/bubble_indication_painter.dart';
import 'package:certificate_app/ui/colors.dart';
import 'package:certificate_app/ui/details_raison.dart';

class SecondPage extends StatefulWidget {
  String name,bday,bplace,adresse;
  SecondPage({Key key,this.name,this.bday,this.bplace,this.adresse}) : super(key: key);
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
      String name,bday,bplace,adresse;
  @override
  Widget build(BuildContext context) {
    name = widget.name;bday =  widget.bday;bplace =  widget.bplace;adresse = widget.adresse;
    return new Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll){
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 700.0
                ? MediaQuery.of(context).size.height
                : 700.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    //Theme.Colors.loginGradientStart,
                    //Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      "Je me déplace parce que : ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontFamily: "WorkSansBold"),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      "Selectioner la raison de votre déplacement",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontFamily: "WorkSansLight"),
                    )),
                Expanded(flex: 2, child: _buildSignIn(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    String name = widget.name;
    return Container(
      padding: EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            //overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 380.0,
                  height: 515.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 0,
                        ),
                        child: Row(
                          children: <Widget>[
                            colorCard(
                              "Aller travailler",
                              59640,
                              1,
                              context,
                              Colors.blue,
                            ),
                            colorCard("Acheter à manger/médicaments", 59476, 2,
                                context, Colors.blue),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 0,
                        ),
                        child: Row(
                          children: <Widget>[
                            colorCard(
                              "Aller chez le médecin",
                              58696,
                              3,
                              context,
                              Colors.blue,
                            ),
                            colorCard(
                                "Aider des gens agés/handicapés / enfants ",
                                59700,
                                4,
                                context,
                                Colors.blue),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 0,
                        ),
                        child: Row(
                          children: <Widget>[
                            colorCard(
                              "Courir / promener mon chien",
                              58726,
                              5,
                              context,
                              Colors.blue,
                            ),
                            colorCard("Convocation par une administration",
                                59615, 6, context, Colors.blue),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 0,
                        ),
                        child: Row(
                          children: <Widget>[
                            colorCard(
                              "Mission utile sur demande",
                              58826,
                              7,
                              context,
                              Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double screenAwareSize(double size, BuildContext context) {
    const double baseHeight = 650.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  // card code : each card (reason) will have a unique number. This number will help later to idetify it and adapt the details screen !
  Widget colorCard(String text, int icon_code, int card_number,BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                  // to pass the paramettres from the login form to the object ! 
                      name : name,
                      bday : bday,
                      bplace : bplace,
                      adresse : adresse,
                      card_number: card_number,
                    )),
          );
          print(name);
        },
        child: Container(
          margin: EdgeInsets.only(top: 18, right: 12),
          padding: EdgeInsets.all(25),
          height: screenAwareSize(100, context),
          width: _media.width / 2 - 43,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Icon(
                  IconData(icon_code, fontFamily: 'MaterialIcons'),
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
