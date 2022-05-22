import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hockey/data/events/game_start.dart';
import 'package:hockey/data/events/goal.dart';
import 'package:hockey/data/events/match.dart';
import 'package:hockey/data/events/match_event.dart';
import 'package:hockey/data/events/period_over.dart';
import 'package:hockey/data/events/period_start.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
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

  int _period = 0;

  Team get home => widget.homeTeam!;
  Team get away => widget.awayTeam!;

  List<MatchEvent> goals = [];

  @override
  void initState(){
    match = GameMatch();
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
                                Text("${periodTitle()}", style: const TextStyle(color: Colors.black)),
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
                    width: 140,
                    child: PlatformButton(
                      text: _period < 3 ? "Proceed" : "Finish",
                      onPressed: (){
                        if(_period < 3){
                          generateEvents(context);
                          setState((){
                            _period++;
                          });
                        }
                        else{
                          AppNavigator.of(context).pop(ctx: context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: goals.length,
                      itemBuilder: (context, index){
                        final item = goals[index] as Goal;
                        return Center(
                          child: Text(
                            item.comment!,
                            style: const TextStyle(
                              fontSize: 11
                            ),
                          ),
                        );
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

  String periodTitle(){
    switch(_period){
      case 0:
        return "Game start";
      case 1:
        return "End of 1st";
      case 2:
        return "End of 2st";
      case 3:
        return "End of 3st";
      default:
        return "";
    }
  }

  void generateEvents(BuildContext context){
    home.curLine = 1;
    away.curLine = 1;
    GameMatch.kp = 0;
    match!.events.clear();
    if(_period == 0){
      match!.events.add(GameStart(context, home, away, match!));
    }
    else{
      match!.events.add(PeriodStart(context, home, away, match!));
    }
    var ev = match!.events.reversed.toList();
    goals.addAll(match!.events.reversed.whereType<Goal>());
    match!.homeScore = goals.where((element) => (element as Goal).scoredTeam!.id! == home.id!).toList().length;
    match!.awayScore = goals.where((element) => (element as Goal).scoredTeam!.id! == away.id!).toList().length;
    //ev.add(PeriodOver(context, home, away, match!));
    /*for(var event in ev){
      debugPrint("${event.comment}");
    }*/
    //debugPrint("${GameMatch.kp}");
  }
}