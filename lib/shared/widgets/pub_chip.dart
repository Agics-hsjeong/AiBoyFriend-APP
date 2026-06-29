import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

/// 퍼블 `.chip` / `.tabs .chip`
class PubChip extends StatelessWidget {
  const PubChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          gradient: selected ? LinearGradient(colors: colors.ctaGradient) : null,
          color: selected ? null : colors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? Colors.transparent : colors.line,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : colors.ink2,
          ),
        ),
      ),
    );
  }
}

/// 퍼블 `.actionbar` — 하단 고정 블러 바
class PubBottomActionBar extends StatelessWidget {
  const PubBottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.94),
            border: Border(top: BorderSide(color: colors.line)),
          ),
          child: child,
        ),
      ),
    );
  }
}
