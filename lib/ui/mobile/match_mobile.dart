import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hockey/data/events/game_start.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/editor/edit_team.dart';
import 'package:hockey/ui/widgets/appbar.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

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
  GameMatch? match;

  List<MatchEvent>? allEvents;

  Timer? timer;

  Team get home => widget.homeTeam!;
  Team get away => widget.awayTeam!;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  void initState(){
    match = GameMatch(context: context);
    initRosters();
    super.initState();
  }

  Future<void> initRosters() async{
    home.roster = await home.teamPlayers;
    away.roster = await away.teamPlayers;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: BackgroundWidget(
          child: SafeArea(
            child: Padding(
              padding: App.appPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PlatformAppBar(
                    title: AppLocalizations.of(context, 'quick_game'),
                    titleFontSize: 26,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16)
                              ),
                              color: HexColor.fromHex(away.color!.substring(1, 7))
                            ),
                            child: Center(
                              child: TeamLogo(
                                team: away,
                                imageFile: File(
                                  "$filesPath/team${away.id}.png"
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Game", style: TextStyle(color: Colors.black)),
                                Expanded(
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        "${match!.awayScore}:${match!.homeScore}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 50
                                        )
                                      ),
                                    ),
                                  )
                                ),
                                const Text("20:00", style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16)
                              ),
                              color: HexColor.fromHex(home.color!.substring(1, 7))
                            ),
                            child: Center(
                              child: TeamLogo(
                                team: home,
                                imageFile: File(
                                  "$filesPath/team${home.id}.png"
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 120,
                    child: PlatformButton(
                      text: "Start",
                      onPressed: (){
                        generateEvents(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void generateEvents(BuildContext context){
    home.curLine = 1;
    away.curLine = 1;
    if(match!.events.isNotEmpty){
      match!.events.clear();
    }
    match!.events.add(GameStart(context, home, away, match!));
    final ev = match!.events.reversed.toList();
    for(var event in ev){
      debugPrint("${event.comment}");
    }
  }
}