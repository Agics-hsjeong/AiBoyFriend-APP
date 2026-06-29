import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/onboarding_shell.dart';

class Onboarding3dPage extends StatelessWidget {
  const Onboarding3dPage({super.key});

  static const _features = [
    ('🖼️', 'AI 이미지 생성', '이상형을 사진으로'),
    ('🧊', '3D 모델 생성', 'Meshy 기반 자동 변환'),
    ('🔄', '360° 뷰어', '모든 각도로 회전'),
    ('😊', '모션 & 표정', '포즈·표정 변경'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return OnboardingShell(
      step: 5,
      activeDot: 4,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('AI 이미지부터'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GradientText(
                '3D 모델',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.32,
                ),
              ),
              Text('까지 완벽하게'),
            ],
          ),
        ],
      ),
      subtitle: 'AI가 상상한 모습을 현실로 만들고\n다양한 각도에서 만나보세요',
      onNext: () => context.push(RouteNames.onboardingStart),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 47,
              child: Column(
                children: [
                  for (var i = 0; i < _features.length; i++) ...[
                    _FeatureTile(
                      emoji: _features[i].$1,
                      title: _features[i].$2,
                      subtitle: _features[i].$3,
                      colors: colors,
                    ),
                    if (i < _features.length - 1) const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 53,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colors.line),
                        boxShadow: const [PubTokens.shadowCard],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const PubPhoto(variant: PubPhotoVariant.body),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 10,
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Color(0x99A78BFA),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(3, (i) {
                      return Expanded(
                        child: Container(
                          height: 56,
                          margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colors.line),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: const PubPhoto(
                            variant: PubPhotoVariant.body,
                            alignment: Alignment(0, -0.2),
                          ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.colors,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.line),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: PubTokens.purple100Light,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10.5, color: colors.ink3, height: 1.4),
          ),
        ],
      ),
    );
  }
}
