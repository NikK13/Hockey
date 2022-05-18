class Player{
  int? id;
  int? teamId;
  double? salary;
  String? firstName;
  String? lastName;
  int? teamPosition;
  int? age;
  int? skill;
  String? position;
  Nationality? nationality;
  DateTime? expiryContract;
  int? jerseyNum;
  bool? isAfro;

  Player({
    this.id,
    this.teamId,
    this.salary,
    this.firstName,
    this.lastName,
    this.teamPosition,
    this.age,
    this.skill,
    this.nationality,
    this.expiryContract,
    this.jerseyNum,
    this.position,
    this.isAfro,
  });

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
      id: int.parse(json['id'].toString()),
      teamId: json['team_id'],
      salary: double.parse(double.parse(json['salary'].toString()).toStringAsFixed(2)),
      firstName: json['first_name'],
      lastName: json['last_name'],
      teamPosition: json['team_position'],
      age: json['age'],
      skill: json['skill'],
      position: json['position'],
      nationality: getNationalityByCountry(json['nationality']),
      expiryContract: DateTime.parse(json['contract']),
      jerseyNum: json['jersey_num'],
      isAfro: json['is_afro'] == "true" ? true : false
    );
  }

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "salary": salary,
    "first_name": firstName,
    "last_name": lastName,
    "team_position": teamPosition,
    "age": age,
    "skill": skill,
    "position": position,
    "nationality": getCountryByNationality(nationality!),
    "contract": expiryContract.toString(),
    "jersey_num": jerseyNum,
    "is_afro": isAfro! ? "true" : "false"
  };

  static String getFlagByNationality(Nationality nation){
    switch(nation){
      case Nationality.austria:
        return "assets/images/austria.png";
      case Nationality.belarus:
        return "assets/images/belarus.png";
      case Nationality.canada:
        return "assets/images/canada.png";
      case Nationality.czech:
        return "assets/images/czech.png";
      case Nationality.denmark:
        return "assets/images/denmark.png";
      case Nationality.finland:
        return "assets/images/finland.png";
      case Nationality.france:
        return "assets/images/france.png";
      case Nationality.germany:
        return "assets/images/germany.png";
      case Nationality.latvia:
        return "assets/images/latvia.png";
      case Nationality.norway:
        return "assets/images/norway.png";
      case Nationality.russia:
        return "assets/images/russia.png";
      case Nationality.slovakia:
        return "assets/images/slovakia.png";
      case Nationality.slovenia:
        return "assets/images/slovenia.png";
      case Nationality.sweden:
        return "assets/images/sweden.png";
      case Nationality.switzerland:
        return "assets/images/switzerland.png";
      case Nationality.usa:
        return "assets/images/usa.png";
    }
  }

  static String getCountryByNationality(Nationality nation){
    switch(nation){
      case Nationality.austria:
        return "AUS";
      case Nationality.belarus:
        return "BLR";
      case Nationality.canada:
        return "CAN";
      case Nationality.czech:
        return "CZE";
      case Nationality.denmark:
        return "DEN";
      case Nationality.finland:
        return "FIN";
      case Nationality.france:
        return "FRA";
      case Nationality.germany:
        return "GER";
      case Nationality.latvia:
        return "LTV";
      case Nationality.norway:
        return "NOR";
      case Nationality.russia:
        return "RUS";
      case Nationality.slovakia:
        return "SLV";
      case Nationality.slovenia:
        return "SLO";
      case Nationality.sweden:
        return "SWE";
      case Nationality.switzerland:
        return "SWI";
      case Nationality.usa:
        return "USA";
    }
  }

  static Nationality? getNationalityByCountry(String country){
    switch(country){
      case "AUS":
        return Nationality.austria;
      case "BLR":
        return Nationality.belarus;
      case "CAN":
        return Nationality.canada;
      case "CZE":
        return Nationality.czech;
      case "DEN":
        return Nationality.denmark;
      case "FIN":
        return Nationality.finland;
      case "FRA":
        return Nationality.france;
      case "GER":
        return Nationality.germany;
      case "LTV":
        return Nationality.latvia;
      case "NOR":
        return Nationality.norway;
      case "RUS":
        return Nationality.russia;
      case "SLV":
        return Nationality.slovakia;
      case "SLO":
        return Nationality.slovenia;
      case "SWE":
        return Nationality.sweden;
      case "SWI":
        return Nationality.switzerland;
      case "USA":
        return Nationality.usa;
      default:
        return Nationality.usa;
    }
  }
}

enum Nationality{
  austria,
  belarus,
  canada,
  czech,
  denmark,
  finland,
  france,
  germany,
  latvia,
  norway,
  russia,
  slovakia,
  slovenia,
  sweden,
  switzerland,
  usa
}
