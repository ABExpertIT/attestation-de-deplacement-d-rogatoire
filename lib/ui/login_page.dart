import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:certificate_app/style/theme.dart' as Theme;
import 'package:certificate_app/ui/raisonsortie_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
//initializeDateFormatting("fr_FR", null).then((_) => runMyCode());
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeBirthDate = FocusNode();
  final FocusNode myFocusNodePlaceBirth = FocusNode();
  final FocusNode myFocusNodeAdresse = FocusNode();
  final FocusNode myFocusNodeReason = FocusNode();

  TextEditingController NameController = new TextEditingController();
  TextEditingController BirthDateController = new TextEditingController();
  TextEditingController PlaceBirthController = new TextEditingController();
  TextEditingController AdresseController = new TextEditingController();
  TextEditingController ReasonController = new TextEditingController();

  String name = '' ;
  DateTime bday = DateTime(1920);
  String bplace = '';
  String adresse = '';
  String birthdate = '';
  String test_date = '';

void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Champs obligatoire non remplis ! "),
          content: new Text("Merci de saisir correctement vos informations"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

getTextInputData(){
    setState(() {
      name = NameController.text;
      //birthdate = bday.day.toString() + '/' + bday.month.toString()+ '/' + bday.year.toString() ;
      birthdate = BirthDateController.text;
      bplace = PlaceBirthController.text;
      adresse = AdresseController.text;
      //bday = DateTime(bday.day,bday.month,bday.year);
    });
    //desactive this option for the tests
    if (name != '' && bplace != '' &&adresse!=''){
          Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SecondPage(
                      name: name,bday: birthdate,bplace: bplace,adresse: adresse,
                       ) ,
                    ),
                  );
      /*
       Navigator.push(context,MaterialPageRoute(builder: (context) => SecondPage(name: name,bday: birthdate,bplace: bplace,adresse: adresse,))); */
      print(birthdate);
    } else{
      //Navigator.push(context,MaterialPageRoute(builder: (context) => SecondPage(name: name,bday: birthdate,bplace: bplace,adresse: adresse,))); 
      /////Dialog here for error (dont forget it)
      _showDialog();
    }
    
  }

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 500.0
                    ? MediaQuery.of(context).size.height
                    : 500.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Colors.teal,
                        Colors.teal,
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
                      padding: EdgeInsets.only(top: 25.0),
                      child: new Image(
                          width: 200.0,
                          height: 141.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/img/login_logo.png')),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 350,
                      height: 100,
                      child: Card(                          
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              subtitle: Text('\t\t En application de l’article 3 du décret du 23 mars 2020 prescrivant les mesures générales nécessaires pour faire face à l’épidémie de Covid19 dans le cadre de l’état d’urgence sanitaire'),
              )
            
          ],
        ),
      ),

                    ),
                                  
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: _buildSignUp(context),
                    ),
      
                    
                  ],
                ),
              ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodeName.dispose();
    myFocusNodeBirthDate.dispose();
    myFocusNodePlaceBirth.dispose();
    myFocusNodeAdresse.dispose();
    myFocusNodeReason.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
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
                  width: 350.0,
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: NameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Nom complet",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeBirthDate,
                          controller: BirthDateController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.black,
                            ),
                            hintText: "Data de naissance",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                          onTap: () async {
                            bday = await showDatePicker(
                            context: context, 
                            initialDate:DateTime(2000),
                            firstDate:DateTime(1920),
                            lastDate: DateTime(2003)
                            ); //await finish here
                            //BirthDateController.text = DateTime(bday.day);
                            //new DateFormat('yyyy-MMMM-dd').format(bday);
                            //BirthDateController.text = bday.toString();
                            BirthDateController.text = new DateFormat('dd-MM-yyyy').format(bday).toString();
                            ErrorHint('Merci de saisir une date correcte');
                          },
                        ),
                      ),      
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePlaceBirth,
                          controller: PlaceBirthController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.locationArrow,
                              color: Colors.black,
                            ),
                            hintText: "Lieu de naissance",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeAdresse,
                          controller: AdresseController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.home,
                              color: Colors.black,
                            ),
                            hintText: "Adresse",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(1.0, 5.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Colors.teal,
                        Colors.teal
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: 
                FlatButton(
                    //highlightColor: Colors.transparent,
                    //splashColor: Colors.black,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Suivant",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      //print(bday.year);
                      getTextInputData();
                      //print(name);
                      //print(adresse);
                      //print(bday);
                     
                      
                      }
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
