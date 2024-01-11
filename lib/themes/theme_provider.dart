import 'package:flutter/material.dart';
import 'package:musicp/themes/light_mode.dart';

import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode; //initial theme

  ThemeData get themeData => _themeData; //get theme

  //is dark mode
  bool get isDarkMode => _themeData == darkMode;

  //set Theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    //update ui
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
