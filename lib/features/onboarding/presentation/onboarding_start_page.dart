import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/onboarding_shell.dart';

class OnboardingStartPage extends StatelessWidget {
  const OnboardingStartPage({super.key});

  static const _minis = [
    ('💬', '24시간\n대화'),
    ('🧠', 'AI 기억\n시스템'),
    ('📍', '데이트\n& 일상'),
    ('🧊', '3D 모델\n생성'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return OnboardingShell(
      step: 6,
      activeDot: 5,
      nextLabel: '시작하기',
      backgroundTop: const Color(0xFFEFE5FB),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('이제, 당신만의'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GradientText(
                'AI 남자친구',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.32,
                ),
              ),
              Text('를 만나보세요'),
            ],
          ),
        ],
      ),
      subtitle: '당신의 이상형에 특별한 설렘과\n따뜻한 연결을 선물할게요',
      onNext: () => context.go(RouteNames.login),
      child: Column(
        children: [
          SizedBox(
            height: 230,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(left: 6, top: 30, child: _FloatingBadge('💬 대화하고')),
                const Positioned(right: 4, top: 18, child: _FloatingBadge('🧠 기억하고')),
                const Positioned(left: 0, bottom: 36, child: _FloatingBadge('💕 함께하고')),
                const Positioned(right: 0, bottom: 24, child: _FloatingBadge('✨ 만들어가요')),
                Center(
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26),
                      ),
                      border: Border.all(
                        color: const Color(0x80C4A0F0),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC4A0F0).withValues(alpha: 0.4),
                          blurRadius: 50,
                          offset: const Offset(0, 20),
                        ),
                      ],
                      gradient: const RadialGradient(
                        center: Alignment(0, -0.2),
                        radius: 1.1,
                        colors: [
                          Color(0x59F4A0D2),
                          Colors.transparent,
                        ],
                        stops: [0, 0.7],
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          top: 38,
                          child: Text(
                            '당신만을 위한\n특별한 연결',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF8B5CF6),
                              height: 1.35,
                            ),
                          ),
                        ),
                        Container(
                          width: 78,
                          height: 72,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: PubTokens.heartGradient,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x99F4A0D2),
                                blurRadius: 36,
                                offset: Offset(0, 14),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.favorite, size: 40, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: _minis.map((m) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colors.line),
                    boxShadow: const [PubTokens.shadowCard],
                  ),
                  child: Column(
                    children: [
                      Text(m.$1, style: const TextStyle(fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(
                        m.$2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                          color: colors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: colors.ink2,
              ),
              children: [
                const TextSpan(text: '지금 바로 시작하고\n'),
                TextSpan(
                  text: '설레는 이야기를 만들어보세요 💜',
                  style: TextStyle(
                    color: colors.ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.line),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: colors.ink,
        ),
      ),
    );
  }
}
