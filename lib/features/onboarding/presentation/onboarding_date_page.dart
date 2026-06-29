import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/onboarding_shell.dart';

class OnboardingDatePage extends StatelessWidget {
  const OnboardingDatePage({super.key});

  static const _categories = [
    ('☕', '카페'),
    ('🍽️', '맛집'),
    ('🌃', '야경'),
    ('🌿', '산책'),
    ('🎭', '문화시설'),
    ('🏠', '실내'),
  ];

  static const _pins = [
    ('☕', '감성 카페', 0.22, 0.64),
    ('🌃', '야경 명소', 0.54, 0.42),
    ('🍽️', '맛집', 0.82, 0.70),
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      step: 4,
      activeDot: 3,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('오늘은 어디서'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GradientText(
                '데이트',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.32,
                ),
              ),
              Text('할까요?'),
            ],
          ),
        ],
      ),
      subtitle: '현재 위치를 기반으로 분위기 좋은\n데이트 장소를 AI가 추천해드려요',
      onNext: () => context.push(RouteNames.onboarding3d),
      child: Column(
        children: [
          const SizedBox(height: 6),
          const _DateMap(),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              return SizedBox(
                width: (MediaQuery.sizeOf(context).width - 52 - 16) / 3,
                child: _CategoryChip(emoji: c.$1, label: c.$2),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DateMap extends StatelessWidget {
  const _DateMap();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      height: 210,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE9E2FB), Color(0xFFF3E7F4)],
              ),
              border: Border.all(color: colors.line),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _GridPainter(color: colors.brand.withValues(alpha: 0.12)),
                  ),
                  Positioned(
                    left: constraints.maxWidth * 0.14,
                    top: constraints.maxHeight * 0.70,
                    width: constraints.maxWidth * 0.72,
                    height: constraints.maxHeight * 0.46,
                    child: CustomPaint(
                      painter: _DashedRoutePainter(color: PubTokens.purple400),
                    ),
                  ),
                  ...OnboardingDatePage._pins.map(
                    (p) => Positioned(
                      left: constraints.maxWidth * p.$3 - 20,
                      top: constraints.maxHeight * p.$4 - 48,
                      child: _MapPin(emoji: p.$1, label: p.$2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const step = 34.0;
    for (var x = 0.0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        Transform.rotate(
          angle: -0.785,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors.ctaGradient),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: const [PubTokens.shadowCard],
            ),
            child: Transform.rotate(
              angle: 0.785,
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 17))),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [PubTokens.shadowCard],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.line),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedRoutePainter extends CustomPainter {
  const _DashedRoutePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final radius = (120.0).clamp(0.0, size.width / 2);

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, radius)
      ..arcToPoint(
        Offset(radius, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height);

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRoutePainter oldDelegate) =>
      oldDelegate.color != color;
}
