import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:certificate_app/style/theme.dart' as Theme;
import 'package:certificate_app/utils/bubble_indication_painter.dart';
import 'package:certificate_app/ui/colors.dart';
import 'package:certificate_app/ui/Qrpage.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => new _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    //this variable will come from the previous screen !
    var card_number = 2;
    var icon_code = 58696;

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
                    child: _buildSignIn(context, card_number, icon_code)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context, int card_number, int icon_code) {

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
                            left: 20,
                            top: 20,
                          ),
                          child: Center(
                            child: Icon(
                              IconData(icon_code, fontFamily: 'MaterialIcons'),
                              size: 90,
                              color: Colors.blue,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 0,
                          ),
                          child: Text.rich(
                            TextSpan(
                              //text: 'Hello', // default text style
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Votre déplacement est pour aller voir votre médecin.\n ',
                                    style: TextStyle(fontSize: 20)),
                                TextSpan(
                                    text: 'Date : $day/$month/$year\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: ' Heure : $hour:$min',
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
            ],
          ),
        ],
      ),
    );
  }
}
