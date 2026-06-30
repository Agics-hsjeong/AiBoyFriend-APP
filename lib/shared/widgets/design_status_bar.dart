import 'package:flutter/material.dart';

/// 시스템 상태표시바 아래 콘텐츠가 겹치지 않도록 상단 safe area만 확보합니다.
/// 퍼블 HTML의 장식용 9:41 바는 실제 앱에서 사용하지 않습니다.
class DesignStatusBar extends StatelessWidget {
  const DesignStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    if (top <= 0) return const SizedBox.shrink();
    return SizedBox(height: top);
  }
}
