import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme(SemanticPalette semantic, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;

    return base.copyWith(
      bodyLarge: base.bodyLarge?.copyWith(
        color: semantic.ink,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: semantic.ink2,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: semantic.ink3,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: semantic.ink,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: semantic.ink,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
