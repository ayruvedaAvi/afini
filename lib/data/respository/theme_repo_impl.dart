import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/shared_preferences.dart';
import '../../domain/models/theme_settings.dart';
import '../../domain/repository/theme_repo.dart';

class ThemeRepositoryImpl implements ThemeRepo {
  
  ThemeRepositoryImpl();
  
  static const String _themeModeKey = 'theme_mode';
  static const String _accentColorKey = 'accent_color';
  
  final _themeSettingsController = StreamController<ThemeSettings>.broadcast();
  
  @override
  Future<ThemeSettings> getThemeSettings() async {
    final themeMode = MyThemeMode.values[
      await getIntData(_themeModeKey) ?? MyThemeMode.system.index
    ];
    final accentColorValue = await getIntData(_accentColorKey) ?? Colors.purple.value;
    
    return ThemeSettings(
      themeMode: themeMode,
      accentColor: Color(accentColorValue),
    );
  }
  
  @override
  Future<void> saveThemeSettings(ThemeSettings settings) async {
    await setIntData(_themeModeKey, settings.themeMode.index);
    await setIntData(_accentColorKey, settings.accentColor.value);
    _themeSettingsController.add(settings);
  }
  
  @override
  Stream<ThemeSettings> observeThemeSettings() {
    // Initial load
    getThemeSettings().then((settings) {
      _themeSettingsController.add(settings);
    });
    
    return _themeSettingsController.stream;
  }
}