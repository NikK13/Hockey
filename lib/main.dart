import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hockey/ui/mobile/home_mobile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hockey/data/utils/app.dart';
import 'package:hockey/data/utils/appnavigator.dart';
import 'package:hockey/data/utils/extensions.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:hockey/ui/bloc/db_bloc.dart';
import 'package:hockey/ui/provider/prefsprovider.dart';
import 'package:hockey/ui/widgets/platform_page.dart';
import 'package:hockey/ui/windows/home_windows.dart';
import 'package:window_manager/window_manager.dart';

late DatabaseBloc databaseBloc;
late String filesPath;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizations.loadLanguages();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  filesPath = await filesPathByOpSys(defaultTargetPlatform.name);
  databaseBloc = DatabaseBloc();
  if (!kIsWeb && Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async{
      windowManager.setResizable(false);
      await windowManager.setTitle(App.appName);
      await windowManager.setSize(const Size(960, 600));
      await windowManager.setMinimumSize(const Size(960, 600));
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final HeroController _heroController = HeroController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (ctx, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          onGenerateRoute: (_) => null,
          locale: provider.preferences.locale,
          localizationsDelegates: App.delegates,
          supportedLocales: App.supportedLocales,
          themeMode: ThemeMode.dark,
          theme: App.themeLight,
          darkTheme: App.themeDark,
          builder: (context, child){
            return provider.currentTheme != null ? AppNavigator(
              navigatorKey: _navigatorKey,
              initialPages: const [
                MaterialPage(
                  child: PlatformPage(
                    mobilePage: HomeMobilePage(),
                    windowsPage: HomeWindowsPage()
                  )
                )
              ],
              observers: [_heroController],
            ) : const Scaffold(
              body: Center(
                child: Text(
                  "Loading..."
                ),
              ),
            );
          },
        );
      },
    );
  }
}


