import 'package:flutter/material.dart';
import 'package:music_player/themes/dark_theme.dart';
import 'package:music_player/themes/light_theme.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;

    notifyListeners();
  }

  void toggleTheme(){
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    notifyListeners();
    }
  }
