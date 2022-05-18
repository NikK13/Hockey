import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hockey/data/events/face_off.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';

class MatchMobilePage extends StatefulWidget {
  final Team? homeTeam;
  final Team? awayTeam;

  const MatchMobilePage({
    Key? key,
    this.homeTeam,
    this.awayTeam
  }) : super(key: key);

  @override
  State<MatchMobilePage> createState() => _MatchMobilePageState();
}

class _MatchMobilePageState extends State<MatchMobilePage> {
  MatchEvent? match;

  int _homeGoals = 0;
  int _awayGoals = 0;

  int _curGamePos = 0;

  Timer? timer;

  Team get home => widget.homeTeam!;
  Team get away => widget.awayTeam!;

  List<Player>? homePlayers;
  List<Player>? awayPlayers;

  @override
  void initState(){
    initRosters();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      match = MatchEvent(context: context);
    });
    super.initState();
  }

  Future<void> initRosters() async{
    homePlayers = await home.teamPlayers;
    awayPlayers = await away.teamPlayers;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: App.appPadding,
            child: Column(
              children: const [

              ],
            ),
          ),
        ),
      ),
    );
  }

  void generateEvents(){
    match!.events.add(FaceOff.generateEvent(home, away, true));
  }
}