import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hockey/data/model/preferences.dart';
import 'package:hockey/data/utils/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider extends ChangeNotifier {
  SharedPreferences? sp;

  String? currentTheme;
  Locale? locale;

  PreferenceProvider() {
    _loadFromPrefs();
  }

  _initPrefs() async {
    sp ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    if (sp!.getString('mode') == null) await sp!.setString('mode', 'system');
    if (sp!.getString('language') == null) {
      switch (window.locale.languageCode) {
        case 'en':
        case 'ru':
          locale = Locale(window.locale.languageCode, '');
          break;
        default:
          locale = const Locale('en', '');
      }
    } else {
      locale = Locale(sp!.getString('language')!, '');
    }
    currentTheme = sp!.getString('mode');
    notifyListeners();
  }

  savePreference(String key, value) async {
    await _initPrefs();
    switch (key) {
      case 'mode':
      case 'language':
        sp!.setString(key, value);
        break;
    }
    locale = Locale(sp!.getString('language')!, '');
    currentTheme = sp!.getString('mode');
    notifyListeners();
  }

  Preferences get preferences => Preferences(
    currentTheme: currentTheme,
    locale: locale,
  );

  String? getThemeTitle(BuildContext context) {
    switch (sp!.getString("mode")) {
      case 'light':
        return AppLocalizations.of(context, 'theme_light');
      case 'dark':
        return AppLocalizations.of(context, 'theme_dark');
      case 'system':
        return AppLocalizations.of(context, 'theme_system');
      default:
        return "";
    }
  }
}
