import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  static const _plans = [
    (
      emoji: '🌸',
      name: 'Warm Plus',
      duration: '7일 구독',
      price: '₩4,900',
      unit: '주당',
      ribbon: null,
      best: false,
      features: [
        '최대 온기 2,000',
        '하루 4회 자동 회복',
        '광고 제거 · 고급 AI 모델',
        '장기 기억',
      ],
      warmTag: null,
    ),
    (
      emoji: '💖',
      name: 'Warm Premium',
      duration: '15일 구독',
      price: '₩8,900',
      unit: '2주당',
      ribbon: '🔥 인기',
      best: false,
      features: [
        '최대 온기 3,000',
        '모든 AI 모델',
        '음성·사진 생성 할인',
        '특별 데이트',
      ],
      warmTag: null,
    ),
    (
      emoji: '👑',
      name: 'Warm Signature',
      duration: '30일 구독',
      price: '₩14,900',
      unit: '월당',
      ribbon: '👑 베스트',
      best: true,
      features: [
        '최대 온기 5,000',
        '최고급 AI 모델 · AI 우선 응답',
        '무제한 장기 기억',
        '한정 의상 · 특별 이벤트',
        '신규 기능 우선 체험',
      ],
      warmTag: '🔥 하루 4회 최대치까지 자동 회복',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          AppBarHeader(
            title: '구독 플랜 💖',
            trailing: Text(
              '복원',
              style: TextStyle(fontSize: 12, color: colors.ink3),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text(
                        '온기를 매일 채우세요 💖',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                          color: colors.ink,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '구독하면 하루 4회 온기가 자동 회복되고\n더 많은 기능을 누릴 수 있어요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.5,
                          color: colors.ink2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ..._plans.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _PlanCard(plan: p, colors: colors),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.line)),
            ),
            child: Column(
              children: [
                GradientCtaButton(
                  label: '👑 Warm Signature 시작하기',
                  height: 54,
                  onPressed: () => context.pop(),
                ),
                const SizedBox(height: 8),
                Text(
                  '구독은 언제든 해지할 수 있어요 · 자동 갱신',
                  style: TextStyle(fontSize: 10, color: colors.ink3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.colors});

  final ({
    String emoji,
    String name,
    String duration,
    String price,
    String unit,
    String? ribbon,
    bool best,
    List<String> features,
    String? warmTag,
  }) plan;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: plan.best ? PubTokens.purple400 : colors.line,
          width: plan.best ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (plan.best)
            BoxShadow(
              color: PubTokens.purple400.withValues(alpha: 0.25),
              blurRadius: 28,
              offset: const Offset(0, 12),
            )
          else
            PubTokens.shadowCard,
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (plan.ribbon != null)
            Positioned(
              top: -10,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors.ctaGradient),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  plan.ribbon!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: PubTokens.purple100Light,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(plan.emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: colors.ink,
                          ),
                        ),
                        Text(
                          plan.duration,
                          style: TextStyle(fontSize: 11, color: colors.ink3),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan.price,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: colors.ink,
                        ),
                      ),
                      Text(
                        plan.unit,
                        style: TextStyle(fontSize: 11, color: colors.ink3),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 13),
              ...plan.features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: plan.best
                              ? LinearGradient(colors: colors.ctaGradient)
                              : null,
                          color: plan.best ? null : PubTokens.purple100Light,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '✓',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: plan.best ? Colors.white : PubTokens.purple600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          f,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: colors.ink2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (plan.warmTag != null) ...[
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4A06A).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    plan.warmTag!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFF4A06A),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
