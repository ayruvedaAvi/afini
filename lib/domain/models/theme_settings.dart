import 'package:flutter/material.dart';

enum MyThemeMode { light, dark, system }

class ThemeSettings {
  final MyThemeMode themeMode;
  final Color accentColor;
  final double fontSize;
  
  ThemeSettings({
    required this.themeMode,
    required this.accentColor,
    required this.fontSize,
  });
}