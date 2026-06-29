import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_theme.dart';
import 'design_status_bar.dart';

/// 퍼블 `.appbar` + `.statusbar`
class AppBarHeader extends StatelessWidget {
  const AppBarHeader({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.centerTitle = true,
    this.onBack,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool centerTitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        const DesignStatusBar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Row(
            children: [
              leading ??
                  _BackButton(
                    onTap: onBack ?? () => context.pop(),
                    colors: colors,
                  ),
              Expanded(
                child: Text(
                  title,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
              ),
              trailing ?? const SizedBox(width: 38),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap, required this.colors});

  final VoidCallback onTap;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.brand.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(Icons.arrow_back_ios_new, size: 16, color: colors.ink),
        ),
      ),
    );
  }
}
