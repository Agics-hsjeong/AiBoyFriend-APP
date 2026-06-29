import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors.dart';
import '../../core/storage/theme_preferences.dart';

final themePreferencesProvider = Provider<ThemePreferences>((ref) {
  throw UnimplementedError('ThemePreferences must be overridden in main()');
});

final themeSettingsProvider =
    AsyncNotifierProvider<ThemeSettingsController, ThemeSettings>(
  ThemeSettingsController.new,
);

class ThemeSettingsController extends AsyncNotifier<ThemeSettings> {
  @override
  Future<ThemeSettings> build() async {
    final prefs = ref.read(themePreferencesProvider);
    return ThemeSettings(
      themeMode: prefs.loadThemeMode(),
      accentColor: prefs.loadAccentColor(),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final current = state.value ?? ThemeSettings.defaults;
    state = AsyncData(current.copyWith(themeMode: mode));
    await ref.read(themePreferencesProvider).saveThemeMode(mode);
  }

  Future<void> setAccentColor(AccentColor accent) async {
    final current = state.value ?? ThemeSettings.defaults;
    state = AsyncData(current.copyWith(accentColor: accent));
    await ref.read(themePreferencesProvider).saveAccentColor(accent);
  }
}
