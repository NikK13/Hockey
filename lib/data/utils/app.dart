import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hockey/data/utils/localization.dart';

class App {
  static const String appYear = "2022";
  static const String appName = "Hockey $appYear";
  static String platform = defaultTargetPlatform.name;
  static const Color selectedColor = Colors.deepOrange;
  static const Color colorDark = Color(0xFF1D1D1D);
  static const Color colorLight = Color(0xFFF8F8F8);
  static const String appColor = "28e61e";
  static const String font = "Manrope";

  static final Iterable<LocalizationsDelegate<dynamic>> delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultMaterialLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

  static const appPadding = EdgeInsets.fromLTRB(16, 24, 16, 8);

  static final supportedLocales = [
    const Locale('en', ''), //English
    const Locale('ru', ''), //Russian
  ];

  static const textStyleBtnLight = TextStyle(
    fontSize: 16,
    color: Colors.white
  );

  static final textStyleBtnDark = TextStyle(
    fontSize: 16,
    color: Colors.green.shade700
  );

  static final themeLight = ThemeData(
    scaffoldBackgroundColor: App.colorLight,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    //floatingActionButtonTheme: fabTheme,
    textTheme: const TextTheme(
      button: textStyleBtnLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    fontFamily: App.font,
    colorScheme: const ColorScheme.light().copyWith(secondary: Colors.white),
  );

  static final themeDark = ThemeData(
    scaffoldBackgroundColor: App.colorDark,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    //floatingActionButtonTheme: fabTheme,
    textTheme: TextTheme(
      button: textStyleBtnDark,
    ),
    /*buttonTheme: ButtonThemeData(
      buttonColor: Colors.pink,
      textTheme: ButtonTextTheme.primary,
    ),*/
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black54,
    ),
    brightness: Brightness.dark,
    fontFamily: App.font,
    colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.black),
  );

  static ThemeMode getThemeMode(String mode){
    switch(mode){
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static setupBar(isLight) => SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarColor: isLight ? const Color(0x00000000) : Colors.transparent,
      systemNavigationBarColor: isLight ? colorLight : const Color(0xFF212121),
    ),
  );
}
