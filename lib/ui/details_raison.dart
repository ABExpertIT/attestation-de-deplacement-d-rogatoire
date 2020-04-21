import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:certificate_app/style/theme.dart' as Theme;
import 'package:certificate_app/utils/bubble_indication_painter.dart';
import 'package:certificate_app/ui/colors.dart';
import 'package:certificate_app/ui/Qrpage.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class Raison {
  int icon;
  String  text;
  String more_text;
  Raison(this.icon,this.text,this.more_text);
}

List<Raison> list_raison = [Raison(0, 'Title', 'more details'),
Raison(59640, 'Je dois aller travailler', ''),
Raison(59476, 'Je vais acheter à manger ou des médicaments', 'La durée de votre déplacement ne doit pas dépasser 1h'),
Raison(58696, 'Je dois aller chez le médecin', ''),
Raison(59700, 'Je dois aller aider des gens agés, handicapés ou garder des enfants', ''),
Raison(58726, 'Je dois aller courir seul ou promener mon chien', 'La durée de votre déplacement ne doit pas dépasser 1h'),
Raison(59615, 'Je suis convoqué(e) par une administration ou la justice', ''),
Raison(58826, 'Je fais une mission utile à tous sur demande de l\'administration', '')
];

class DetailsPage extends StatefulWidget {
  int card_number ;
  String name,bday,bplace,adresse;
  DetailsPage({Key key, this.card_number,this.name,this.bplace,this.bday,this.adresse}) : super(key: key);

  @override
  _DetailsPageState createState() => new _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    //this variable will come from the previous screen !
    var card_number = widget.card_number;
    //var icon_code = 58696;
    print(card_number);

    return new Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
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
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
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
                    padding: EdgeInsets.only(top: 80.0),
                    child: Text(
                      "Je me déplace parce que : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "WorkSansBold"),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      "Selectioner la raison de votre déplacement",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "WorkSansLight"),
                    )),
                Expanded(
                    flex: 2,
                    child: _buildSignIn(context, card_number)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context, int card_number) {
    //DateTime date = new DateTime(now.year, now.month, now.day).toLocal();
    String date =new DateFormat("dd-MM-yyyy").format(now);
    String time = new DateFormat("H:m").format(now);
    String reason = list_raison[card_number].text;
    String text = reason +'\n';
    return Container(
      padding: EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 380.0,
                  height: 400.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                            left:20,
                            top: 20,
                          ),
                          child: Center(
                            child: Icon(
                              IconData(list_raison[card_number].icon, fontFamily: 'MaterialIcons'),
                              size: 90,
                              color: Colors.blue,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Text.rich(
                            TextSpan(
                              //text: 'Hello', // default text style
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                       text,
                                    style: TextStyle(fontSize: 20)),
                                TextSpan(
                                    text: 'Date : $date\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: ' Heure : $time',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          )
                          /*
                        Text(
                              "Votre déplacement est pour aller voir votre médecin. \n La date est : $now  \n L'heur de votre déplacement: ",
                              style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              ),
                              ), */

                          ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 380.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Confirmer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen(
                          name: widget.name,
                          bday: widget.bday,
                          bplace: widget.bplace,
                          adresse: widget.adresse,
                          reason: reason,
                          date: date,
                          time: time,
                        )))
                    //showInSnackBar("SignUp button pressed")),
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
