import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';

class WarmthShopPage extends StatelessWidget {
  const WarmthShopPage({super.key});

  static const _packs = [
    (amount: '+1,000', bonus: null, price: '₩1,100', hot: false, badge: null),
    (amount: '+3,000', bonus: '+200 보너스', price: '₩2,900', hot: false, badge: null),
    (amount: '+7,000', bonus: '+700 보너스', price: '₩5,900', hot: true, badge: '🔥 인기'),
    (amount: '+15,000', bonus: '+2,000 보너스', price: '₩9,900', hot: false, badge: null),
    (amount: '+35,000', bonus: '+6,000 보너스', price: '₩19,900', hot: false, badge: null),
    (amount: '+80,000', bonus: '+18,000 보너스', price: '₩39,900', hot: false, badge: '최대 혜택'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          AppBarHeader(
            title: '온기 상점 🔥',
            trailing: Text(
              '내역',
              style: TextStyle(fontSize: 12, color: colors.ink3),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: [
                _WarmthGaugeCard(colors: colors),
                const SizedBox(height: 12),
                _SubscriptionBanner(
                  colors: colors,
                  onTap: () => context.push(RouteNames.subscription),
                ),
                const SizedBox(height: 20),
                Text(
                  '🔥 온기 충전',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 11,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: _packs.length,
                  itemBuilder: (context, i) {
                    final pack = _packs[i];
                    return _PackCard(pack: pack, colors: colors);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🔒', style: TextStyle(fontSize: 12, color: colors.ink3)),
                    const SizedBox(width: 7),
                    Text(
                      '안전한 결제 · 환불 정책 적용',
                      style: TextStyle(fontSize: 11, color: colors.ink3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WarmthGaugeCard extends StatelessWidget {
  const _WarmthGaugeCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5A4D84), Color(0xFF3F3268)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF503278).withValues(alpha: 0.28),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x80FFAA8C), Colors.transparent],
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB27A), Color(0xFFF48FB1)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFA0AA).withValues(alpha: 0.6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text('🔥', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 8),
              const Text(
                '내 온기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '⏱ 다음 회복까지 03:24',
                  style: TextStyle(color: Colors.white, fontSize: 10.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '540 ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: '/ 2,000',
                  style: TextStyle(
                    color: Color(0xB3FFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 12,
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
          const SizedBox(height: 9),
          Text(
            '💜 구독 중이면 하루 4회(00·06·12·18시) 최대치까지 자동 회복돼요',
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscriptionBanner extends StatelessWidget {
  const _SubscriptionBanner({required this.colors, required this.onTap});

  final AppColorTokens colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF1EBFB), Color(0xFFF7E8F3)],
        ),
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('🌸', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '구독하면 매일 자동 회복!',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                Text(
                  'Warm Plus 7일 ₩4,900부터',
                  style: TextStyle(fontSize: 10.5, color: colors.ink2),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors.ctaGradient),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '구독 보기 ›',
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
    );
  }
}

class _PackCard extends StatelessWidget {
  const _PackCard({required this.pack, required this.colors});

  final ({
    String amount,
    String? bonus,
    String price,
    bool hot,
    String? badge,
  }) pack;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 13),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: pack.hot ? colors.brand2 : colors.line,
          width: pack.hot ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          if (pack.hot)
            BoxShadow(
              color: PubTokens.purple400.withValues(alpha: 0.28),
              blurRadius: 22,
              offset: const Offset(0, 8),
            )
          else
            PubTokens.shadowCard,
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (pack.badge != null)
            Positioned(
              top: -9,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: colors.ctaGradient),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    pack.badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 26)),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFF4A06A), Color(0xFFF48FB1)],
                ).createShader(bounds),
                child: Text(
                  '${pack.amount} 온기',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              if (pack.bonus != null)
                Text(
                  pack.bonus!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF4A06A),
                  ),
                ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: pack.hot
                      ? LinearGradient(colors: colors.ctaGradient)
                      : null,
                  color: pack.hot ? null : PubTokens.purple100Light,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pack.price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: pack.hot ? Colors.white : PubTokens.purple600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
