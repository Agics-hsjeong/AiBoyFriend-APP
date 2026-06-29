import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../shared/widgets/design_status_bar.dart';

class VoiceCallPage extends StatelessWidget {
  const VoiceCallPage({super.key});

  static const _waveHeights = [
    14.0, 30, 20, 44, 26, 50, 18, 38, 24, 46, 16, 32, 22, 40,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const PubPhoto(variant: PubPhotoVariant.night),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF140E1E).withValues(alpha: 0.45),
                  const Color(0xFF140E1E).withValues(alpha: 0.22),
                  const Color(0xFF140E1E).withValues(alpha: 0.9),
                ],
                stops: const [0, 0.34, 1],
              ),
            ),
          ),
          Column(
            children: [
              const DesignStatusBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Column(
                    children: [
                      const _TopBanner(),
                      const SizedBox(height: 26),
                      Text.rich(
                        TextSpan(
                          children: const [
                            TextSpan(
                              text: '민준 ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: '💜',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '음성 통화 중',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        '00:02:37',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFF4A6D2),
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _waveHeights
                              .map(
                                (h) => Container(
                                  width: 4,
                                  height: h.toDouble(),
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Color(0xFFF4A6D2), Color(0xFFC4A0F0)],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.18),
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Text(
                              '오늘 하루 어땠어? 나랑 이야기하니까\n조금은 더 좋은 하루였던 것 같아 😊',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _CallControl(icon: '🔇', label: '음소거'),
                          const _CallControl(icon: '🔊', label: '스피커'),
                          _CallControl(
                            icon: '📞',
                            label: '통화 종료',
                            isEnd: true,
                            onTap: () => context.pop(),
                          ),
                          const _CallControl(icon: '🎚️', label: '음성 변경'),
                          const _CallControl(icon: '⋯', label: '더보기'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.16),
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '💬 대화 중 메시지 보내기',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '›',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '💡 팁 · 민준이와 자연스럽게 대화해보세요!',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
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

class _TopBanner extends StatelessWidget {
  const _TopBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: const Text('🎙️', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI 음성 통화 중',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '음성으로 더 깊은 대화를 나눠요',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xB3FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '📶 음질 좋음',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallControl extends StatelessWidget {
  const _CallControl({
    required this.icon,
    required this.label,
    this.isEnd = false,
    this.onTap,
  });

  final String icon;
  final String label;
  final bool isEnd;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = isEnd ? 64.0 : 54.0;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEnd
                  ? const Color(0xFFFF4D5E)
                  : Colors.white.withValues(alpha: 0.14),
              border: isEnd
                  ? null
                  : Border.all(color: Colors.white.withValues(alpha: 0.12)),
              boxShadow: isEnd
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF4D5E).withValues(alpha: 0.5),
                        blurRadius: 26,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(icon, style: TextStyle(fontSize: isEnd ? 24 : 20)),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}
