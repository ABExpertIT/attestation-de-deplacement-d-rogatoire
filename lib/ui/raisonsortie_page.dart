//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:attestation/ui/Qrpage.dart';
import 'package:attestation/ui/webview.dart';
//while testing
import 'package:attestation/ui/test_webview.dart';
import 'package:attestation/ui/utils.dart';
import 'package:getflutter/getflutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class SecondPage extends StatefulWidget {
  String name, bday, bplace, adresse;
  SecondPage({Key key, this.name, this.bday, this.bplace, this.adresse})
      : super(key: key);
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  String name, bday, bplace, adresse;
  DateTime now = new DateTime.now();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    name = widget.name;
    bday = widget.bday;
    bplace = widget.bplace;
    adresse = widget.adresse;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Attestation de déplacement'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue[100],
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.assignment),
                text: 'Restez informé',
              ),
              Tab(
                icon: Icon(Icons.info),
                text: 'Attestation',
              ),
            ]),
      ),

      /// old buttom navigation bar ends here
      body: TabBarView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Situation de covid19 en France et dans le monde",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 13,
                        fontFamily: "WorkSansLight"),
                  )),
              Expanded(flex: 1, child: _stats(context)),
            ],
          ),
          Column(
            children: <Widget>[
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
        ],
        controller: _tabController,
      ),
    );
  }
  // Alert custom images
// Alert custom content

  _onAlertWithCustomContentPressed(
      context, int card_number, String date, String time) {
    Alert(
        context: context,
        title: '',
        content: Column(
          children: <Widget>[
            Icon(
              IconData(list_raison[card_number].icon,
                  fontFamily: 'MaterialIcons'),
              size: 50,
              color: Colors.teal,
            ),

            Text(list_raison[card_number].reason),
            Divider(
              color: Colors.black,
            ),
            //Text('\n'),
            Row(
              children: <Widget>[
                Text.rich(TextSpan(
                  //text: 'Hello', // default text style
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.calendar_today),
                    ),
                    TextSpan(
                        text: '\t\t\t\t\t$date\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    WidgetSpan(
                      child: Icon(Icons.alarm),
                    ),
                    TextSpan(
                        text: '\t\t\t\t\t$time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ))
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            width: 100,
            color: Colors.teal,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: MainScreen(
                    name: name,
                    bday: bday,
                    bplace: bplace,
                    adresse: adresse,
                    date: date,
                    time: time,
                    reason: list_raison[card_number].reason,
                  ),
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
    return FutureBuilder<List<Data>>(
      future: getdata(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          final List<Info> info = [
            Info(
                "Infectés", // title
                snapshot.data[0].infected, //fr_infected
                snapshot.data[0].infected_today, //fr_infected_today
                snapshot.data[0].active_cases, //fr_active_cases
                snapshot.data[1].infected, //wr_infected
                snapshot.data[1].infected_today, //wr_infected_today
                snapshot.data[1].active_cases // wr_actrive_cases

                ),
            Info("Guéris", snapshot.data[0].cured, snapshot.data[1].cured, "",
                "", "", ""),
            Info(
                "Dècés",
                snapshot.data[0].passed_away,
                snapshot.data[0].passed_away_today,
                snapshot.data[1].passed_away,
                snapshot.data[1].passed_away_today,
                "",
                "")
          ];
          //print(snapshot.data);
          children = <Widget>[
            GFCarousel(
              //rowCount: 3,
              enlargeMainPage: true,
              //pagination: true,
              passiveIndicator: Colors.teal,
              items: info.map(
                (element) {
                  return infoCard(
                      element.title, // "infectes" or "gueries" or "deces"
                      element.fr_data1, //fr_infected
                      element.fr_data2, //fr_infected_today
                      element.fr_data3, //fr_active_cases
                      element.wr_data1,
                      element.wr_data2,
                      element.wr_data3,
                      context);
                },
              ).toList(),
            ),
            /*
            Container(
                width: 380.0,
                height: 499.0,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 0,
                    ),
                    child: Row(
                      children: <Widget>[
                        infoCard("Infectés", snapshot.data.infected, context),
                        infoCard("Guéris", snapshot.data.cured, context),
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
                        infoCard("Dècés", snapshot.data.passed_away, context)
                      ],
                    ),
                  ),
                ])) */
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
              child: Text('Merci de patienter ...'),
            ),
          ];
        }
        children.add(
          Column(
            children: <Widget>[
              Text(" "),
              Text(
                "mises à jour de la presse",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                    fontFamily: "WorkSansLight"),
              ),
              newsCard(list_source[0]),
              newsCard(list_source[1]),
              newsCard(list_source[2])
            ],
          ),
        );
        return Container(
          width: 400.0,
          height: 515.0,
          child : Center(
          child: Column(   
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
        );
        
      },
    );
  }

  Widget _raison_sortie(BuildContext context) {
    String name = widget.name;
    return Container(
        padding: EdgeInsets.only(top: 5.0),
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
                      Colors.black45,
                    ),
                    colorCard("Acheter à manger/médicaments", 59476, 2, context,
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
                      "Aller chez le médecin",
                      58696,
                      3,
                      context,
                      Colors.black45,
                    ),
                    colorCard("Aider des personnes agées/handicapées/enfants ",
                        59700, 4, context, Colors.black45),
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
                    colorCard("Convocation par une administration", 59615, 6,
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
        ));
  }

  double screenAwareSize(double size, BuildContext context) {
    const double baseHeight = 650.0;
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  // card code : each card (reason) will have a unique number. This number will help later to idetify it and adapt the details screen !
  Widget colorCard(String text, int icon_code, int card_number,
      BuildContext context, Color color) {
    String date = new DateFormat("dd-MM-yyyy").format(now);
    String time = new DateFormat("H:m").format(now);
    final _media = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          _onAlertWithCustomContentPressed(context, card_number, date, time);
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
  // card to display information and updates from the stats API

  Widget infoCard(
      String title,
      String fr_data1,
      String fr_data2,
      String fr_data3,
      String wr_data1,
      String wr_data2,
      String wr_data3,
      BuildContext context) {
    final _media = MediaQuery.of(context).size;
    Color color;
    String title_2 = " ";
    String text_today = "";
    //print(title);
    //print ("data1 : " + data1);
    //print ("data2 : " + data2);
    if (title == "Infectés") {
      color = Colors.red[300];
      title_2 = "Cas actifs";
      text_today = "Aujourd\'hui( -- )";
      return Container(
        margin: EdgeInsets.only(top: 18, right: 12),
        padding: EdgeInsets.all(25),
        height: screenAwareSize(1, context),
        width: _media.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(17),
          image: DecorationImage(
            image: new AssetImage('assets/img/corona.png'),
            fit: BoxFit.cover,
          ),
          //fir : BoxFit.cover,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // france data goes here !
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "France",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fr_data1,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Aujourd\'hui :",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "+${fr_data2}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            //GFBadge(
                              //onPressed: () {},
                              //color: Colors.black,
                              //child: Text("+ ${fr_data2}"),
                            //),
                          ],
                        ),
                        Text(
                          "Cas actifs :  ${fr_data3} \n ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ]),

            // global - world - data goes here

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Monde",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          wr_data1,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Aujourd\'hui : + ${wr_data2} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Cas actifs :  ${wr_data3} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ])
          ],
        ),
      );
    } else if (title == "Guéris") {
      color = Colors.teal[300];
      return Container(
        margin: EdgeInsets.only(top: 18, right: 12),
        padding: EdgeInsets.all(25),
        height: screenAwareSize(1, context),
        width: _media.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(17),
          image: DecorationImage(
            image: new AssetImage('assets/img/corona_cured.png'),
            fit: BoxFit.cover,
          ),
          //fir : BoxFit.cover,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // france data goes here !
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "France",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${fr_data1} ",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),

            // global - world - data goes here

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Monde",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${fr_data2} ",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])
          ],
        ),
      );
    } else {
      color = Colors.black45;
      return Container(
        margin: EdgeInsets.only(top: 18, right: 12),
        padding: EdgeInsets.all(25),
        height: screenAwareSize(1, context),
        width: _media.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(17),
          image: DecorationImage(
            image: new AssetImage('assets/img/corona.png'),
            fit: BoxFit.cover,
          ),
          //fir : BoxFit.cover,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // france data goes here !
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "France",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fr_data1,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Aujourd\'hui : + ${fr_data2} \n",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ]),

            // global - world - data goes here

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Monde",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        //fontWeight: FontWeight.w500,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fr_data3,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Aujourd\'hui : + ${wr_data1} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ])
          ],
        ),
      );
    }
  }

  // the info card for the press datra
  Widget newsCard(Source s) {
    // you can simple remove the gesture detector and use the on tap property in listTile
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WebViewSource(url: s.url,)));
      },
      child: Card(
        child: ListTile(
          leading: Image.network(
            s.image_url,
          ),
          title: Text(s.title),
          subtitle: Text(s.description),
          //trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
