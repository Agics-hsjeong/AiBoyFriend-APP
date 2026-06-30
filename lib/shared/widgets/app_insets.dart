import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';

/// edge-to-edge 레이아웃에서 탭·시스템 바 높이를 계산합니다.
extension AppInsets on BuildContext {
  double get systemBottomInset => MediaQuery.viewPaddingOf(this).bottom;

  /// 메인 5탭 하단 바 + 시스템 네비게이션 바
  double get mainTabBottomInset =>
      AppConstants.tabBarHeight + systemBottomInset;

  /// 메인 탭 화면 스크롤 하단 여백 (탭바 + 액션바 여유)
  double get mainScrollBottomPadding => mainTabBottomInset + 16;
}
