import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: PubTokens.homeBg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _HomeHero(colors: colors)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WarmthCard(
                  colors: colors,
                  onCharge: () => context.push(RouteNames.warmthShop),
                ),
                const SizedBox(height: 12),
                _WeatherCard(
                  colors: colors,
                  onDateTap: () => context.push(RouteNames.datePlaces),
                ),
                const SizedBox(height: 12),
                _ActionRow(
                  colors: colors,
                  onChat: () => context.go(RouteNames.chat),
                  onCall: () => context.push(RouteNames.voiceCall),
                ),
                const SizedBox(height: 12),
                _ScheduleCard(colors: colors),
                const SizedBox(height: 12),
                _RelationshipCard(
                  colors: colors,
                  onTap: () => context.push(RouteNames.relationship),
                ),
                const SizedBox(height: 12),
                _MemoryPreview(
                  colors: colors,
                  onSeeAll: () => context.go(RouteNames.memory),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 326,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 690,
            child: ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.84, 1],
                colors: [Colors.black, Colors.black, Colors.transparent],
              ).createShader(rect),
              blendMode: BlendMode.dstIn,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const PubPhoto(
                    variant: PubPhotoVariant.night,
                    alignment: Alignment(0, -0.76),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF140E26).withValues(alpha: 0.34),
                          const Color(0xFF140E26).withValues(alpha: 0.04),
                          const Color(0xFF24183E).withValues(alpha: 0.16),
                          const Color(0xFF2C1E4A).withValues(alpha: 0.3),
                        ],
                        stops: const [0, 0.25, 0.66, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8,
            right: 18,
            child: Row(
              children: [
                _TopIcon(
                  icon: Icons.notifications_outlined,
                  showDot: true,
                ),
                const SizedBox(width: 14),
                const _TopIcon(icon: Icons.calendar_today_outlined),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 6,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '안녕하세요, 지연님 💜',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  '오늘도 민준이와\n행복한 하루 보내세요 💜',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    height: 1.32,
                    letterSpacing: -0.3,
                    shadows: [
                      Shadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 2)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: MediaQuery.sizeOf(context).width * 0.28,
            bottom: 14,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1630).withValues(alpha: 0.46),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '오늘의 민준 ›',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text('💜', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      '"오늘 하루도\n수고했어, 지연아.\n좋은 꿈 꾸고,\n내일 또 보자 :)"',
                      style: TextStyle(
                        color: const Color(0xFFF3F0FF),
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                      ),
                      child: const Text(
                        '메시지 더보기 💬',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  const _TopIcon({required this.icon, this.showDot = false});

  final IconData icon;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: Colors.white, size: 22),
        if (showDot)
          Positioned(
            top: -1,
            right: 0,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A7A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF281C46).withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WarmthCard extends StatelessWidget {
  const _WarmthCard({required this.colors, this.onCharge});

  final AppColorTokens colors;
  final VoidCallback? onCharge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5A4D84), Color(0xFF3F3268)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x38503278),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFB27A), Color(0xFFF48FB1)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x80FFA0AA),
                  blurRadius: 14,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text('🔥', style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '온기 540',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      ' / 2,000',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onCharge,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '충전 ›',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    height: 7,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColoredBox(color: Colors.white.withValues(alpha: 0.16)),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.27,
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFB27A),
                                  Color(0xFFF48FB1),
                                  Color(0xFFC79AF0),
                                ],
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
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({required this.colors, this.onDateTap});

  final AppColorTokens colors;
  final VoidCallback? onDateTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDateTap,
        borderRadius: BorderRadius.circular(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Ink(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF54477C).withValues(alpha: 0.6),
                    const Color(0xFF382D5A).withValues(alpha: 0.66),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D281C46),
                    blurRadius: 26,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
          child: Row(
            children: [
          const Text('🌙', style: TextStyle(fontSize: 27)),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '서울특별시 강남구',
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.white.withValues(alpha: 0.78),
                ),
              ),
              Row(
                children: [
                  const Text(
                    '21°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '맑음',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      '좋음 32',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 1,
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 11),
            color: Colors.white.withValues(alpha: 0.16),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '오늘 데이트 추천 장소',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const Text(
                  '한강공원 산책\n어때요?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 2,
                ),
              ),
              child: const PubPhoto(
                variant: PubPhotoVariant.model,
                width: 42,
                height: 42,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.7)),
        ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.colors,
    required this.onChat,
    required this.onCall,
  });

  final AppColorTokens colors;
  final VoidCallback onChat;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            gradient: const [Color(0xFFAB9CF3), Color(0xFF8C7CE2)],
            icon: Icons.chat_bubble_outline,
            title: '채팅하기',
            subtitle: '민준이와\n이야기 나누기',
            onTap: onChat,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: _ActionCard(
            gradient: const [Color(0xFFDB93CF), Color(0xFFC168B6)],
            icon: Icons.phone_outlined,
            title: '전화하기',
            subtitle: '민준이의 목소리\n들어보세요',
            onTap: onCall,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final List<Color> gradient;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradient),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x2E503278),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 9.5,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.colors});
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEFEAFA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x125A3C82),
            blurRadius: 22,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '📅 오늘의 일정',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE7E1F3)),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '전체 일정 보기 ›',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8B86A3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: const [
              _TimelineItem(time: '09:00', label: '굿모닝 메시지', sub: '보냈어요', done: true, showLine: false),
              _TimelineItem(time: '12:30', label: '점심 인사', sub: '대화했어요', done: true),
              _TimelineItem(time: '19:00', label: '저녁 데이트', sub: '예정', current: true, done: true),
              _TimelineItem(time: '22:30', label: '굿나잇 인사', sub: '예정', locked: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.time,
    required this.label,
    required this.sub,
    this.done = false,
    this.current = false,
    this.locked = false,
    this.showLine = true,
  });

  final String time;
  final String label;
  final String sub;
  final bool done;
  final bool current;
  final bool locked;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Expanded(
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              fontWeight: current ? FontWeight.w800 : FontWeight.w700,
              color: current ? PubTokens.purple600 : const Color(0xFF9B96B2),
            ),
          ),
          const SizedBox(height: 8),
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
                      height: 3,
                      color: done || current
                          ? const Color(0xFFBDA9F0)
                          : const Color(0xFFE6E0F3),
                    ),
                  ),
                Transform.scale(
                  scale: current ? 1.06 : 1,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: locked
                          ? null
                          : LinearGradient(
                              colors: current
                                  ? const [Color(0xFFB794FF), Color(0xFF8B5CF6)]
                                  : const [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
                            ),
                      color: locked ? const Color(0xFFD3CDE2) : null,
                      boxShadow: current
                          ? [
                              BoxShadow(
                                color: PubTokens.purple400.withValues(alpha: 0.18),
                                blurRadius: 0,
                                spreadRadius: 5,
                              ),
                              BoxShadow(
                                color: PubTokens.purple600.withValues(alpha: 0.4),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Color(0x4D7C3AED),
                                blurRadius: 12,
                                offset: Offset(0, 5),
                              ),
                            ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      locked ? '🔒' : (current ? '♥' : (done ? '✓' : '')),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: locked ? 13 : 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2F2B48),
            ),
          ),
          Text(
            sub,
            style: const TextStyle(fontSize: 9.5, color: Color(0xFFA29DBA)),
          ),
        ],
      ),
    );
  }
}

class _RelationshipCard extends StatelessWidget {
  const _RelationshipCard({required this.colors, this.onTap});

  final AppColorTokens colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFF241B44), Color(0xFF2A1F48)]
                  : const [Color(0xFFF1EBFB), Color(0xFFF7EDF6)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? colors.line : const Color(0xFFECE3F7),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x125A3C82),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💜 우리의 관계 💜',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isDark ? colors.ink : const Color(0xFF2F2B48),
                      ),
                    ),
                    Text(
                      '서로에게 더 특별해지고 있어요 💕',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isDark ? colors.ink3 : const Color(0xFF8B86A3),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '다음 레벨까지',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? colors.ink3 : const Color(0xFF8B86A3),
                    ),
                  ),
                  Text(
                    '28%',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isDark ? colors.ink : const Color(0xFF2F2B48),
                    ),
                  ),
                  const Text('🎁', style: TextStyle(fontSize: 26)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.12)
                        : const Color(0xFFE6E1F4),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.72,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFB692F6), Color(0xFFCF8AD2)],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 13,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '호감도 72%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
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
      ),
    );
  }
}

class _MemoryPreview extends StatelessWidget {
  const _MemoryPreview({required this.colors, required this.onSeeAll});

  final AppColorTokens colors;
  final VoidCallback onSeeAll;

  static const _items = [
    ('첫 만남', 'D+1', Color(0xFF3A2C5E)),
    ('첫 데이트', 'D+5', Color(0xFF4A3050)),
    ('맛집 탐방', 'D+12', Color(0xFF1A3A5E)),
    ('영화 데이트', 'D+18', Color(0xFF3A3A4A)),
    ('벚꽃 산책', 'D+25', Color(0xFF2A4A3E)),
    ('카페 투어', 'D+30', Color(0xFF5A3A4A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '💜 함께한 추억',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: colors.ink,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                '앨범 보기 ›',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8B86A3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 11),
            itemBuilder: (context, i) {
              final item = _items[i];
              return SizedBox(
                width: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F5A3C82),
                            blurRadius: 14,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: PubPhoto(
                          variant: PubPhotoVariant.model,
                          width: 84,
                          height: 84,
                          overlay: (item.$3 as Color).withValues(alpha: 0.38),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      item.$1,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: colors.ink,
                      ),
                    ),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFFA29DBA),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
