import 'package:flutter/material.dart';

class ThemeService {
  static const textTheme = TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Quicksand'),
    bodyMedium: TextStyle(fontFamily: 'Quicksand'),
    bodySmall: TextStyle(fontFamily: 'Quicksand'),
    displayLarge: TextStyle(fontFamily: 'Quicksand'),
    displayMedium: TextStyle(fontFamily: 'Quicksand'),
    displaySmall: TextStyle(fontFamily: 'Quicksand'),
    headlineLarge: TextStyle(fontFamily: 'Quicksand'),
    headlineMedium: TextStyle(fontFamily: 'Quicksand'),
    headlineSmall: TextStyle(fontFamily: 'Quicksand'),
    titleLarge: TextStyle(fontFamily: 'Quicksand'),
    titleMedium: TextStyle(fontFamily: 'Quicksand'),
    titleSmall: TextStyle(fontFamily: 'Quicksand'),
    labelLarge: TextStyle(fontFamily: 'Quicksand'),
    labelMedium: TextStyle(fontFamily: 'Quicksand'),
    labelSmall: TextStyle(fontFamily: 'Quicksand'),
  );
  static ThemeData getLightTheme(Color accentColor) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: accentColor,
      primarySwatch: getMaterialColor(accentColor),
      appBarTheme: AppBarTheme(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
        ),
      ),
      textTheme: textTheme,
      // Add more theme customizations here
    );
  }

  static ThemeData getDarkTheme(Color accentColor) {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: accentColor,
        primarySwatch: getMaterialColor(accentColor),
        appBarTheme: AppBarTheme(
          backgroundColor: accentColor.withOpacity(0.8),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: textTheme
        // Add more dark theme customizations here
        );
  }

  // Helper function to create MaterialColor from any Color
  static MaterialColor getMaterialColor(Color color) {
    final Map<int, Color> shades = {
      50: _getColorShade(color, 0.1),
      100: _getColorShade(color, 0.2),
      200: _getColorShade(color, 0.3),
      300: _getColorShade(color, 0.4),
      400: _getColorShade(color, 0.5),
      500: _getColorShade(color, 0.6),
      600: _getColorShade(color, 0.7),
      700: _getColorShade(color, 0.8),
      800: _getColorShade(color, 0.9),
      900: _getColorShade(color, 1.0),
    };

    return MaterialColor(color.value, shades);
  }

  static Color _getColorShade(Color color, double factor) {
    return Color.fromRGBO(
      color.red,
      color.green,
      color.blue,
      factor,
    );
  }
}
