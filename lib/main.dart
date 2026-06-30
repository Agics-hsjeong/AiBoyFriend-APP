import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/theme/theme_controller.dart';
import 'core/storage/app_session.dart';
import 'core/storage/theme_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  final themePrefs = await ThemePreferences.create();
  final appSession = AppSession(themePrefs.prefs);
  await appSession.migrateLegacyFlags();

  runApp(
    ProviderScope(
      overrides: [
        themePreferencesProvider.overrideWithValue(themePrefs),
        appSessionProvider.overrideWithValue(appSession),
      ],
      child: const AiBoyfriendApp(),
    ),
  );
}
