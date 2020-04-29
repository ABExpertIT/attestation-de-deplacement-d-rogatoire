//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:attestation/ui/Qrpage.dart';
//import 'package:attestation/ui/details_raison.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String infected;
  final String cured;
  final String passed_away;
  Data({this.infected,this.cured,this.passed_away});
  /*
  Data.empty(){
    infected = "";
    cured = "";
    passed_away ="";
  } */
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data( infected: json['countrydata'][0]['total_cases'].toString(),
    cured: json['countrydata'][0]['total_recovered'].toString(),
    passed_away: json['countrydata'][0]['total_deaths'].toString(),);
  }

}

Future <Data> getdata() async{
  String url = "https://api.thevirustracker.com/free-api?countryTotal=FR";
  final response = await http.get(url);
  if (response.statusCode == 200){
      Data d =  Data.fromJson(json.decode(response.body));
      return d;  
  } 
}

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
Raison(59700, 'Je dois aller aider des personnes agées, handicapés ou garder des enfants', ''),
Raison(58726, 'Je dois aller courir seul ou promener mon chien', 'La durée de votre déplacement ne doit pas dépasser 1h'),
Raison(59615, 'Je suis convoqué(e) par une administration ou la justice', ''),
Raison(58826, 'Je fais une mission utile à tous sur demande de l\'administration', '')
];
class SecondPage extends StatefulWidget {
  String name,bday,bplace,adresse;
  SecondPage({Key key,this.name,this.bday,this.bplace,this.adresse}) : super(key: key);
  @override
  _SecondPageState createState() => new _SecondPageState();
}


class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
      String name,bday,bplace,adresse;
      DateTime now = new DateTime.now();
      TabController _tabController;

@override
void initState() {
  super.initState();
  _tabController = new TabController(length: 2, vsync: this);
}

  @override
  Widget build(BuildContext context) {
    name = widget.name;bday =  widget.bday;bplace =  widget.bplace;adresse = widget.adresse;
    return new Scaffold(
            appBar: AppBar(      
            title: Text('Attestation de déplacement'),
            backgroundColor: Colors.teal,
          ),
      bottomNavigationBar: 
      Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue[100],
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.assignment),
                text: 'Attestation',
              ),
              Tab(
                icon: Icon(Icons.info),
                text: 'Restez informé',
              ),
            ]),
      ),

      /// old buttom navigation bar ends here 
      body: TabBarView(
          children: <Widget>[
            Column(
              children : <Widget>[
                   Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Veillez selectioner la raison de votre déplacement ! ",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                            fontFamily: "WorkSansLight"),
                      )),
                      Expanded(flex: 1, child: _raison_sortie(context)),
                ],
            ),
               Column(
              children : <Widget>[
                   Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Restez informé",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                            fontFamily: "WorkSansLight"),
                      )),
                      Expanded(flex: 1, child: _stats(context)),
                ],
            ),
           
          ],
          controller: _tabController,
        ),
    );
  }
  // Alert custom images
// Alert custom content

  _onAlertWithCustomContentPressed(context,int card_number,String date,String time) {
    Alert(
        context: context,
        title: '',
        content: Column(
          children: <Widget>[
           
                Icon(
                IconData(list_raison[card_number].icon, fontFamily: 'MaterialIcons'),
                size: 50,
                color: Colors.teal,
                ),
                
                Text(list_raison[card_number].text),
                Divider(
                  color: Colors.black,
                ),
                //Text('\n'),
           Row(
             children: <Widget>[
               Text.rich(
                   TextSpan(
                              //text: 'Hello', // default text style
                              children:[
                                WidgetSpan(
                                  child: Icon(Icons.calendar_today), 
                                ),
                                TextSpan(
                                    text: '\t\t\t\t\t$date\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                WidgetSpan(
                                  child: Icon(Icons.alarm), 
                                ),
                                TextSpan(
                                    text: '\t\t\t\t\t$time',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            )
               )
             ],
           )
          ],
        ),  
        buttons: [
          DialogButton(
            width:100,
            color: Colors.teal,
            onPressed: () {
            Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: MainScreen(
                      name: name,bday: bday,bplace: bplace,adresse: adresse,date: date,time: time,reason: list_raison[card_number].text,
                       ) ,
                    ),
                  );
            //additional stuff can be add here 
            // like sending the data to  external data base

            },
            child: Text(
              "Confirmer",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
        }
  //the news didget here : 
//swiper news starts here : 

//swiper news ends here : 

Widget _stats(BuildContext context) {
  return FutureBuilder<Data>(
    future: getdata(), // a previously-obtained Future<String> or null
    builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        print(snapshot.data);
        children = <Widget>[
                 Container(
                  width: 380.0,
                  height: 499.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 0,
                        ),
                        child: Row(
                          children: <Widget>[
                            infoCard("Total infecté",snapshot.data.infected,context,Colors.red[300],),
                            infoCard("Total guéris", snapshot.data.cured,context, Colors.teal[300]),
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
                            infoCard( "Dècés", snapshot.data.passed_away,context,Colors.black45,)
                          ],
                        ),
                      ),
                      
                    ]
                  )
                    
                
                    )

        ];
      } else if (snapshot.hasError) {
        children = <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          )
        ];
      } else {
        children = <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ];
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      );
    },
  );
}
  Widget _raison_sortie(BuildContext context) {
    String name = widget.name;
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child:  Container(
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
                              Colors.black45,
                            ),
                            colorCard("Acheter à manger/médicaments", 59476, 2,
                                context, Colors.black45),
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
                              Colors.black45,
                            ),
                            colorCard(
                                "Aider des personnes agées/handicapées/enfants ",
                                59700,
                                4,
                                context,
                                Colors.black45),
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
                              "Pratique sportive / Promener son animal de compagnie",
                              58726,
                              5,
                              context,
                              Colors.black45,
                            ),
                            colorCard("Convocation par une administration",
                                59615, 6, context, Colors.black45),
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
                              Colors.black45,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
    );
  }

  double screenAwareSize(double size, BuildContext context) {
    const double baseHeight = 650.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  // card code : each card (reason) will have a unique number. This number will help later to idetify it and adapt the details screen !
  Widget colorCard(String text, int icon_code, int card_number,BuildContext context, Color color) {
    String date =new DateFormat("dd-MM-yyyy").format(now);
    String time = new DateFormat("H:m").format(now);
    final _media = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {_onAlertWithCustomContentPressed(context,card_number,date,time);}
        ,
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
  // card to display information and updates from the stats API

    Widget infoCard(String title,String data,BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return  Container(
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
              Text(
               title,
               style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  //fontWeight: FontWeight.w500,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                data,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
  }

}
