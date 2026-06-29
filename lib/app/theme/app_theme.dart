import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

/// 시맨틱 + 브랜드 토큰 — CSS var(--bg) 등과 1:1 대응
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.line,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.tabbar,
    required this.brand,
    required this.brand2,
    required this.accent,
    required this.ctaGradient,
  });

  final Color bg;
  final Color surface;
  final Color surface2;
  final Color line;
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color tabbar;
  final Color brand;
  final Color brand2;
  final Color accent;
  final List<Color> ctaGradient;

  factory AppColorTokens.from({
    required SemanticPalette semantic,
    required BrandPalette brand,
  }) {
    return AppColorTokens(
      bg: semantic.bg,
      surface: semantic.surface,
      surface2: semantic.surface2,
      line: semantic.line,
      ink: semantic.ink,
      ink2: semantic.ink2,
      ink3: semantic.ink3,
      tabbar: semantic.tabbar,
      brand: brand.brand,
      brand2: brand.brand2,
      accent: brand.accent,
      ctaGradient: brand.ctaGradient,
    );
  }

  @override
  AppColorTokens copyWith({
    Color? bg,
    Color? surface,
    Color? surface2,
    Color? line,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? tabbar,
    Color? brand,
    Color? brand2,
    Color? accent,
    List<Color>? ctaGradient,
  }) {
    return AppColorTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      line: line ?? this.line,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      tabbar: tabbar ?? this.tabbar,
      brand: brand ?? this.brand,
      brand2: brand2 ?? this.brand2,
      accent: accent ?? this.accent,
      ctaGradient: ctaGradient ?? this.ctaGradient,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      line: Color.lerp(line, other.line, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      ink3: Color.lerp(ink3, other.ink3, t)!,
      tabbar: Color.lerp(tabbar, other.tabbar, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      brand2: Color.lerp(brand2, other.brand2, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      ctaGradient: ctaGradient,
    );
  }
}

abstract final class AppTheme {
  static ThemeData light(AccentColor accent) =>
      _build(Brightness.light, accent);

  static ThemeData dark(AccentColor accent) => _build(Brightness.dark, accent);

  /// B그룹 몰입형 — 사용자 ThemeMode와 무관하게 항상 다크
  static ThemeData darkFixed(AccentColor accent) =>
      _build(Brightness.dark, accent);

  static ThemeData _build(Brightness brightness, AccentColor accent) {
    final semantic =
        brightness == Brightness.dark ? SemanticPalette.dark : SemanticPalette.light;
    final brand = BrandPalette.forAccent(accent);
    final tokens = AppColorTokens.from(semantic: semantic, brand: brand);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: semantic.bg,
      fontFamily: 'Pretendard',
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: brand.brand,
        onPrimary: Colors.white,
        secondary: brand.accent,
        onSecondary: Colors.white,
        error: const Color(0xFFFF6B7A),
        onError: Colors.white,
        surface: semantic.surface,
        onSurface: semantic.ink,
      ),
      dividerColor: semantic.line,
      appBarTheme: AppBarTheme(
        backgroundColor: semantic.bg,
        foregroundColor: semantic.ink,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: semantic.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: semantic.line),
        ),
      ),
      textTheme: AppTypography.textTheme(semantic, brightness),
      extensions: [tokens],
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColorTokens get appColors =>
      Theme.of(this).extension<AppColorTokens>()!;
}
