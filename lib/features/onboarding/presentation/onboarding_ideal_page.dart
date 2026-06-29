import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/heart_icon.dart';
import '../../../shared/widgets/onboarding_shell.dart';

class OnboardingIdealPage extends StatelessWidget {
  const OnboardingIdealPage({super.key});

  static const _nodes = [
    (emoji: '🙂', title: '외모', sub: '얼굴상·헤어', x: 0.22, y: 0.18),
    (emoji: '💼', title: '직업', sub: '직군·가치관', x: 0.80, y: 0.24),
    (emoji: '😊', title: '성격', sub: '다정·유머', x: 0.14, y: 0.54),
    (emoji: '💕', title: '취향', sub: '좋아하는 것', x: 0.86, y: 0.58),
    (emoji: '💬', title: '연애 스타일', sub: '표현 방식', x: 0.30, y: 0.88),
    (emoji: '✏️', title: '자유 입력', sub: '나만의 설정', x: 0.74, y: 0.90),
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingShell(
      step: 2,
      activeDot: 1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('당신의 이상형을'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('직접 '),
              GradientText(
                '만들어보세요',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  height: 1.32,
                ),
              ),
            ],
          ),
        ],
      ),
      subtitle: '외모, 성격, 취향, 직업까지\n세세하게 선택하면\n세상에 하나뿐인 남자친구가 탄생해요',
      onNext: () => context.push(RouteNames.onboardingMemory),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(230, 230),
                      painter: _DashedRingPainter(color: PubTokens.purple200),
                    ),
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: PubTokens.heartGradient,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x99C4A0F0),
                            blurRadius: 40,
                            offset: Offset(0, 18),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: HeartIcon(size: 42, color: Colors.white),
                      ),
                    ),
                    ..._nodes.map(
                      (n) => Positioned(
                        left: constraints.maxWidth * n.x - 50,
                        top: constraints.maxHeight * n.y - 24,
                        child: _DiagramNode(
                          emoji: n.emoji,
                          title: n.title,
                          subtitle: n.sub,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Text(
            '당신이 만든 이상형이\n진짜 남자친구가 됩니다',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PubTokens.purple400,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _DiagramNode extends StatelessWidget {
  const _DiagramNode({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  final String emoji;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.line),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: PubTokens.purple100Light,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10, color: colors.ink3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedRingPainter extends CustomPainter {
  const _DashedRingPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1;
    final circumference = 2 * 3.1415926535 * radius;
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (var i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashWidth + dashSpace)) / radius;
      final sweepAngle = dashWidth / radius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle - 3.1415926535 / 2,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRingPainter oldDelegate) =>
      oldDelegate.color != color;
}
