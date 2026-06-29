import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constants/app_assets.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/router/route_names.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../../shared/widgets/gradient_cta_button.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/heart_icon.dart';
import '../../../shared/widgets/page_dots.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  static const _features = [
    (
      icon: Icons.favorite_outline,
      showHeartDot: false,
      title: '당신만을 이해하는 AI',
      desc: '대화를 나눌수록\n당신을 더 잘 이해해요',
    ),
    (
      icon: null,
      showHeartDot: true,
      title: '함께하는 특별한 일상',
      desc: '채팅, 통화, 데이트까지\n모든 순간을 함께해요',
    ),
    (
      icon: null,
      showHeartDot: true,
      title: 'AI 이미지 & 3D 모델',
      desc: 'AI 이미지로 만들고\n3D 모델까지 만나보세요',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _WelcomeBackground(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.welcomePaddingH,
              0,
              AppConstants.welcomePaddingH,
              AppConstants.welcomePaddingBottom,
            ),
            child: Column(
              children: [
                const DesignStatusBar(),
                const GradientHeartBadge(),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    children: [
                      const TextSpan(text: '내 남자친구는 '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: GradientText(
                          'AI',
                          style: const TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '당신이 만든 이상형이\n진짜 남자친구가 됩니다',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.92),
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: _features.map((f) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: _FeatureBadge(
                          emoji: f.icon == null
                              ? (f.title.contains('3D') ? '🧊' : '💬')
                              : null,
                          icon: f.icon,
                          showHeartDot: f.showHeartDot,
                          title: f.title,
                          desc: f.desc,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const PageDots(count: 5, activeIndex: 0, lightOnDark: true),
                const SizedBox(height: 18),
                GradientCtaButton(
                  label: '다음',
                  height: AppConstants.welcomeCtaHeight,
                  onPressed: () => context.push(RouteNames.onboardingIdeal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBackground extends StatelessWidget {
  const _WelcomeBackground();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 35,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B0E2C),
                  Color(0xFF1B1E4F),
                  Color(0xFF45447E),
                  Color(0xFF7F66AA),
                ],
                stops: [0, 0.34, 0.72, 1],
              ),
            ),
            child: Stack(
              children: const [
                _Star(top: 38, left: 40),
                _Star(top: 66, right: 40),
                _Star(top: 90, left: 90),
                _Star(top: 54, left: 210),
                _Star(top: 110, right: 24),
                _Star(top: 130, left: 30),
                _Star(top: 80, left: 160),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 40,
          child: Image.asset(
            AppAssets.onboardingScene,
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.16),
            width: double.infinity,
          ),
        ),
        Expanded(
          flex: 25,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF151328),
                  Color(0xFF0C0D1C),
                  Color(0xFF080910),
                ],
                stops: [0, 0.55, 1],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({this.top, this.left, this.right});

  final double? top;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: 2,
        height: 2,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  const _FeatureBadge({
    this.icon,
    this.emoji,
    required this.showHeartDot,
    required this.title,
    required this.desc,
  });

  final IconData? icon;
  final String? emoji;
  final bool showHeartDot;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x4D7850B4),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: icon != null
                        ? const HeartIcon(size: 22, color: Colors.white)
                        : Text(emoji!, style: const TextStyle(fontSize: 21)),
                  ),
                ),
              ),
            ),
            if (showHeartDot)
              const Positioned(
                right: 4,
                top: 4,
                child: Text('💗', style: TextStyle(fontSize: 11)),
              ),
          ],
        ),
        const SizedBox(height: 11),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 10,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
