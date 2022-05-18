import 'dart:async';
import 'package:hockey/data/db/constants.dart';
import 'package:hockey/data/db/database/db.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/schedule.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/extensions.dart';

class DaoOfDB {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTeam(Team item) async {
    final db = await dbProvider.database;
    var result = db!.insert(teamsTable, item.toJson());
    return result;
  }

  Future<int> createNHLMatch(ScheduleMatch item) async {
    final db = await dbProvider.database;
    var result = db!.insert(scheduleNHLTable, item.toJson());
    return result;
  }

  Future<int> createPlayer(Player item) async {
    final db = await dbProvider.database;
    var result = db!.insert(playersTable, item.toJson());
    return result;
  }

  Future<List<Team>> getAllTeams() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.query(teamsTable);
    List<Team> items = result.isNotEmpty ?
    result.map((item) => Team.fromJson(item)).toList() : [];
    return items;
  }

  Future<List<ScheduleMatch>> getAllNHLMatches() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.query(scheduleNHLTable);
    List<ScheduleMatch> items = result.isNotEmpty ?
    result.map((item) => ScheduleMatch.fromJson(item)).toList() : [];
    return items;
  }

  Future<Team> getTeam(int id) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.query(
      teamsTable,
      where: '$columnId LIKE ?',
      whereArgs: ["%$id%"]
    );
    return Team.fromJson(result.first);
  }

  Future<List<int>> getTeamPlayersSkill(int id) async {
    final List<int> skills = [];
    final List<Player> players = await getPlayersFromTeam(id);
    int att = 0, def = 0, goalie = 0;
    for(var pl in players){
      if(pl.teamPosition!.isBetween(0, 11)){
        att += pl.skill!;
      }
      if(pl.teamPosition!.isBetween(12, 17)){
        def += pl.skill!;
      }
      if(pl.teamPosition!.isBetween(18, 19)){
        goalie += pl.skill!;
      }
    }
    skills.add(att ~/ 12);
    skills.add(def ~/ 6);
    skills.add(goalie ~/ 2);
    return skills;
  }

  Future<List<Player>> getAllPlayers() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.query(playersTable);

    List<Player> items = result.isNotEmpty ?
    result.map((item) => Player.fromJson(item)).toList() : [];
    return items;
  }

  Future<List<Player>> getPlayersFromTeam(int teamId) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.rawQuery("SELECT * FROM $playersTable WHERE $columnTeamId = $teamId");
    List<Player> items = result.isNotEmpty ?
    result.map((item) => Player.fromJson(item)).toList() : [];
    items.sort((a,b) => a.teamPosition!.compareTo(b.teamPosition!));
    return items;
  }

  Future<Player> getPlayerById(int id) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    result = await db!.query(
      teamsTable,
      where: '$columnId LIKE ?',
      whereArgs: ["%$id%"]
    );
    return Player.fromJson(result.first);
  }

  Future<int> updateTeam(Team team) async {
    final db = await dbProvider.database;
    var result = await db!.update(
      teamsTable, team.toJson(),
      where: "$columnId = ?", whereArgs: [team.id]
    );
    return result;
  }

  Future<int> updatePlayer(Player player) async {
    final db = await dbProvider.database;
    var result = await db!.update(
      playersTable, player.toJson(),
      where: "$columnId = ?", whereArgs: [player.id]
    );
    return result;
  }

  Future<void> swapPlayers(Player player, Player player2) async {
    final db = await dbProvider.database;
    await db!.update(
      playersTable, player.toJson(),
      where: "$columnId = ?", whereArgs: [player.id]
    );
    await db.update(
      playersTable, player2.toJson(),
      where: "$columnId = ?", whereArgs: [player2.id]
    );
  }

  Future<int> deletePlayer(int id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(playersTable, where: '$columnId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteNHLSchedule() async {
    final db = await dbProvider.database;
    var result = await db!.delete(scheduleNHLTable);
    return result;
  }
}
