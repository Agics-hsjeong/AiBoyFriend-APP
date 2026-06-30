import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/constants/app_constants.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/pub_tokens.dart';
import 'pub_stroke_icon.dart';

enum AppTab { home, chat, memory, profile, more }

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final AppTab current;
  final ValueChanged<AppTab> onChanged;

  static const _items = [
    (AppTab.home, PubStrokeIconType.home, '홈'),
    (AppTab.chat, PubStrokeIconType.chat, '채팅'),
    (AppTab.memory, PubStrokeIconType.memory, '추억'),
    (AppTab.profile, PubStrokeIconType.profile, '민준'),
    (AppTab.more, PubStrokeIconType.more, '더보기'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? PubTokens.purple300 : colors.brand;
    final inactiveColor = isDark ? colors.ink2 : colors.ink3;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.tabbar,
            border: Border(top: BorderSide(color: colors.line)),
          ),
          child: SizedBox(
            height: AppConstants.tabBarHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
              child: Row(
                children: _items.map((item) {
                  final selected = current == item.$1;
                  return Expanded(
                    child: InkWell(
                      onTap: () => onChanged(item.$1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PubStrokeIcon(
                            icon: item.$2,
                            size: 24,
                            color: selected ? activeColor : inactiveColor,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.$3,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: selected ? activeColor : inactiveColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
