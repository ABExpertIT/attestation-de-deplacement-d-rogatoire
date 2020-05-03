
import 'dart:convert';
import 'package:http/http.dart' as http;

class Info {
  String title;
  String fr_data1; //fr_infected
  String fr_data2; // fr_infected_today
  String fr_data3; //fr_active_cases
  String wr_data1; //wr_infected
  String wr_data2; //wr_infected_today
  String wr_data3; //wr_active_cases
  Info(
    this.title, 
    this.fr_data1, 
    this.fr_data2, 
    this.fr_data3,
    this.wr_data1, 
    this.wr_data2, 
    this.wr_data3
    );
}

class Data {
  final String infected;
  final String infected_today;
  final String active_cases;
  final String cured;
  final String passed_away;
  final String passed_away_today;
  Data(
      {this.infected,
      this.infected_today,
      this.active_cases,
      this.cured,
      this.passed_away,
      this.passed_away_today});
  /*
  Data.empty(){
    infected = "";
    cured = "";
    passed_away ="";
  } */
  factory Data.fromJson_fr(Map<String, dynamic> json) {
    return Data(
      infected: json['countrydata'][0]['total_cases'].toString(),
      infected_today:json['countrydata'][0]['total_new_cases_today'].toString(),
      active_cases: json['countrydata'][0]['total_active_cases'].toString(),
      cured: json['countrydata'][0]['total_recovered'].toString(),
      passed_away: json['countrydata'][0]['total_deaths'].toString(),
      passed_away_today:
          json['countrydata'][0]['total_new_deaths_today'].toString(),
    );
  }
    factory Data.fromJson_monde(Map<String, dynamic> json) {
    return Data(
      infected: json['results'][0]['total_cases'].toString(),
      infected_today:json['results'][0]['total_new_cases_today'].toString(),
      active_cases: json['results'][0]['total_active_cases'].toString(),
      cured: json['results'][0]['total_recovered'].toString(),
      passed_away: json['results'][0]['total_deaths'].toString(),
      passed_away_today:
          json['results'][0]['total_new_deaths_today'].toString(),
    );
  }
}

Future<List<Data>> getdata() async {
  String url_france = "https://api.thevirustracker.com/free-api?countryTotal=FR";
  String url_monde = "https://api.thevirustracker.com/free-api?global=stats";
  List<Data> res = [];
  final response_fr = await http.get(url_france);
  final response_monde = await http.get(url_monde);
  if (response_fr.statusCode == 200 && response_monde.statusCode == 200) {
    Data data_france = Data.fromJson_fr(json.decode(response_fr.body));
    Data data_monde = Data.fromJson_monde(json.decode(response_monde.body));
    res.add(data_france); // add fr data to the list
    res.add(data_monde); // add global data to the list
    return res; // return a list of <Data>
  }
}

class Raison {
  int icon;
  String reason;
  String details;
  Raison(this.icon, this.reason, this.details);
}

List<Raison> list_raison = [
  Raison(0, 'Title', 'more details'),
  Raison(59640, 'Je dois aller travailler', ''),
  Raison(59476, 'Je vais acheter à manger ou des médicaments',
      'La durée de votre déplacement ne doit pas dépasser 1h'),
  Raison(58696, 'Je dois aller chez le médecin', ''),
  Raison(
      59700,
      'Je dois aller aider des personnes agées, handicapés ou garder des enfants',
      ''),
  Raison(58726, 'Je dois aller courir seul ou promener mon chien',
      'La durée de votre déplacement ne doit pas dépasser 1h'),
  Raison(59615, 'Je suis convoqué(e) par une administration ou la justice', ''),
  Raison(58826,
      'Je fais une mission utile à tous sur demande de l\'administration', '')
];

class Sortie {
  String name;
  String bday;
  String bplace;
  String adresse;
  String reason;
  String date;
  String time;
  Sortie(this.name, this.bday, this.bplace, this.adresse, this.reason,
      this.date, this.time);
  Map<String, dynamic> toJson() => {
        'name': name,
        'birthday': bday,
        'birth_place': bplace,
        'adresse': adresse,
        'reason': reason,
        'date': date,
        'time': time
      };
}
