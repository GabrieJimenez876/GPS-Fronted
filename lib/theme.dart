import 'package:flutter/material.dart';

// Colores basados en el CSS de index.html
const Color primaryColor = Color(0xFF004D40); // --primary: #004d40
const Color accentColor = Color(0xFF15C9B7); // --accent: #15c9b7
const Color backgroundColor = Color(0xFFF4F4F4); // --bg: #f4f4f4
const Color foregroundColor = Color(0xFF222222); // --fg: #222
const Color surfaceColor = Color(0xFFFFFFFF); // --surface: #fff

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    secondary: accentColor,
    background: backgroundColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    centerTitle: false,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Inter', color: foregroundColor),
    bodyMedium: TextStyle(fontFamily: 'Inter', color: foregroundColor),
    titleLarge: TextStyle(fontFamily: 'Inter', color: foregroundColor),
  ),
  cardTheme: CardTheme(
    color: surfaceColor,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // var(--radius: 10px)
    ),
  ),
  useMaterial3: true,
);
