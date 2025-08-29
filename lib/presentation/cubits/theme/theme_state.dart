import 'package:flutter/material.dart';

import '../../../domain/models/theme_settings.dart';

class ThemeState {
  final MyThemeMode themeMode;
  final Color accentColor;
  final double fontSize;
  final bool isLoading;
  final String? errorMessage;

  ThemeState({
    required this.themeMode,
    required this.accentColor,
    this.fontSize = 14,
    this.isLoading = false,
    this.errorMessage,
  });

  ThemeState copyWith({
    MyThemeMode? themeMode,
    Color? accentColor,
    double? fontSize,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      fontSize: fontSize ?? this.fontSize,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
