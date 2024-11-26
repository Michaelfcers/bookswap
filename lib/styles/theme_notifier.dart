import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Tema inicial

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void updateTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners(); // Notificar a los widgets que escuchan el cambio
  }
}
