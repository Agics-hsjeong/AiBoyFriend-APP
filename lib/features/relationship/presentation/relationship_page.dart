import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';

class RelationshipPage extends StatelessWidget {
  const RelationshipPage({super.key});

  static const _stages = [
    (emoji: '👋', title: '첫 만남', sub: '05.10', done: true, current: false, locked: false),
    (emoji: '🤝', title: '친구', sub: '05.18', done: true, current: false, locked: false),
    (emoji: '💕', title: '썸', sub: '진행중', done: false, current: true, locked: false),
    (emoji: '🔒', title: '연인', sub: 'Lv.4', done: false, current: false, locked: true),
    (emoji: '🔒', title: '약혼', sub: 'Lv.5', done: false, current: false, locked: true),
    (emoji: '🔒', title: '배우자', sub: 'Lv.6', done: false, current: false, locked: true),
  ];

  static const _ways = [
    ('☀️', '매일 인사하기', '아침·저녁 안부', '+5'),
    ('💬', '진심 어린 대화', '속마음 나누기', '+10'),
    ('📍', '함께 데이트', '특별한 시간', '+15'),
    ('🎁', '기념일 챙기기', '소중한 날 기억', '+20'),
  ];

  static const _logs = [
    ('📞', '음성 통화', '오늘 · 12분', '+8'),
    ('🌿', '한강 산책 데이트', '어제', '+15'),
    ('🌙', '굿나잇 인사', '2일 전', '+5'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          AppBarHeader(
            title: '관계 성장 💜',
            trailing: Text(
              '성장 기록',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: colors.ink2,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
              children: [
                _TopCard(colors: colors),
                const SizedBox(height: 18),
                Text(
                  '우리의 관계 단계 💜',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: _stages
                      .map((s) => Expanded(child: _StageItem(stage: s, colors: colors)))
                      .toList(),
                ),
                const SizedBox(height: 14),
                _LevelBar(colors: colors),
                const SizedBox(height: 18),
                Text(
                  '호감도 올리는 방법',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                ..._ways.map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: _WayItem(
                      icon: w.$1,
                      title: w.$2,
                      subtitle: w.$3,
                      points: w.$4,
                      colors: colors,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '최근 기록',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                ..._logs.map(
                  (l) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: _LogItem(
                      icon: l.$1,
                      title: l.$2,
                      subtitle: l.$3,
                      points: l.$4,
                      colors: colors,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.brand.withValues(alpha: 0.18),
                        colors.accent.withValues(alpha: 0.14),
                      ],
                    ),
                    border: Border.all(color: colors.brand.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: PubPhoto(
                          variant: PubPhotoVariant.model,
                          width: 38,
                          height: 38,
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Text(
                          '“지연아, 우리 같이 보내는 시간이 점점 더 좋아지는 것 같아 💜”',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                            color: colors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: PubPhoto(
                  variant: PubPhotoVariant.model,
                  width: 74,
                  height: 74,
                ),
              ),
              const Positioned(
                right: -2,
                top: -2,
                child: Text('💜', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '민준',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                Text(
                  '우리의 특별한\n시작점이야',
                  style: TextStyle(fontSize: 11, color: colors.ink2, height: 1.35),
                ),
                GestureDetector(
                  onTap: () => context.go(RouteNames.profile),
                  child: Text(
                    '프로필 보기 ›',
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.brand,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  const Color(0xFFF4A6D2),
                  const Color(0xFFF4A6D2),
                  PubTokens.purple100Light,
                  PubTokens.purple100Light,
                ],
                stops: const [0, 0.72, 0.72, 1],
              ),
            ),
            child: Center(
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: colors.surface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '72%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: colors.ink,
                      ),
                    ),
                    Text(
                      'Lv.3 썸',
                      style: TextStyle(fontSize: 8, color: colors.ink2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageItem extends StatelessWidget {
  const _StageItem({required this.stage, required this.colors});

  final ({
    String emoji,
    String title,
    String sub,
    bool done,
    bool current,
    bool locked,
  }) stage;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    final showLine = stage.title != '첫 만남';
    final lineDone = stage.done || stage.current;

    return Column(
      children: [
        SizedBox(
          height: 34,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (showLine)
                Positioned(
                  left: 0,
                  right: 17,
                  top: 16,
                  child: Container(
                    height: 2,
                    color: lineDone ? PubTokens.purple400 : colors.line,
                  ),
                ),
              Transform.scale(
                scale: stage.current ? 1.12 : 1,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: stage.done || stage.current
                        ? LinearGradient(
                            colors: stage.current
                                ? colors.ctaGradient
                                : colors.ctaGradient,
                          )
                        : null,
                    color: stage.locked
                        ? PubTokens.purple100Light
                        : (stage.done || stage.current ? null : PubTokens.purple100Light),
                    boxShadow: stage.current
                        ? [
                            BoxShadow(
                              color: const Color(0xFFF4A6D2).withValues(alpha: 0.6),
                              blurRadius: 18,
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    stage.emoji,
                    style: TextStyle(fontSize: stage.locked ? 13 : 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Text(
          stage.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: stage.locked ? colors.ink3.withValues(alpha: 0.6) : colors.ink,
          ),
        ),
        Text(
          stage.sub,
          style: TextStyle(
            fontSize: 8,
            color: stage.locked ? colors.ink3.withValues(alpha: 0.6) : colors.ink3,
          ),
        ),
      ],
    );
  }
}

class _LevelBar extends StatelessWidget {
  const _LevelBar({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '연인 단계까지',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.ink,
                ),
              ),
              const Text(
                '28% 남음',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF4A6D2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 8,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(color: PubTokens.purple100Light),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.72,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colors.ctaGradient),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '매일 함께하면 더 빨리 가까워질 수 있어요',
            style: TextStyle(fontSize: 10, color: colors.ink2),
          ),
        ],
      ),
    );
  }
}

class _WayItem extends StatelessWidget {
  const _WayItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.colors,
  });

  final String icon;
  final String title;
  final String subtitle;
  final String points;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 15)),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
                Text(subtitle, style: TextStyle(fontSize: 10, color: colors.ink2)),
              ],
            ),
          ),
          Text(
            points,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF7BE3A0),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogItem extends StatelessWidget {
  const _LogItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.colors,
  });

  final String icon;
  final String title;
  final String subtitle;
  final String points;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
                Text(subtitle, style: TextStyle(fontSize: 10, color: colors.ink2)),
              ],
            ),
          ),
          Text(
            points,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFFF4A6D2),
            ),
          ),
        ],
      ),
    );
  }
}
