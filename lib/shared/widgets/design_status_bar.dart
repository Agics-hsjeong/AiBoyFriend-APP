import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';

/// 퍼블 `.statusbar` — 52px 스테이터스바 영역
class DesignStatusBar extends StatelessWidget {
  const DesignStatusBar({super.key, this.onDark = false});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppConstants.statusBarHeight);
  }
}
