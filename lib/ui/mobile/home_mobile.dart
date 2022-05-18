import 'package:flutter/material.dart';
import 'package:hockey/data/generator/player_generator.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/main.dart';
import 'package:hockey/ui/mobile/qm_select_mobile.dart';
import 'package:hockey/ui/widgets/app_logo.dart';
import 'package:hockey/ui/widgets/menu_item.dart';
import 'package:hockey/ui/general/editor.dart';
import 'package:hockey/ui/general/settings.dart';
import 'package:hockey/ui/general/setup.dart';
import 'package:hockey/ui/widgets/backgrounded.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.setupBar(Theme.of(context).brightness == Brightness.light);
    return WillPopScope(
      onWillPop: () async => await AppNavigator.of(context).pop(ctx: context),
      child: Scaffold(
        body: BackgroundWidget(
          child: Column(
            children: [
              const AppLogo(),
              Column(
                children: [
                  Row(
                    children: [
                      MenuSingleItem(
                        title: AppLocalizations.of(context, 'quick_game'),
                        onTap: () async{
                          if(await databaseBloc.dbExists){
                            final teams = await databaseBloc.fetchAllTeams();
                            AppNavigator.of(context).push(QuickMatchSelectMobile(
                              teams: teams,
                            ));
                          }
                          else{
                            AppNavigator.of(context).push(const SetupPage());
                          }
                        },
                      ),
                      MenuSingleItem(
                        title: AppLocalizations.of(context, 'game_modes'),
                        onTap: () async{

                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MenuSingleItem(
                        title: AppLocalizations.of(context, 'editor'),
                        onTap: () async{
                          if(await databaseBloc.dbExists){
                            AppNavigator.of(context).push(const EditorPage());
                          }
                          else{
                            AppNavigator.of(context).push(const SetupPage());
                          }
                        },
                      ),
                      MenuSingleItem(
                        title: AppLocalizations.of(context, 'settings'),
                        onTap: () async{
                          AppNavigator.of(context).push(const SettingsPage());
                        },
                      ),
                      MenuSingleItem(
                        title: AppLocalizations.of(context, 'about'),
                        onTap: () {
                          debugPrint("${PlayerGenerator.nations.length}");
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 4)
            ],
          ),
        )
      ),
    );
  }
}

