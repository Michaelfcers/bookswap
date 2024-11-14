import 'package:flutter/material.dart';

class AppColors {
  // Colores principales
  static const Color primary = Colors.black;
  static const Color secondary = Colors.black54;
  
  // Colores de fondo
  static const Color scaffoldBackground = Colors.black;
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Colores de texto
  static const Color textLight = Colors.white;  // Para texto sobre fondos oscuros
  static const Color textDark = Colors.black;         // Para texto sobre fondos claros
  static const Color textSecondary = Colors.black54;  // Para textos secundarios
  
  // Colores de elementos UI
  static const Color shadow = Colors.black12;
  static const Color divider = Colors.black12;

  // Nuevos colores de íconos
  static const Color iconSelected = Color.fromARGB(255, 189, 105, 105);  // Color morado para íconos seleccionados
  static const Color iconUnselected = Colors.white;      // Blanco para íconos no seleccionados
}

