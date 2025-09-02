import 'package:flutter/material.dart';

enum MyThemeMode { light, dark, system }

class ThemeSettings {
  final MyThemeMode themeMode;
  final Color accentColor;
  final double fontSize;
  final String? chatBackground;

  ThemeSettings({
    required this.themeMode,
    required this.accentColor,
    required this.fontSize,
    this.chatBackground,
  });
}
