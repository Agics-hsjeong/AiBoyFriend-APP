import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';
import '../../../shared/widgets/gradient_cta_button.dart';
import '../../../shared/widgets/pub_chip.dart';

class MemoryAlbumPage extends StatefulWidget {
  const MemoryAlbumPage({super.key});

  @override
  State<MemoryAlbumPage> createState() => _MemoryAlbumPageState();
}

class _MemoryAlbumPageState extends State<MemoryAlbumPage> {
  int _selectedTab = 0;

  static const _tabs = ['📁 전체', '📍 데이트', '🎉 기념일', '✈️ 여행', '☕ 일상'];

  static const _memories = [
    _MemoryItem('첫 만남', '첫 만남 💜', '2024.05.10 · 처음 만난 날', '첫 만남', 12, Color(0xFF3A2C5E)),
    _MemoryItem('데이트', '첫 데이트 ☕', '2024.05.18 · 감성 카페', '데이트', 24, Color(0xFF4A3050)),
    _MemoryItem('일상', '한강 산책 🌿', '2024.05.25 · 한강공원', '일상', 18, Color(0xFF2A4A3E)),
    _MemoryItem('기념일', '생일 축하 🎂', '2024.06.02 · 생일 파티', '기념일', 31, Color(0xFF5A3A4A)),
    _MemoryItem('데이트', '놀이공원 🎡', '2024.06.10 · 에버랜드', '데이트', 27, Color(0xFF3A4A5E)),
    _MemoryItem('기념일', '우리 100일 💍', '2024.08.17 · 100일 기념', '기념일', 52, Color(0xFF4A3A5E)),
    _MemoryItem('여행', '바다 여행 🌊', '2024.07.20 · 강릉', '여행', 44, Color(0xFF1A3A5E)),
    _MemoryItem('일상', '우리의 첫 영화 🎬', '2024.06.28 · CGV', '일상', 19, Color(0xFF3A3A4A)),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: PubTokens.chatBg,
      body: Column(
        children: [
          AppBarHeader(
            title: '추억 앨범 💜',
            leading: const SizedBox(width: 38),
            trailing: Text('⤵ ⋯', style: TextStyle(color: colors.ink3, fontSize: 14)),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: _tabs.length,
              separatorBuilder: (_, index) => const SizedBox(width: 7),
              itemBuilder: (context, i) {
                return PubChip(
                  label: _tabs[i],
                  selected: _selectedTab == i,
                  onTap: () => setState(() => _selectedTab = i),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFEFE6FB), Color(0xFFF3E8F3)],
                    ),
                    border: Border.all(color: PubTokens.purple100Light),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: PubTokens.heartGradient,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text('💜', style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '총 47개의 추억이 있어요',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: colors.ink,
                              ),
                            ),
                            Text(
                              '함께한 순간들이 점점 더 특별해져요',
                              style: TextStyle(fontSize: 10.5, color: colors.ink3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors.ctaGradient),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '＋ 추가',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 11,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: _memories.length,
                  itemBuilder: (context, i) => _MemoryCard(
                    item: _memories[i],
                    colors: colors,
                  ),
                ),
                const SizedBox(height: 86),
              ],
            ),
          ),
          PubBottomActionBar(
            child: GradientCtaButton(
              label: '＋ 새로운 추억 추가하기',
              height: 52,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoryItem {
  const _MemoryItem(
    this.category,
    this.title,
    this.subtitle,
    this.badge,
    this.likes,
    this.tint,
  );

  final String category;
  final String title;
  final String subtitle;
  final String badge;
  final int likes;
  final Color tint;
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.item, required this.colors});

  final _MemoryItem item;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [PubTokens.shadowCard],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              PubPhoto(
                height: 128,
                width: double.infinity,
                variant: PubPhotoVariant.model,
                overlay: item.tint.withValues(alpha: 0.42),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF140E28).withValues(alpha: 0.78),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Text(
                  '♡ ${item.likes}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(11, 10, 11, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9.5, color: colors.ink3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
