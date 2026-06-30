import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';

/// 디자인 기준 너비(390) 중앙 정렬 + 시스템 네비게이션 바(홈 인디케이터) 영역 확보.
/// edge-to-edge 모드에서도 하단 UI가 가려지지 않도록 캔버스 높이를 줄입니다.
class AppViewport extends StatelessWidget {
  const AppViewport({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final outer = MediaQuery.of(context);
    final width = outer.size.width.clamp(0.0, AppConstants.designWidth);
    final sideInset = ((outer.size.width - width) / 2).clamp(0.0, double.infinity);
    final bottomInset = outer.viewPadding.bottom;
    final contentHeight = outer.size.height - bottomInset;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: sideInset,
          right: sideInset,
          bottom: bottomInset,
        ),
        child: MediaQuery(
          data: outer.copyWith(
            size: Size(width, contentHeight),
            padding: outer.padding.copyWith(bottom: 0),
            viewPadding: outer.viewPadding.copyWith(bottom: 0),
            viewInsets: EdgeInsets.zero,
          ),
          child: SizedBox(
            width: width,
            height: contentHeight,
            child: child,
          ),
        ),
      ),
    );
  }
}
