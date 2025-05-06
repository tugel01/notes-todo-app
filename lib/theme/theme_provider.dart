import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  // initialize theme to light mode
  ThemeData _themeData = lightMode;

  // getter for themedata
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if(_themeData == lightMode) {
      themeData = darkMode;
    }
    else {
      themeData = lightMode;
    }
  }
}