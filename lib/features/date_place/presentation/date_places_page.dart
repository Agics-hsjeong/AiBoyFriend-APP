import 'package:flutter/material.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class DatePlacesPage extends StatefulWidget {
  const DatePlacesPage({super.key});

  @override
  State<DatePlacesPage> createState() => _DatePlacesPageState();
}

class _DatePlacesPageState extends State<DatePlacesPage> {
  int _category = 0;

  static const _categories = [
    ('💜', '전체'),
    ('☕', '감성카페'),
    ('🍽️', '맛집'),
    ('🌃', '야경명소'),
    ('🌿', '자연산책'),
    ('🎭', '문화시설'),
    ('🏠', '실내'),
  ];

  static const _places = [
    (
      name: '루프탑 라운지 \'문라이트\'',
      rating: 4.8,
      reviews: 210,
      location: '서울 용산구 · 2.1km',
      tags: ['야경 명소', '로맨틱', '루프탑'],
      want: 0.67,
      tint: Color(0xFF3A2C5E),
    ),
    (
      name: '숨은 작은 카페 \'포레스트\'',
      rating: 4.6,
      reviews: 152,
      location: '서울 마포구 · 1.4km',
      tags: ['감성 카페', '조용한'],
      want: 0.54,
      tint: Color(0xFF2A4A3E),
    ),
    (
      name: '한강공원 야경 산책로',
      rating: 4.9,
      reviews: 380,
      location: '서울 영등포구 · 3.2km',
      tags: ['야경', '산책', '무료'],
      want: 0.81,
      tint: Color(0xFF1A3A5E),
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
            title: '데이트 장소 💜',
            trailing: Text(
              '🗺️ 지도',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: PubTokens.purple600,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                  children: [
                    SizedBox(
                      height: 78,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (context, i) {
                          final c = _categories[i];
                          final on = i == _category;
                          return GestureDetector(
                            onTap: () => setState(() => _category = i),
                            child: Column(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: on
                                        ? LinearGradient(colors: colors.ctaGradient)
                                        : null,
                                    color: on ? null : colors.surface,
                                    border: on
                                        ? null
                                        : Border.all(color: colors.line),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(c.$1, style: const TextStyle(fontSize: 20)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  c.$2,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: on ? FontWeight.w700 : FontWeight.w500,
                                    color: on ? PubTokens.purple600 : colors.ink2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _FilterChip(label: '📍 지역 전체 ▾', colors: colors),
                          const SizedBox(width: 7),
                          _FilterChip(label: '분위기 ▾', colors: colors),
                          const SizedBox(width: 7),
                          _FilterChip(label: '가격대 ▾', colors: colors),
                          const SizedBox(width: 7),
                          _FilterChip(label: '거리순 ▾', colors: colors),
                          const SizedBox(width: 7),
                          _FilterChip(
                            label: '💜 가고싶어순',
                            colors: colors,
                            selected: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    ..._places.map((p) => _PlaceCard(place: p, colors: colors)),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 11, 16, 18),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      border: Border(top: BorderSide(color: colors.line)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '민준이가 추천한 장소 3곳',
                            style: TextStyle(fontSize: 11, color: colors.ink2),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 130,
                            child: GradientCtaButton(
                              label: '데이트 제안하기',
                              height: 42,
                              onPressed: () {},
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.colors,
    this.selected = false,
  });

  final String label;
  final AppColorTokens colors;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected
            ? PubTokens.purple400.withValues(alpha: 0.2)
            : colors.surface,
        border: Border.all(
          color: selected ? PubTokens.purple400 : colors.line,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: selected ? PubTokens.purple600 : colors.ink2,
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({required this.place, required this.colors});

  final ({
    String name,
    double rating,
    int reviews,
    String location,
    List<String> tags,
    double want,
    Color tint,
  }) place;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          PubPhoto(
            width: 96,
            height: 96,
            borderRadius: BorderRadius.circular(14),
            variant: PubPhotoVariant.model,
            overlay: place.tint.withValues(alpha: 0.42),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '★ ${place.rating}',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFFD479),
                      ),
                    ),
                    Text(
                      ' (${place.reviews})',
                      style: TextStyle(fontSize: 10.5, color: colors.ink2),
                    ),
                    const Spacer(),
                    Text('🔖', style: TextStyle(color: colors.ink2)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  place.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '📍 ${place.location}',
                  style: TextStyle(fontSize: 10.5, color: colors.ink2),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: place.tags
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: PubTokens.purple400.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            t,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: PubTokens.purple600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      '💜 민준이와 가고싶어',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF4A6D2),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: SizedBox(
                          height: 5,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ColoredBox(color: PubTokens.purple100Light),
                              FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: place.want,
                                child: const DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF4A6D2),
                                        Color(0xFFC4A0F0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${(place.want * 100).round()}%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: colors.ink2,
                      ),
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
