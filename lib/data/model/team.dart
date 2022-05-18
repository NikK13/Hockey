import 'package:hockey/data/model/player.dart';
import 'package:hockey/main.dart';

class Team{
  int? id;
  String? leagueName;
  String? teamName;
  String? country;
  double? budget;
  String? arena;
  int? capacity;
  int? farmId;
  String? conference;
  String? division;
  String? abbreviation;
  String? color;
  String? emblem;

  Team({
    this.id,
    this.leagueName,
    this.teamName,
    this.country,
    this.budget,
    this.arena,
    this.farmId,
    this.capacity,
    this.conference,
    this.division,
    this.abbreviation,
    this.color,
    this.emblem
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "league_name": leagueName,
    "team_name": teamName,
    "country": country,
    "budget": budget,
    "arena": arena,
    "capacity": capacity,
    "farm_id": farmId,
    "conference": conference,
    "division": division,
    "abbreviation": abbreviation,
    "color": color,
    "emblem": emblem
  };

  factory Team.fromJson(Map<String, dynamic> json){
    return Team(
      id: int.parse(json['id'].toString()),
      leagueName: json['league_name'],
      teamName: json['team_name'],
      country: json['country'],
      budget: double.parse(json['budget'].toString()),
      arena: json['arena'],
      farmId: json['farm_id'] == null ?
      null : int.parse(json['farm_id'].toString()),
      capacity: int.parse(json['capacity'].toString()),
      conference: json['conference'],
      division: json['division'],
      abbreviation: json['abbreviation'],
      color: json['color'],
      emblem: json['emblem']
    );
  }

  Future<List<Player>> get teamPlayers async{
    return await databaseBloc.fetchPlayersFromTeam(id ?? 1);
  }
}