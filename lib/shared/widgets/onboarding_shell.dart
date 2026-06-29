import 'package:flutter/material.dart';

import '../../app/constants/app_assets.dart';
import '../../app/constants/app_constants.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/pub_tokens.dart';
import 'design_status_bar.dart';
import 'gradient_cta_button.dart';
import 'page_dots.dart';

/// 온보딩 02~06 공통 레이아웃 — 퍼블 `.wrap` 구조
class OnboardingShell extends StatelessWidget {
  const OnboardingShell({
    super.key,
    required this.step,
    required this.activeDot,
    required this.title,
    required this.subtitle,
    required this.onNext,
    required this.child,
    this.nextLabel = '다음',
    this.backgroundTop,
  });

  final int step;
  final int activeDot;
  final Widget title;
  final String subtitle;
  final VoidCallback onNext;
  final Widget child;
  final String nextLabel;
  final Color? backgroundTop;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -1),
            radius: 1.4,
            colors: Theme.of(context).brightness == Brightness.dark
                ? [const Color(0xFF241C45), colors.bg]
                : [backgroundTop ?? const Color(0xFFEFE9FB), colors.bg],
            stops: const [0, 0.6],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.onboardingPaddingH,
            0,
            AppConstants.onboardingPaddingH,
            AppConstants.onboardingPaddingBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DesignStatusBar(),
              Text(
                OnboardingFlow.counterLabel(step),
                style: const TextStyle(
                  color: PubTokens.purple400,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.32,
                  letterSpacing: -0.4,
                  color: colors.ink,
                ),
                child: title,
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(
                  color: colors.ink2,
                  fontSize: 13.5,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: child),
              const SizedBox(height: 16),
              PageDots(count: OnboardingFlow.totalSteps, activeIndex: activeDot),
              const SizedBox(height: 14),
              GradientCtaButton(label: nextLabel, onPressed: onNext),
            ],
          ),
        ),
      ),
    );
  }
}
