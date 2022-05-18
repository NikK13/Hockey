import 'package:hockey/data/db/dao/dao.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/schedule.dart';
import 'package:hockey/data/model/team.dart';

class Repository {
  final dao = DaoOfDB();

  Future createTeam(Team item) => dao.createTeam(item);

  Future createNHLMatch(ScheduleMatch match) => dao.createNHLMatch(match);

  Future createPlayer(Player item) => dao.createPlayer(item);

  Future getAllTeams() => dao.getAllTeams();

  Future getAllNHLMatches() => dao.getAllNHLMatches();

  Future getAllPlayers() => dao.getAllPlayers();

  Future getAllPlayersFromTeam(int teamId) => dao.getPlayersFromTeam(teamId);

  Future getTeam(int id) => dao.getTeam(id);

  Future getTeamPlayersSkill(int id) => dao.getTeamPlayersSkill(id);

  Future getPlayerById(int id) => dao.getPlayerById(id);

  Future updateTeam(Team team) => dao.updateTeam(team);

  Future updatePlayer(Player player) => dao.updatePlayer(player);

  Future swapPlayers(Player p1, Player p2) => dao.swapPlayers(p1, p2);

  Future deletePlayer(int id) => dao.deletePlayer(id);

  Future deleteNHLSchedule() => dao.deleteNHLSchedule();
}
