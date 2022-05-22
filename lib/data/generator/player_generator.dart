import 'dart:math';
import 'package:intl/intl.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/names.dart';

class PlayerGenerator{
  static List<Player> generatedInitPlayers(Team team){
    List<Player> players = [];
    List<int> positions = [for(var i = 0; i <= 23; i++) i];
    positions.shuffle();
    for(int i = 0; i <= 23; i++){
      final pos = positions[i];
      final nat = nations[0 + Random().nextInt(nations.length - 1)];
      players.add(
        createdPlayer(
          team,
          nat,
          i, pos
        )
      );
    }
    return players;
  }

  static List<Nationality> nations = [
    Nationality.canada, Nationality.canada,
    Nationality.usa, Nationality.finland,
    Nationality.austria, Nationality.belarus,
    Nationality.usa, Nationality.canada,
    Nationality.finland, Nationality.canada,
    Nationality.czech, Nationality.denmark,
    Nationality.sweden, Nationality.canada,
    Nationality.usa, Nationality.canada,
    Nationality.finland, Nationality.germany,
    Nationality.usa, Nationality.canada,
    Nationality.usa, Nationality.canada,
    Nationality.usa, Nationality.sweden,
    Nationality.usa, Nationality.canada,
    Nationality.france, Nationality.latvia,
    Nationality.norway, Nationality.russia,
    Nationality.usa, Nationality.usa,
    Nationality.canada, Nationality.usa,
    Nationality.switzerland, Nationality.sweden,
    Nationality.usa, Nationality.usa,
    Nationality.slovakia, Nationality.slovenia,
    Nationality.finland, Nationality.canada,
    Nationality.usa, Nationality.usa,
    Nationality.usa, Nationality.canada,
    Nationality.finland, Nationality.canada,
    Nationality.canada, Nationality.sweden,
  ];

  static Player createdPlayer(Team team, Nationality nation, int index, int pos){
    final namesList = PlayerNames.getNamesByNation(nation);
    final surnamesList = PlayerNames.getSurnamesByNation(nation);
    return Player(
      id: index,
      teamId: team.id,
      salary: 0.65 + Random().nextDouble(),
      firstName: namesList[Random().nextInt(namesList.length - 1)],
      lastName: surnamesList[Random().nextInt(surnamesList.length - 1)],
      teamPosition: pos,
      position: getPosByTeam(pos),
      age: 18 + Random().nextInt(16),
      skill: getSkillFromLeagueAndPos(team.leagueName!, pos),
      nationality: nation,
      expiryContract: DateFormat('dd/MM/yyyy').parse("29/06/${2023 + Random().nextInt(3)}"),
      jerseyNum: 1 + Random().nextInt(98),
      isAfro: canBeAfro(nation) ? isAfro(0 + Random().nextInt(10)) : false
    );
  }

  static String? getPosByTeam(int pos){
    if(pos == 0 || pos == 3 || pos == 6 || pos == 9){
      return "lw";
    }
    if(pos == 1 || pos == 4 || pos == 7 || pos == 10){
      return "cf";
    }
    if(pos == 2 || pos == 5 || pos == 8 || pos == 11){
      return "rw";
    }
    if(pos == 12 || pos == 14 || pos == 16){
      return "ld";
    }
    if(pos == 13 || pos == 15 || pos == 17){
      return "rd";
    }
    if(pos == 18 || pos == 19){
      return "gk";
    }
    else{
      return poses[0 + Random().nextInt(poses.length)];
    }
  }

  static List<String> get poses => ["lw", "cf", "rw", "rd", "ld", "gk"];

  static int? getSkillFromLeagueAndPos(String leagueName, int teamPos){
    switch(leagueName){
      case "NHL":
        return skillFromNHLPos(teamPos);
      case "AHL":
        return skillFromAHLPos(teamPos);
      default:
        return skillFromAHLPos(teamPos);
    }
  }

  static int? skillFromNHLPos(int teamPos){
    if(teamPos.isBetween(0, 2)){
      return 83 + Random().nextInt(4);
    }
    else if(teamPos.isBetween(3, 5)){
      return 81 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(6, 8)){
      return 79 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(9, 11)){
      return 78 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(12, 13)){
      return 82 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(14, 15)){
      return 80 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(16, 17)){
      return 79 + Random().nextInt(1);
    }
    else if(teamPos == 18){
      return 82 + Random().nextInt(5);
    }
    else if(teamPos == 19){
      return 80 + Random().nextInt(2);
    }
    else{
      return 77 + Random().nextInt(2);
    }
  }

  static bool isAfro(int i){
    if(i == 4){
      return true;
    }
    return false;
  }

  static int? skillFromAHLPos(int teamPos){
    if(teamPos.isBetween(0, 2)){
      return 77 + Random().nextInt(1);
    }
    else if(teamPos.isBetween(3, 5)){
      return 74 + Random().nextInt(3);
    }
    else if(teamPos.isBetween(6, 8)){
      return 71 + Random().nextInt(3);
    }
    else if(teamPos.isBetween(9, 11)){
      return 69 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(12, 13)){
      return 75 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(14, 15)){
      return 73 + Random().nextInt(2);
    }
    else if(teamPos.isBetween(16, 17)){
      return 71 + Random().nextInt(2);
    }
    else if(teamPos == 18){
      return 74 + Random().nextInt(4);
    }
    else if(teamPos == 19){
      return 71 + Random().nextInt(4);
    }
    else{
      return 69 + Random().nextInt(5);
    }
  }

  static bool canBeAfro(Nationality nationality){
    if(nationality == Nationality.canada || nationality == Nationality.usa){
      return true;
    }
    return false;
  }
}