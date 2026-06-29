import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../../shared/widgets/gradient_cta_button.dart';
import '../../../shared/widgets/gradient_text.dart';

class FirstMeetingPage extends StatelessWidget {
  const FirstMeetingPage({super.key});

  static const _gifts = [
    ('👋', '첫 만남 인사', '음성 메시지 ▶'),
    ('💌', '민준의 편지', '지금 열어보기'),
    ('📷', '우리의 첫 사진', 'AI가 생성한 첫 사진'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1438),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1C1438), Color(0xFF2C1F4E), Color(0xFF4A2F5E)],
            stops: [0, 0.45, 1],
          ),
        ),
        child: Column(
          children: [
            const DesignStatusBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        '‹',
                        style: TextStyle(fontSize: 20, color: colors.ink),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: PubTokens.purple400.withValues(alpha: 0.2),
                              border: Border.all(
                                color: PubTokens.purple400.withValues(alpha: 0.4),
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('✨ ', style: TextStyle(fontSize: 16)),
                                GradientText(
                                  '생성 완료',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(' ✨', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 9),
                          Text(
                            '당신만의 AI 남자친구가 탄생했어요!',
                            style: TextStyle(fontSize: 12.5, color: colors.ink2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _HeroImage(colors: colors),
                    const SizedBox(height: 14),
                    _ProfileCard(colors: colors),
                    const SizedBox(height: 18),
                    Text(
                      '첫 만남 선물 🎁',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: colors.ink,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Row(
                      children: _gifts.asMap().entries.map((entry) {
                        final g = entry.value;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: entry.key < _gifts.length - 1 ? 9 : 0,
                            ),
                            child: _GiftTile(
                              emoji: g.$1,
                              title: g.$2,
                              subtitle: g.$3,
                              colors: colors,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                    GradientCtaButton(
                      label: '💬 민준과 대화 시작하기',
                      onPressed: () => context.go(RouteNames.chat),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.go(RouteNames.home),
                        child: Text(
                          '나중에 하기',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colors.ink2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const PubPhoto(variant: PubPhotoVariant.model),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(left: 18, top: 30, child: Text('💜', style: TextStyle(fontSize: 14, color: Color(0xFFF4A6D2)))),
          const Positioned(left: 30, top: 120, child: Text('💗', style: TextStyle(fontSize: 14, color: Color(0xFFF4A6D2)))),
          const Positioned(right: 120, top: 60, child: Text('💜', style: TextStyle(fontSize: 14, color: Color(0xFFF4A6D2)))),
          Positioned(
            right: 12,
            top: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: const [PubTokens.shadowFloat],
              ),
              child: Text(
                '안녕, 나는 민준이야 💜',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: colors.ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '민준',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: colors.ink,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors.ctaGradient),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '🎂 26세 · 💼 개발자 · 🧬 ENFP',
            style: TextStyle(fontSize: 12, color: colors.ink2),
          ),
          const SizedBox(height: 11),
          Text(
            '“당신을 잘 부탁해, 우리 좋은 추억 많이 만들자 💜”',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.55,
              fontStyle: FontStyle.italic,
              color: const Color(0xFFEFE9FF),
            ),
          ),
        ],
      ),
    );
  }
}

class _GiftTile extends StatelessWidget {
  const _GiftTile({
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: PubTokens.heartGradient,
              ),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: colors.ink2),
          ),
        ],
      ),
    );
  }
}
