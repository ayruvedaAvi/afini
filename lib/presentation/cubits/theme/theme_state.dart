import 'package:flutter/material.dart';

import '../../../domain/models/theme_settings.dart';

class ThemeState {
  final MyThemeMode themeMode;
  final Color accentColor;
  final bool isLoading;
  final String? errorMessage;
  
  ThemeState({
    required this.themeMode,
    required this.accentColor,
    this.isLoading = false,
    this.errorMessage,
  });
  
  ThemeState copyWith({
    MyThemeMode? themeMode,
    Color? accentColor,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}