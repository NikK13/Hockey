import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/dialog/team_choose_dialog.dart';
import 'package:hockey/ui/editor/edit_team.dart';
import 'package:hockey/ui/widgets/appbar.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

class QuickMatchSelectMobile extends StatefulWidget {
  final List<Team>? teams;

  const QuickMatchSelectMobile({Key? key, this.teams}) : super(key: key);

  @override
  State<QuickMatchSelectMobile> createState() => _QuickMatchSelectMobileState();
}

class _QuickMatchSelectMobileState extends State<QuickMatchSelectMobile> {
  List<Team> get allTeams => widget.teams!;

  Team? _homeTeam;
  Team? _awayTeam;

  int _homeAtt = 0, _homeDef = 0, _homeGoalie = 0;
  int _awayAtt = 0, _awayDef = 0, _awayGoalie = 0;

  @override
  void initState() {
    _homeTeam = allTeams.first;
    _awayTeam = allTeams[1];
    syncSkills();
    super.initState();
  }

  syncSkills() async{
    await databaseBloc.getSkillOfTeamPlayers(_homeTeam!.id!).then((home){
      setState((){
        _homeAtt = home[0];
        _homeDef = home[1];
        _homeGoalie = home[2];
      });
    });
    await databaseBloc.getSkillOfTeamPlayers(_awayTeam!.id!).then((away){
      setState((){
        _awayAtt = away[0];
        _awayDef = away[1];
        _awayGoalie = away[2];
      });
    });
    /*debugPrint("$_homeAtt, $_homeDef, $_homeGoalie");
    debugPrint("$_awayAtt, $_awayDef, $_awayGoalie");*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: App.appPadding,
            child: Column(
              children: [
                PlatformAppBar(
                  title: AppLocalizations.of(context, 'quick_game'),
                  titleFontSize: 26,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _awayTeam!.abbreviation!,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TeamLogo(
                                  team: _awayTeam,
                                  imageFile: File("$filesPath/team${_awayTeam!.id}.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/goalie.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_awayGoalie",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/defence.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_awayDef",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/attack.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_awayAtt",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _homeTeam!.abbreviation!,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TeamLogo(
                                  team: _homeTeam,
                                  imageFile: File("$filesPath/team${_homeTeam!.id}.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/goalie.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_homeGoalie",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/defence.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_homeDef",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/attack.png"
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$_homeAtt",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4, top: 6),
                        child: PlatformButton(
                          text: "Change away",
                          fontSize: 14,
                          onPressed: (){
                            _showTeamPickDialog(context, false);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, top: 6),
                        child: PlatformButton(
                          text: "Change home",
                          fontSize: 14,
                          onPressed: (){
                            _showTeamPickDialog(context, true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: PlatformButton(
                    text: "Proceed to game",
                    onPressed: (){

                    }
                  ),
                ),
                const SizedBox(height: 6)
              ],
            ),
          ),
        ),
      )
    );
  }

  void _showTeamPickDialog(context, bool isHomeTeam){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, controller){
          /*if(slideWidget == null){
            _slideMenu = SlideMenu(
              bloc: _historyBloc,
              bmBloc: _bookmarksBloc,
              controller: _controller,
              scrollController: controller,
              initialUrl: widget.prefs!.initialURL!,
            );
          }
          return _slideMenu!;*/
          return TeamChooseDialog(
            teams: allTeams,
            scrollController: controller,
            changeTeam: _selectTeam,
            isHome: isHomeTeam,
          );
        },
      ),
      //backgroundColor: Colors.grey.shade200
    );
  }

  _selectTeam(bool isHome, Team team) async{
    if(isHome){
      setState(() {
        _homeTeam = team;
      });
    }
    else{
      setState(() {
        _awayTeam = team;
      });
    }
    await syncSkills();
  }
}
