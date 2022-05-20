import 'dart:math';

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
  int? curLine;
  String? conference;
  String? division;
  String? abbreviation;
  String? color;
  String? emblem;
  List<Player>? roster;

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
    this.curLine,
    this.abbreviation,
    this.color,
    this.emblem,
    this.roster
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

  List<Player> getLineUp(List<Player> players, int line){
    if(line == 1){
      return [
        players.firstWhere((pl) => pl.teamPosition == 0),
        players.firstWhere((pl) => pl.teamPosition == 1),
        players.firstWhere((pl) => pl.teamPosition == 2),
        players.firstWhere((pl) => pl.teamPosition == 12),
        players.firstWhere((pl) => pl.teamPosition == 13)
      ];
    }
    if(line == 2){
      return [
        players.firstWhere((pl) => pl.teamPosition == 3),
        players.firstWhere((pl) => pl.teamPosition == 4),
        players.firstWhere((pl) => pl.teamPosition == 5),
        players.firstWhere((pl) => pl.teamPosition == 14),
        players.firstWhere((pl) => pl.teamPosition == 15)
      ];
    }
    if(line == 3){
      return [
        players.firstWhere((pl) => pl.teamPosition == 6),
        players.firstWhere((pl) => pl.teamPosition == 7),
        players.firstWhere((pl) => pl.teamPosition == 8),
        players.firstWhere((pl) => pl.teamPosition == 16),
        players.firstWhere((pl) => pl.teamPosition == 17)
      ];
    }
    else{
      final ld = 12 + Random().nextInt(2);
      final rd = 15 + Random().nextInt(2);
      return [
        players.firstWhere((pl) => pl.teamPosition == 9),
        players.firstWhere((pl) => pl.teamPosition == 10),
        players.firstWhere((pl) => pl.teamPosition == 11),
        players.firstWhere((pl) => pl.teamPosition == ld),
        players.firstWhere((pl) => pl.teamPosition == rd)
      ];
    }
  }
}