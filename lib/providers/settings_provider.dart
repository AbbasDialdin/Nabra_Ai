import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool isDarkMode = false;
  String language = 'ar';

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void changeLanguage(String lang) {
    language = lang;
    notifyListeners();
  }
}
