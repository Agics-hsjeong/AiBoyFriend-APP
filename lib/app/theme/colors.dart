import 'package:flutter/material.dart';

/// 포인트 컬러 프리셋 — 08 THEME_SYSTEM.md §2
enum AccentColor {
  purple,
  pink,
  blue,
  green;

  String get storageValue => name;

  static AccentColor fromStorage(String? value) {
    return AccentColor.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AccentColor.purple,
    );
  }
}

/// 브랜드 팔레트 (accent별)
@immutable
class BrandPalette {
  const BrandPalette({
    required this.brand,
    required this.brand2,
    required this.accent,
    required this.ctaGradient,
  });

  final Color brand;
  final Color brand2;
  final Color accent;
  final List<Color> ctaGradient;

  static BrandPalette forAccent(AccentColor accent) => switch (accent) {
        AccentColor.purple => const BrandPalette(
              brand: Color(0xFF8B5CF6),
              brand2: Color(0xFFC084FC),
              accent: Color(0xFFF472B6),
              ctaGradient: [
                Color(0xFFA78BFA),
                Color(0xFFC084FC),
                Color(0xFFF0A6D8),
              ],
            ),
        AccentColor.pink => const BrandPalette(
              brand: Color(0xFFEC4899),
              brand2: Color(0xFFF472B6),
              accent: Color(0xFFFB7185),
              ctaGradient: [
                Color(0xFFF472B6),
                Color(0xFFEC4899),
                Color(0xFFFDA4AF),
              ],
            ),
        AccentColor.blue => const BrandPalette(
              brand: Color(0xFF3B82F6),
              brand2: Color(0xFF60A5FA),
              accent: Color(0xFF38BDF8),
              ctaGradient: [
                Color(0xFF60A5FA),
                Color(0xFF3B82F6),
                Color(0xFF7DD3FC),
              ],
            ),
        AccentColor.green => const BrandPalette(
              brand: Color(0xFF10B981),
              brand2: Color(0xFF34D399),
              accent: Color(0xFF6EE7B7),
              ctaGradient: [
                Color(0xFF34D399),
                Color(0xFF10B981),
                Color(0xFF6EE7B7),
              ],
            ),
      };
}

/// 라이트/다크 시맨틱 토큰 — 08 THEME_SYSTEM.md §3
@immutable
class SemanticPalette {
  const SemanticPalette({
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.line,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.tabbar,
  });

  final Color bg;
  final Color surface;
  final Color surface2;
  final Color line;
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color tabbar;

  static const light = SemanticPalette(
    bg: Color(0xFFF3F0FB),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFFAF8FF),
    line: Color(0xFFECE7F7),
    ink: Color(0xFF2A2440),
    ink2: Color(0xFF6B6385),
    ink3: Color(0xFFA7A0BD),
    tabbar: Color(0xEBFFFFFF),
  );

  static const dark = SemanticPalette(
    bg: Color(0xFF140E2B),
    surface: Color(0xFF211A40),
    surface2: Color(0x0FFFFFFF),
    line: Color(0x14FFFFFF),
    ink: Color(0xFFF4F1FF),
    ink2: Color(0xFFB8B0D6),
    ink3: Color(0xFF8B83A8),
    tabbar: Color(0xEB18122E),
  );
}
