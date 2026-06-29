import 'package:flutter/material.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';

class GiftShopPage extends StatelessWidget {
  const GiftShopPage({super.key});

  static const _gifts = [
    (emoji: '💐', name: '꽃다발', favor: '+10', cost: '200', special: false, badge: null),
    (emoji: '☕', name: '커피', favor: '+5', cost: '100', special: false, badge: null),
    (emoji: '🎂', name: '케이크', favor: '+15', cost: '350', special: false, badge: null),
    (emoji: '👕', name: '커플룩', favor: '+30', cost: '800', special: true, badge: '특별 반응'),
    (emoji: '💍', name: '반지', favor: '+50', cost: '1,500', special: true, badge: '특별 이벤트'),
    (emoji: '✈️', name: '여행권', favor: '+80', cost: '3,000', special: true, badge: '특별 이벤트'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          AppBarHeader(
            title: '선물 상점 🎁',
            trailing: Text(
              '선물 내역',
              style: TextStyle(fontSize: 12, color: colors.ink3),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [const Color(0xFF241B44), const Color(0xFF2A1F48)]
                          : [const Color(0xFFF1EBFB), const Color(0xFFF7E8F3)],
                    ),
                    border: Border.all(color: colors.line),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: PubPhoto(
                          variant: PubPhotoVariant.model,
                          width: 48,
                          height: 48,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '민준이에게 선물하기 💝',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: colors.ink,
                              ),
                            ),
                            Text(
                              '선물하면 호감도가 오르고\n특별한 반응을 볼 수 있어요',
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.4,
                                color: colors.ink2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          border: Border.all(color: colors.line),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '🔥 내 온기',
                              style: TextStyle(fontSize: 9, color: colors.ink3),
                            ),
                            const Text(
                              '540',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFF4A06A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '🎁 선물 고르기',
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
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: _gifts.length,
                  itemBuilder: (context, i) {
                    final g = _gifts[i];
                    return _GiftCard(gift: g, colors: colors, isDark: isDark);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('💜', style: TextStyle(fontSize: 12, color: colors.ink3)),
                    const SizedBox(width: 7),
                    Text(
                      '일부 선물은 특별 대사·이벤트가 열려요',
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

class _GiftCard extends StatelessWidget {
  const _GiftCard({
    required this.gift,
    required this.colors,
    required this.isDark,
  });

  final ({
    String emoji,
    String name,
    String favor,
    String cost,
    bool special,
    String? badge,
  }) gift;
  final AppColorTokens colors;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 13),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: gift.special ? PubTokens.purple300 : colors.line,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Stack(
        children: [
          if (gift.badge != null)
            Positioned(
              top: 9,
              right: 9,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: PubTokens.purple100Light,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  gift.badge!,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: PubTokens.purple600,
                  ),
                ),
              ),
            ),
          Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [const Color(0xFF2B2150), const Color(0xFF332247)]
                        : [const Color(0xFFF6EEFB), const Color(0xFFF3E6F2)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(gift.emoji, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(height: 10),
              Text(
                gift.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '💗 호감도 ${gift.favor}',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFEC4899),
                ),
              ),
              const Spacer(),
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: PubTokens.purple100Light,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Text(
                  '🔥 ${gift.cost}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: PubTokens.purple600,
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
