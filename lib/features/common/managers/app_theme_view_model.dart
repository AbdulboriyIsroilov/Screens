import 'package:flutter/material.dart';

class AppThemeViewModel extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void toggleTheme() {
    if (mode == ThemeMode.dark) {
      mode = ThemeMode.light;
    } else {
      mode = ThemeMode.dark;
    }
    notifyListeners();
  }
}