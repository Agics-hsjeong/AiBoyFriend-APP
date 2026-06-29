import 'package:flutter/material.dart';

/// 퍼블 `03 퍼블리싱/css/app.css` 와 화면별 인라인 스타일 값
abstract final class PubTokens {
  // Extended palette
  static const purple50Light = Color(0xFFF5F3FF);
  static const purple50Dark = Color(0xFF241C40);
  static const purple100Light = Color(0xFFEDE9FE);
  static const purple200 = Color(0xFFDDD6FE);
  static const purple300 = Color(0xFFC4B5FD);
  static const purple400 = Color(0xFFA78BFA);
  static const purple600 = Color(0xFF7C3AED);

  /// 퍼블 `--grad-heart` (purple accent)
  static const heartGradient = [Color(0xFFC4B5FD), Color(0xFFF0A6D8)];

  // Screen backgrounds (퍼블 `.app` 오버라이드)
  static const homeBg = Color(0xFFEFEBF8);
  static const chatBg = Color(0xFFF2EDFB);

  // Shadows
  static const shadowCard = BoxShadow(
    color: Color(0x147C3AED),
    blurRadius: 30,
    offset: Offset(0, 10),
  );
  static const shadowCta = BoxShadow(
    color: Color(0x73A78BFA),
    blurRadius: 26,
    offset: Offset(0, 12),
  );
  static const shadowFloat = BoxShadow(
    color: Color(0x2E2B2150),
    blurRadius: 40,
    offset: Offset(0, 18),
  );

  static Color purple50(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? purple50Dark
          : purple50Light;
}
