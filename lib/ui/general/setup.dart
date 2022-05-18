import 'package:flutter/material.dart';
import 'package:hockey/data/api/teams_repository.dart';
import 'package:hockey/data/db/database/db.dart';
import 'package:hockey/data/generator/player_generator.dart';
import 'package:hockey/data/model/team.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
import 'package:hockey/data/utils/constants.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';
import 'package:hockey/ui/widgets/fetching.dart';
import 'package:hockey/ui/widgets/platform_button.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  String? _error;
  bool _isFetching = false;

  double _fetchedPercent = 0.05;

  void Function(void Function())? _setPercentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Padding(
            padding: App.appPadding,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "HOCKEY MANAGER",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30
                          ),
                          maxLines: 2,
                        ),
                        if(_error != null)
                        Text(
                          _error!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: _isFetching ? StatefulBuilder(
                      builder: (_, setItem){
                        _setPercentState = setItem;
                        return FetchingView(
                          progress: _fetchedPercent > 0.995 ?
                          1 : _fetchedPercent,
                        );
                      },
                    ) :
                    PlatformButton(
                      text: _error == null ?
                      AppLocalizations.of(context, 'load_data') :
                      AppLocalizations.of(context, 'try_again'),
                      onPressed: () async{
                        setState((){
                          _isFetching = true;
                          _error = null;
                        });
                        final provider = DatabaseProvider.dbProvider;
                        if(!(await provider.databaseExists)){
                          await provider.createDatabase();
                        }
                        final teams = await TeamsRepository.fetchAllTeams();
                        if(teams is List<Team>){
                          for(var team in teams){
                            try{
                              await databaseBloc.addTeam(team);
                            }
                            catch(error){
                              setState((){
                                _isFetching = false;
                                _error = error.toString();
                              });
                            }
                            final players = PlayerGenerator.generatedInitPlayers(team);
                            for (var pl in players) {
                              try{
                                await databaseBloc.addPlayer(pl, team);
                              }
                              catch(error){
                                setState((){
                                  _isFetching = false;
                                  _error = error.toString();
                                });
                              }
                            }
                            _setPercentState!(() => _fetchedPercent += (Constants.percentSingle / 100));
                          }
                          setState(() => _isFetching = false);
                          AppNavigator.of(context).pop(ctx: context);
                        }
                        else{
                          final statusError = teams as String;
                          setState((){
                            _error = statusError;
                            _isFetching = false;
                          });
                        }
                      }
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
