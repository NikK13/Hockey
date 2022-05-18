import 'dart:io';
import 'package:hockey/ui/widgets/menu_item.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/editor/edit_league.dart';
import 'package:hockey/ui/editor/edit_players.dart';
import 'package:hockey/ui/editor/edit_team.dart';
import 'package:hockey/ui/widgets/appbar.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: App.appPadding,
                  child: Column(
                    children: [
                      PlatformAppBar(
                        title: AppLocalizations.of(context, 'editor'),
                        titleFontSize: 26,
                        trailing: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.backup_outlined,
                            color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black : Colors.white
                          )
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: FutureBuilder(
                            future: databaseBloc.preloadFile(),
                            builder: (context, AsyncSnapshot<File> snapshot){
                              if(snapshot.hasData){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      App.appName,
                                      style: TextStyle(
                                        fontSize: 28
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text("File name: ${basename(snapshot.data!.path)}"),
                                    Text("Last edited: ${getDateModified(snapshot.data!.lastModifiedSync())}"),
                                  ],
                                );
                              }
                              return const Text("Error loading DB");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  MenuSingleItem(
                    title: AppLocalizations.of(context, 'editor_league'),
                    onTap: () async{
                      AppNavigator.of(context).push(const LeagueEditPage());
                    },
                  ),
                  MenuSingleItem(
                    title: AppLocalizations.of(context, 'editor_teams'),
                    onTap: () async{
                      AppNavigator.of(context).push(const TeamEditPage());
                    },
                  ),
                  MenuSingleItem(
                    title: AppLocalizations.of(context, 'editor_players'),
                    onTap: () {
                      AppNavigator.of(context).push(const PlayersEditPage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 4)
            ],
          ),
        ),
      )
    );
  }

  String getDateModified(DateTime date){
    return DateFormat("dd/MM/yyyy hh:mm a").format(date);
  }
}
