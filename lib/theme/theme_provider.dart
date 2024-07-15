import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  //initially set the theme to light mode
  ThemeData _themeData = lightMode;

  //getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  //getter method to see if we are in dark mode or light mode
  bool get isDarkMode => _themeData == darkMode;

  //setter method to change the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //we will use this toggle in a switch later on...
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
