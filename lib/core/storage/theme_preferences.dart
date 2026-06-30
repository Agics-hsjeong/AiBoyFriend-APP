import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app_constants.dart';
import '../../app/theme/colors.dart';

class ThemePreferences {
  ThemePreferences(this._prefs);

  final SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  static Future<ThemePreferences> create() async {
    return ThemePreferences(await SharedPreferences.getInstance());
  }

  ThemeMode loadThemeMode() {
    final value = _prefs.getString(PrefKeys.themeMode);
    return switch (value) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  AccentColor loadAccentColor() {
    return AccentColor.fromStorage(_prefs.getString(PrefKeys.accentColor));
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return _prefs.setString(PrefKeys.themeMode, value);
  }

  Future<void> saveAccentColor(AccentColor accent) {
    return _prefs.setString(PrefKeys.accentColor, accent.storageValue);
  }
}

@immutable
class ThemeSettings {
  const ThemeSettings({
    required this.themeMode,
    required this.accentColor,
  });

  final ThemeMode themeMode;
  final AccentColor accentColor;

  static const defaults = ThemeSettings(
    themeMode: ThemeMode.light,
    accentColor: AccentColor.purple,
  );

  ThemeSettings copyWith({
    ThemeMode? themeMode,
    AccentColor? accentColor,
  }) {
    return ThemeSettings(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}
