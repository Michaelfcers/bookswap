import 'package:flutter/material.dart';

class AppColors {
  // Paleta de colores base
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.black54;
  static const Color lightGrey = Colors.black12;
  static const Color redDark = Color(0xFF8C2F39); // Rojo oscuro
  static const Color beigeLight = Color(0xFFF1EFE7); // Fondo beige claro
  static const Color selectedIcon = Color.fromARGB(255, 189, 105, 105); // Íconos seleccionados

  // Dinámica (tema actual)
  static bool _isDarkMode = false;

  static void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
  }

  // Getters para colores específicos del tema
  static Color get primary => _isDarkMode ? black : redDark;
  static Color get secondary => grey;
  static Color get tittle => _isDarkMode ? beigeLight : beigeLight;
  static Color get scaffoldBackground => _isDarkMode ? black : beigeLight;
  static Color get cardBackground => white;
  static Color get textPrimary => _isDarkMode ? white : black;
  static Color get textSecondary => grey;
  static Color get shadow => _isDarkMode ? lightGrey : Colors.black38;
  static Color get divider => _isDarkMode ? lightGrey : Colors.black38;
  static Color get iconSelected => selectedIcon;
  static Color get iconUnselected => _isDarkMode ? white : grey;

  // Crear ThemeData dinámicamente
  static ThemeData getThemeData(bool isDarkMode) {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: textPrimary,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textSecondary),
      ),
      dividerColor: divider,
      cardColor: cardBackground,
    );
  }
}
