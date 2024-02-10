import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage with ChangeNotifier {
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  Future<void> changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (type == const Locale('en')) {
      _appLocale = type;
      await sp.setString('language_code', 'en');
      _appLocale = const Locale('en');
    } else {
      await sp.setString('language_code', 'ar');
      _appLocale = const Locale('ar');
    }
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
      notifyListeners();
    }
  }
}
