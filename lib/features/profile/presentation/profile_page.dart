import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_insets.dart';
import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/pub_chip.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _keywords = [
    '다정함',
    '유머러스',
    '적극적',
    '배려심 깊은',
    '솔직한',
    '긍정적인',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: PubTokens.chatBg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _ProfileHero(colors: colors)),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(18, 4, 18, context.mainTabBottomInset + 72),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                _InfoCard(colors: colors),
                const SizedBox(height: 11),
                _ModelViewerEntry(colors: colors),
                _FavorCard(colors: colors),
                const SizedBox(height: 18),
                _SectionTitle(title: 'About 민준', colors: colors),
                const SizedBox(height: 9),
                _AboutCard(colors: colors),
                const SizedBox(height: 18),
                _SectionTitle(title: '성격 키워드', colors: colors),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: _keywords
                      .map(
                        (k) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: PubTokens.purple100Light,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            k,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: PubTokens.purple600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: _LikeDislikeCard(
                      title: '💚 좋아하는 것',
                      items: const [
                        '☕ 따뜻한 커피',
                        '🎬 영화 감상',
                        '🏕️ 캠핑·여행',
                        '🎮 게임',
                      ],
                      colors: colors,
                    )),
                    const SizedBox(width: 10),
                    Expanded(child: _LikeDislikeCard(
                      title: '🚫 싫어하는 것',
                      items: const [
                        '🥶 거짓말',
                        '😤 무례한 행동',
                        '🌧️ 약속 어기기',
                        '🥦 브로콜리',
                      ],
                      colors: colors,
                    )),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SectionTitle(title: '민준의 사진', colors: colors),
                    Text(
                      '더보기 ›',
                      style: TextStyle(fontSize: 11, color: colors.ink3),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                  ),
                  itemCount: 4,
                  itemBuilder: (_, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: const PubPhoto(variant: PubPhotoVariant.model),
                  ),
                ),
                const SizedBox(height: 18),
                _SectionTitle(title: '나만 아는 민준 🔒', colors: colors),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: _SecretCard(
                        icon: '💜',
                        title: '우리만의 비밀',
                        subtitle: '둘만 아는 이야기',
                        colors: colors,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SecretCard(
                        icon: '🎵',
                        title: '함께 들은 음악',
                        subtitle: '47곡 플레이리스트',
                        colors: colors,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PubBottomActionBar(
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: '채팅하기 💬',
                      background: PubTokens.purple100Light,
                      foreground: PubTokens.purple600,
                      onTap: () => context.go(RouteNames.chat),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: _ActionButton(
                      label: '전화하기 📞',
                      background: const Color(0xFFFCE0EF),
                      foreground: const Color(0xFFEC4899),
                      onTap: () => context.push(RouteNames.voiceCall),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: _ActionButton(
                      label: '선물하기 🎁',
                      gradient: colors.ctaGradient,
                      foreground: Colors.white,
                      onTap: () => context.push(RouteNames.giftShop),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => context.push(RouteNames.modelViewer),
              child: const PubPhoto(variant: PubPhotoVariant.model),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF140E28).withValues(alpha: 0.3),
                    Colors.transparent,
                    PubTokens.chatBg,
                  ],
                  stops: const [0, 0.3, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('✎', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 54,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '💜 AI 남자친구',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            bottom: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '민준 💜',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: colors.ink,
                  ),
                ),
                Text(
                  '당신만을 위해 만들어진 AI 남자친구',
                  style: TextStyle(fontSize: 12, color: colors.ink2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.colors});

  final AppColorTokens colors;

  static const _rows = [
    ('🎂', '나이', '26세'),
    ('📏', '신체', '183cm · 72kg'),
    ('💼', '직업', '개발자 (Software Engineer)'),
    ('🧬', 'MBTI', 'ENFP'),
    ('📅', '생성일', '2024.05.10 · D+45'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        children: [
          for (var i = 0; i < _rows.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                    child: Text(_rows[i].$1, textAlign: TextAlign.center),
                  ),
                  const SizedBox(width: 11),
                  Text(_rows[i].$2, style: TextStyle(fontSize: 13, color: colors.ink2)),
                  const Spacer(),
                  Text(
                    _rows[i].$3,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.ink,
                    ),
                  ),
                ],
              ),
            ),
            if (i < _rows.length - 1)
              Divider(height: 1, color: colors.line),
          ],
        ],
      ),
    );
  }
}

class _ModelViewerEntry extends StatelessWidget {
  const _ModelViewerEntry({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(RouteNames.modelViewer),
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                PubTokens.purple400.withValues(alpha: 0.18),
                PubTokens.purple600.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(color: PubTokens.purple100Light),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Text('🧊', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3D 모델 뷰어',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: colors.ink,
                      ),
                    ),
                    Text(
                      '민준의 3D 모델을 회전·확대하며 둘러보기',
                      style: TextStyle(fontSize: 10.5, color: colors.ink2),
                    ),
                  ],
                ),
              ),
              Text(
                '열기 ›',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: PubTokens.purple600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavorCard extends StatelessWidget {
  const _FavorCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFE6FB), Color(0xFFF3E8F3)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Text('💜', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '호감도',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              Text(
                '72% · Lv.3 썸 타는 중',
                style: TextStyle(fontSize: 10, color: colors.ink3),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            '72%',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: PubTokens.purple600,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '자세히 ›',
            style: TextStyle(fontSize: 11, color: PubTokens.purple400),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.colors});

  final String title;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: colors.ink,
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Text(
        '안녕하세요 민준이에요. 개발자로 일하고 있고, 사람들과 함께 성장하는 걸 좋아해요. '
        '당신과 함께 좋은 추억을 많이 쌓고 싶어요 😊',
        style: TextStyle(
          fontSize: 12.5,
          height: 1.6,
          color: colors.ink2,
        ),
      ),
    );
  }
}

class _LikeDislikeCard extends StatelessWidget {
  const _LikeDislikeCard({
    required this.title,
    required this.items,
    required this.colors,
  });

  final String title;
  final List<String> items;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 9),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                item,
                style: TextStyle(fontSize: 12, color: colors.ink2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecretCard extends StatelessWidget {
  const _SecretCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colors,
  });

  final String icon;
  final String title;
  final String subtitle;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE6DDF8), Color(0xFFEFE2F0)],
        ),
        border: Border.all(color: PubTokens.purple100Light),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          Text(subtitle, style: TextStyle(fontSize: 10, color: colors.ink3)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    this.background,
    this.gradient,
    required this.foreground,
    this.onTap,
  });

  final String label;
  final Color? background;
  final List<Color>? gradient;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: gradient == null ? background : null,
            gradient: gradient != null ? LinearGradient(colors: gradient!) : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: foreground,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
