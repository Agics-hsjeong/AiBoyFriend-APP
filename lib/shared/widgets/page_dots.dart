import 'package:flutter/material.dart';

import '../../app/theme/pub_tokens.dart';

class PageDots extends StatelessWidget {
  const PageDots({
    super.key,
    required this.count,
    required this.activeIndex,
    this.lightOnDark = false,
  });

  final int count;
  final int activeIndex;
  final bool lightOnDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: active ? 22 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: active
                ? (lightOnDark
                    ? const Color(0xFFC79AF0)
                    : PubTokens.purple400)
                : (lightOnDark
                    ? Colors.white.withValues(alpha: 0.32)
                    : PubTokens.purple200),
          ),
        );
      }),
    );
  }
}
