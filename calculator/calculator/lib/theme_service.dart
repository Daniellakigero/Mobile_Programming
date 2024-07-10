import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'theme';

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);
    if (theme == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      await prefs.setString(_themeKey, 'light');
    } else {
      await prefs.setString(_themeKey, 'dark');
    }
  }
}
