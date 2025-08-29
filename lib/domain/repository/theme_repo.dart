import '../models/theme_settings.dart';

abstract class ThemeRepo {
  Future<ThemeSettings> getThemeSettings();
  Future<void> saveThemeSettings(ThemeSettings settings);
  Stream<ThemeSettings> observeThemeSettings();
}