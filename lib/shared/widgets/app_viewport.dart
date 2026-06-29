import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';

/// 퍼블리싱 캔버스(390×844) 기준으로 레이아웃을 맞추고,
/// Android/iOS 시스템 네비게이션 바 영역을 하단에 확보합니다.
class AppViewport extends StatelessWidget {
  const AppViewport({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final outer = MediaQuery.of(context);
    final scale = outer.size.width / AppConstants.designWidth;
    final bottomInset = outer.viewPadding.bottom / scale;
    final canvasHeight = AppConstants.designHeight - bottomInset;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: AppConstants.designWidth,
          height: AppConstants.designHeight,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: MediaQuery(
              data: outer.copyWith(
                size: Size(AppConstants.designWidth, canvasHeight),
                padding: EdgeInsets.only(bottom: bottomInset),
                viewPadding: EdgeInsets.only(
                  top: math.max(
                    AppConstants.statusBarHeight,
                    outer.viewPadding.top / scale,
                  ),
                  bottom: bottomInset,
                ),
                viewInsets: EdgeInsets.zero,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
