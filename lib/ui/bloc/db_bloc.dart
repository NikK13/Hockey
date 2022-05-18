import 'dart:io';

import 'package:hockey/data/db/database/db.dart';
import 'package:hockey/data/db/repository/repository.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/schedule.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/constants.dart';
import 'package:hockey/ui/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseBloc implements BaseBloc{
  final repository = Repository();

  final _allTeams = BehaviorSubject<List<Team>>();

  final _allPlayers = BehaviorSubject<List<Player>>();
  final _allTeamPlayers = BehaviorSubject<List<Player>>();

  final _team = BehaviorSubject<Team>();
  final _player = BehaviorSubject<Player>();

  Stream<List<Team>> get allTeamsStream => _allTeams.stream;
  Stream<List<Player>> get allPlayersStream => _allPlayers.stream;
  Stream<List<Player>> get allTeamPlayersStream => _allTeamPlayers.stream;

  Stream<Team> get teamStream => _team.stream;
  Stream<Player> get playerStream => _player.stream;

  Function(List<Team>) get loadAllTeams => _allTeams.sink.add;
  Function(List<Player>) get loadAllPlayers => _allPlayers.sink.add;
  Function(List<Player>) get loadTeamPlayers => _allTeamPlayers.sink.add;

  Function(Team) get updateTeam => _team.sink.add;
  Function(Player) get updatePlayer => _player.sink.add;

  Future<bool> get dbExists async {
    final teams = await fetchAllTeams();
    return await DatabaseProvider.dbProvider.databaseExists
        && teams.length == Constants.teamsCount;
  }

  Future<File> preloadFile() async{
    final path = await DatabaseProvider.databasePath;
    return File(path);
  }

  allTeams() async{
    await loadAllTeams(await fetchAllTeams());
  }

  Future<List<Team>> fetchAllTeams() async{
    return await repository.getAllTeams();
  }

  Future<List<ScheduleMatch>> fetchAllNHLSchedule() async{
    return await repository.getAllNHLMatches();
  }

  Future<List<int>> getSkillOfTeamPlayers(int id) async{
    return await repository.getTeamPlayersSkill(id);
  }

  loadIdTeam(int id) async{
    await updateTeam(await repository.getTeam(id));
  }

  allPlayers() async{
    await loadAllPlayers(await repository.getAllPlayers());
  }

  loadPlayersFromTeam(int id) async{
    await loadTeamPlayers(await repository.getAllPlayersFromTeam(id));
  }

  fetchPlayersFromTeam(int id) async{
    return await repository.getAllPlayersFromTeam(id);
  }

  addTeam(Team team) async {
    await repository.createTeam(team);
    await allTeams();
  }

  addNHLMatch(ScheduleMatch match) async {
    await repository.createNHLMatch(match);
  }

  addPlayer(Player player, Team team) async {
    await repository.createPlayer(player);
    await loadPlayersFromTeam(team.id!);
  }

  updateATeam(Team team) async {
    await repository.updateTeam(team);
    await updateTeam(team);
    await allTeams();
  }

  updateTeamPlayer(Player player, Team team) async {
    await repository.updatePlayer(player);
    await loadPlayersFromTeam(team.id!);
  }

  swapPlayers(Player p1, Player p2, Team team) async {
    await repository.swapPlayers(p1, p2);
    await loadPlayersFromTeam(team.id!);
  }

  @override
  void dispose() {
    _allTeams.close();
    _allPlayers.close();
    _allTeamPlayers.close();
    _player.close();
    _team.close();
  }
}