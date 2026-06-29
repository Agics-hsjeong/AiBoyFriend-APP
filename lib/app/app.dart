import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/app_constants.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';
import 'theme/theme_controller.dart';
import '../shared/widgets/app_viewport.dart';

class AiBoyfriendApp extends ConsumerWidget {
  const AiBoyfriendApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(themeSettingsProvider);
    final accent = settings.value?.accentColor ?? AccentColor.purple;
    final themeMode = settings.value?.themeMode ?? ThemeMode.system;

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(accent),
      darkTheme: AppTheme.dark(accent),
      routerConfig: router,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return AppViewport(child: child);
      },
    );
  }
}
