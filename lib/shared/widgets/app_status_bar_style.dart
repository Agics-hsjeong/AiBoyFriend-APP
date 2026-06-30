import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 실제 OS 상태표시바 아이콘 색만 맞춥니다. 가짜 9:41 UI는 그리지 않습니다.
class AppStatusBarStyle extends StatelessWidget {
  const AppStatusBarStyle({
    super.key,
    required this.lightIcons,
    required this.child,
  });

  /// true → 밝은 배경 위 어두운 아이콘, false → 어두운 배경 위 밝은 아이콘
  final bool lightIcons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final overlay = lightIcons
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: child,
    );
  }
}
