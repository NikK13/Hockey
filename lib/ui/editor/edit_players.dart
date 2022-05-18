import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hockey/data/model/player.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/dialog/team_choose_dialog.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/loading.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

class PlayersEditPage extends StatefulWidget {
  const PlayersEditPage({Key? key}) : super(key: key);

  @override
  State<PlayersEditPage> createState() => _PlayersEditPageState();
}

class _PlayersEditPageState extends State<PlayersEditPage> {
  final List<Team> _allTeams = [];

  int _selectedId = 1;
  int _selectedPlayer = -1;

  File? _imageFile;

  @override
  void initState() {
    _imageFile = File("$filesPath/team$_selectedId.png");
    databaseBloc.loadIdTeam(_selectedId);
    databaseBloc.loadPlayersFromTeam(_selectedId);
    databaseBloc.fetchAllTeams().then((value){
      _allTeams.addAll(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: App.appPadding,
            child: StreamBuilder(
              stream: databaseBloc.teamStream,
              builder: (context, AsyncSnapshot<Team?> teamSnapshot) {
                return StreamBuilder(
                  stream: databaseBloc.allTeamPlayersStream,
                  builder: (context, AsyncSnapshot<List<Player>?> playersSnapshot) {
                    final dataList = playersSnapshot.data ?? [];
                    if(playersSnapshot.hasData){
                      dataList.sort((a,b) => a.teamPosition!.compareTo(b.teamPosition!));
                    }
                    return (playersSnapshot.hasData && teamSnapshot.hasData) ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 32,
                              ),
                              onTap: (){
                                AppNavigator.of(context).pop(ctx: context);
                              },
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: _imageFile!.existsSync() ?
                                  Image.file(
                                    _imageFile!,
                                    fit: BoxFit.contain,
                                  ) : Image.asset(
                                    "assets/images/${teamSnapshot.data!.emblem}.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  teamSnapshot.data!.teamName!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  "${teamSnapshot.data!.budget}M EUR",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context, 'attack'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      childAspectRatio: 1.5
                                    ),
                                    shrinkWrap: true,
                                    itemCount: 12,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      final item = playersSnapshot.data![index];
                                      return SinglePlayer(
                                        player: item,
                                        selectedPl: _selectedPlayer,
                                        onTap: () async{
                                          if(_selectedPlayer == -1){
                                            setState((){
                                              _selectedPlayer = item.teamPosition!;
                                            });
                                          }
                                          else{
                                            if(dataList[_selectedPlayer].position != "gk"){
                                              final playerOne = dataList[_selectedPlayer];
                                              final pOnePos = playerOne.teamPosition;
                                              final pTowPos = item.teamPosition;
                                              playerOne.teamPosition = pTowPos;
                                              item.teamPosition = pOnePos;
                                              await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                            else{
                                              debugPrint("Can't swap with field players");
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                          }
                                        },
                                      );
                                    }
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context, 'defence'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      childAspectRatio: 1.6
                                    ),
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      final data = dataList.getRange(12, 18).toList();
                                      final item = data[index];
                                      return SinglePlayer(
                                        player: item,
                                        selectedPl: _selectedPlayer,
                                        onTap: () async{
                                          if(_selectedPlayer == -1){
                                            setState((){
                                              _selectedPlayer = item.teamPosition!;
                                            });
                                          }
                                          else{
                                            if(dataList[_selectedPlayer].position != "gk"){
                                              final playerOne = dataList[_selectedPlayer];
                                              final pOnePos = playerOne.teamPosition;
                                              final pTowPos = item.teamPosition;
                                              playerOne.teamPosition = pTowPos;
                                              item.teamPosition = pOnePos;
                                              await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                            else{
                                              debugPrint("Can't swap with field players");
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                          }
                                        },
                                      );
                                    }
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context, 'goalies'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      childAspectRatio: 1.6
                                    ),
                                    shrinkWrap: true,
                                    itemCount: 2,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      final data = dataList.getRange(18, 20).toList();
                                      final item = data[index];
                                      return SinglePlayer(
                                        player: item,
                                        selectedPl: _selectedPlayer,
                                        onTap: () async{
                                          if(_selectedPlayer == -1){
                                            setState((){
                                              _selectedPlayer = item.teamPosition!;
                                            });
                                          }
                                          else{
                                            if(_selectedPlayer == 18 || _selectedPlayer == 19){
                                              final playerOne = dataList[_selectedPlayer];
                                              final pOnePos = playerOne.teamPosition;
                                              final pTowPos = item.teamPosition;
                                              playerOne.teamPosition = pTowPos;
                                              item.teamPosition = pOnePos;
                                              await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                            else if(dataList[_selectedPlayer].position == "gk"){
                                              final playerOne = dataList[_selectedPlayer];
                                              final pOnePos = playerOne.teamPosition;
                                              final pTowPos = item.teamPosition;
                                              playerOne.teamPosition = pTowPos;
                                              item.teamPosition = pOnePos;
                                              await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                            else{
                                              debugPrint("Can't swap with field players");
                                              setState((){
                                                _selectedPlayer = -1;
                                              });
                                            }
                                          }
                                        },
                                      );
                                    }
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context, 'subs'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      childAspectRatio: 1.5
                                    ),
                                    shrinkWrap: true,
                                    itemCount: dataList.getRange(20, dataList.length).toList().length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      final list = dataList.getRange(20, dataList.length).toList();
                                      final item = list[index];
                                      return SinglePlayer(
                                        player: item,
                                        selectedPl: _selectedPlayer,
                                        onTap: () async{
                                          if(_selectedPlayer == -1){
                                            setState((){
                                              _selectedPlayer = item.teamPosition!;
                                            });
                                          }
                                          else{
                                            if(_selectedPlayer == 18 || _selectedPlayer == 19){
                                              if(item.position == "gk"){
                                                final playerOne = dataList[_selectedPlayer];
                                                final pOnePos = playerOne.teamPosition;
                                                final pTowPos = item.teamPosition;
                                                playerOne.teamPosition = pTowPos;
                                                item.teamPosition = pOnePos;
                                                await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                                setState((){
                                                  _selectedPlayer = -1;
                                                });
                                              }
                                              else{
                                                debugPrint("Can't swap with field players");
                                                setState((){
                                                  _selectedPlayer = -1;
                                                });
                                              }
                                            }
                                            else{
                                              if(item.position != "gk"){
                                                final playerOne = dataList[_selectedPlayer];
                                                final pOnePos = playerOne.teamPosition;
                                                final pTowPos = item.teamPosition;
                                                playerOne.teamPosition = pTowPos;
                                                item.teamPosition = pOnePos;
                                                await databaseBloc.swapPlayers(playerOne, item, teamSnapshot.data!);
                                                setState((){
                                                  _selectedPlayer = -1;
                                                });
                                              }
                                              else{
                                                debugPrint("Can't swap with field players");
                                                setState((){
                                                  _selectedPlayer = -1;
                                                });
                                              }
                                            }
                                          }
                                        },
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: PlatformButton(
                                    text: "Add player",
                                    onPressed: () {

                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: PlatformButton(
                                    text: "Edit player",
                                    onPressed: () {
                                      if(_selectedPlayer != -1){
                                        debugPrint("Open editor");
                                      }
                                      else{
                                        debugPrint("Choose player first");
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: PlatformButton(
                                text: "Change team",
                                onPressed: (){
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
                                        return TeamChooseDialog(
                                          teams: _allTeams,
                                          scrollController: controller,
                                          changeTeam: _selectTeam,
                                        );
                                      },
                                    ),
                                    //backgroundColor: Colors.grey.shade200
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4)
                      ],
                    ) : Center(
                      child: LoadingView(color: HexColor.fromHex(App.appColor)),
                    );
                  }
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  void _selectTeam(int id) async{
    setState(() {
      _selectedId = id;
      _imageFile = File("$filesPath/team$_selectedId.png");
    });
    await databaseBloc.loadIdTeam(_selectedId);
    await databaseBloc.loadPlayersFromTeam(_selectedId);
  }
}

class SinglePlayer extends StatelessWidget {
  final Player? player;
  final Function? onTap;
  final int? selectedPl;

  const SinglePlayer({
    Key? key, this.selectedPl,
    this.player, this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPl == player!.teamPosition! ?
            App.selectedColor : Colors.white
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0, right: 0,
              left: 0, bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackgroundWidget(
                  fit: BoxFit.cover,
                  darkness: 0.77,
                  image: Player.getFlagByNationality(player!.nationality!),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 8,
              child: Text(
                player!.position!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
                maxLines: 1,
              ),
            ),
            Positioned.fill(
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getShortName,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      Text(
                        "${player!.skill!} OVR",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                        maxLines: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get getShortName{
    return "${player!.firstName!.substring(0,1)}. ${player!.lastName}";
  }
}


