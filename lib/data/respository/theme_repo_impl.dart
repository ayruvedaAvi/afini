import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/shared_preferences.dart';
import '../../domain/models/theme_settings.dart';
import '../../domain/repository/theme_repo.dart';

class ThemeRepositoryImpl implements ThemeRepo {
  ThemeRepositoryImpl();

  static const String _themeModeKey = 'theme_mode';
  static const String _accentColorKey = 'accent_color';
  static const String _fontSizeKey = 'font_size';

  final _themeSettingsController = StreamController<ThemeSettings>.broadcast();

  @override
  Future<ThemeSettings> getThemeSettings() async {
    final themeMode = MyThemeMode
        .values[await getIntData(_themeModeKey) ?? MyThemeMode.system.index];
    final accentColorValue =
        await getIntData(_accentColorKey) ?? Colors.purple.toARGB32();
    final fontSize = await getDoubleData(_fontSizeKey) ?? 16.0;

    return ThemeSettings(
      themeMode: themeMode,
      accentColor: Color(accentColorValue),
      fontSize: fontSize,
    );
  }

  @override
  Future<void> saveThemeSettings(ThemeSettings settings) async {
    await setIntData(_themeModeKey, settings.themeMode.index);
    await setIntData(_accentColorKey, settings.accentColor.toARGB32());
    await setDoubleData(_fontSizeKey, settings.fontSize);
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
