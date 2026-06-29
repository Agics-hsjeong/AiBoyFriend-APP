import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_theme.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/theme_controller.dart';

/// B그룹 몰입형 화면 래퍼 — 사용자 ThemeMode와 무관하게 darkFixed 적용
class ImmersiveTheme extends ConsumerWidget {
  const ImmersiveTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(themeSettingsProvider);
    final accent = settings.value?.accentColor ?? AccentColor.purple;

    return Theme(
      data: AppTheme.darkFixed(accent),
      child: child,
    );
  }
}
