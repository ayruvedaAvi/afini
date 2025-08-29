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
    titleLarge: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
    labelLarge: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
    labelSmall: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
  );

  static TextTheme getTextTheme(double size){
    return textTheme.copyWith(
      bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: size),
      bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: size - 2),
      bodySmall: textTheme.bodySmall?.copyWith(fontSize: size - 4),
      displayLarge: textTheme.displayLarge?.copyWith(fontSize: size + 10),
      displayMedium: textTheme.displayMedium?.copyWith(fontSize: size + 8),
      displaySmall: textTheme.displaySmall?.copyWith(fontSize: size + 6),
      headlineLarge: textTheme.headlineLarge?.copyWith(fontSize: size + 4),
      headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: size + 2),
      headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: size),
      titleLarge: textTheme.titleLarge?.copyWith(fontSize: size + 2),
      titleMedium: textTheme.titleMedium?.copyWith(fontSize: size),
      titleSmall: textTheme.titleSmall?.copyWith(fontSize: size - 2),
      labelLarge: textTheme.labelLarge?.copyWith(fontSize: size),
      labelMedium: textTheme.labelMedium?.copyWith(fontSize: size - 2),
      labelSmall: textTheme.labelSmall?.copyWith(fontSize: size - 4),
    );
  }

  static ThemeData getLightTheme(Color accentColor, double? size) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: accentColor,
      primarySwatch: getMaterialColor(accentColor),
      cardColor: Colors.grey[200],
      shadowColor: Colors.grey[800],
      colorScheme: ColorScheme.light(
        primary: accentColor,
        secondary: accentColor,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onError: Colors.white,
      ),
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
      textTheme: getTextTheme(size ?? 14),
      // Add more theme customizations here
    );
  }

  static ThemeData getDarkTheme(Color accentColor, double? size) {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: accentColor,
        primarySwatch: getMaterialColor(accentColor),
        cardColor: Colors.grey[700],
        shadowColor: Colors.grey,
        colorScheme: ColorScheme.dark(
          primary: accentColor,
          secondary: accentColor,
          surface: Colors.grey[900]!,
          error: Colors.red[400]!,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: accentColor.withAlpha(200),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: getTextTheme(size ?? 14),
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

    return MaterialColor(color.toARGB32(), shades);
  }

  static Color _getColorShade(Color color, double factor) {
    return Color.fromRGBO(
      color.r.toInt(),
      color.g.toInt(),
      color.b.toInt(),
      factor,
    );
  }
}
