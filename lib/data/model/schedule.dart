import 'dart:convert';
import 'package:flutter/material.dart';

class ScheduleMatch{
  final int? id;
  final int? homeId;
  final int? awayId;
  final int? homeScore;
  final int? awayScore;
  final String? gameDate;

  ScheduleMatch({
    this.id,
    this.homeId,
    this.awayId,
    this.gameDate,
    this.awayScore,
    this.homeScore
  });

  factory ScheduleMatch.fromJson(Map<String, dynamic> json){
    return ScheduleMatch(
      id: int.parse(json['id'].toString()),
      homeId: int.parse(json['home_id'].toString()),
      awayId: int.parse(json['away_id'].toString()),
      homeScore: int.parse(json['home_score'].toString()),
      awayScore: int.parse(json['away_score'].toString()),
      gameDate: json['game_date']
    );
  }

  Map<String, dynamic> toJson() => {
    "home_id": homeId,
    "away_id": awayId,
    "home_score": homeScore,
    "away_score": awayScore,
    "game_date": gameDate
  };

  static Future<List<ScheduleMatch>> parseTheSchedule(BuildContext context) async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/schedule.cal");
    final List<ScheduleMatch> schedule = [];
    final jsonResult = json.decode(data);
    final jsonIe = jsonResult['games'] as List;
    for(var game in jsonIe){
      if(game['title'] == null && game['status'] != "postponed"){
        var scheduled = game['scheduled'];
        var homeName = game['home']['name'];
        var awayName = game['away']['name'];
        schedule.add(ScheduleMatch(
          homeId: getIdByTeam(homeName),
          awayId: getIdByTeam(awayName),
          gameDate: scheduled,
          homeScore: 0,
          awayScore: 0
        ));
      }
    }
    return schedule;
  }

  List<GameWeek> weekGames(List<ScheduleMatch> schedule){
    final List<GameWeek> gameWeeks = [];
    if(schedule.length == 1312){
      for(int i = 0; i < 82; i++){
        final start = 16 * i;
        final end = 16 * (i + 1);
        final week = schedule.getRange(
          start, end > schedule.length ?
          schedule.length : end
        ).toList();
        gameWeeks.add(GameWeek(
          id: i,
          weekId: i + 1,
          weekMatches: week
        ));
      }
    }
    return gameWeeks;
  }

  static int getIdByTeam(String fullTeamName){
    if(fullTeamName.contains("Anaheim")){
      return 1;
    }
    if(fullTeamName.contains("Arizona")){
      return 2;
    }
    if(fullTeamName.contains("Boston")){
      return 3;
    }
    if(fullTeamName.contains("Buffalo")){
      return 4;
    }
    if(fullTeamName.contains("Calgary")){
      return 5;
    }
    if(fullTeamName.contains("Carolina")){
      return 6;
    }
    if(fullTeamName.contains("Chicago")){
      return 7;
    }
    if(fullTeamName.contains("Colorado")){
      return 8;
    }
    if(fullTeamName.contains("Columbus")){
      return 9;
    }
    if(fullTeamName.contains("Dallas")){
      return 10;
    }
    if(fullTeamName.contains("Detroit")){
      return 11;
    }
    if(fullTeamName.contains("Edmonton")){
      return 12;
    }
    if(fullTeamName.contains("Florida")){
      return 13;
    }
    if(fullTeamName.contains("Los Angeles")){
      return 14;
    }
    if(fullTeamName.contains("Minnesota")){
      return 15;
    }
    if(fullTeamName.contains("Montreal")){
      return 16;
    }
    if(fullTeamName.contains("Nashville")){
      return 17;
    }
    if(fullTeamName.contains("New Jersey")){
      return 18;
    }
    if(fullTeamName.contains("New York I")){
      return 19;
    }
    if(fullTeamName.contains("New York R")){
      return 20;
    }
    if(fullTeamName.contains("Ottawa")){
      return 21;
    }
    if(fullTeamName.contains("Philadelphia")){
      return 22;
    }
    if(fullTeamName.contains("Pittsburgh")){
      return 23;
    }
    if(fullTeamName.contains("San Jose")){
      return 24;
    }
    if(fullTeamName.contains("St. Louis")){
      return 25;
    }
    if(fullTeamName.contains("Tampa Bay")){
      return 26;
    }
    if(fullTeamName.contains("Toronto")){
      return 27;
    }
    if(fullTeamName.contains("Vancouver")){
      return 28;
    }
    if(fullTeamName.contains("Vegas")){
      return 29;
    }
    if(fullTeamName.contains("Washington")){
      return 30;
    }
    if(fullTeamName.contains("Winnipeg")){
      return 31;
    }
    if(fullTeamName.contains("Seattle")){
      return 32;
    }
    else{
      return 0;
    }
  }
}

class GameWeek{
  int? id;
  int? weekId;
  List<ScheduleMatch>? weekMatches;

  GameWeek({this.id, this.weekId, this.weekMatches});
}