import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/design_status_bar.dart';

class AiGeneratingPage extends StatefulWidget {
  const AiGeneratingPage({super.key});

  @override
  State<AiGeneratingPage> createState() => _AiGeneratingPageState();
}

class _AiGeneratingPageState extends State<AiGeneratingPage> {
  static const _steps = [
    _GenStep(icon: '🔍', title: '1. 당신의 취향 분석', done: true),
    _GenStep(icon: '✨', title: '2. 페르소나 생성', progress: 0.65),
    _GenStep(icon: '🖼️', title: '3. 이미지 생성', waiting: true),
    _GenStep(icon: '🧊', title: '4. 3D 모델 생성', subtitle: 'Meshy', waiting: true),
  ];

  Timer? _navTimer;
  final int _percent = 68;

  @override
  void initState() {
    super.initState();

    _navTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      context.go(RouteNames.firstMeeting);
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: const Color(0xFF100B24),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.84),
            radius: 1.1,
            colors: [Color(0xFF2A1F54), Color(0xFF160F30), Color(0xFF100B24)],
            stops: [0, 0.6, 1],
          ),
        ),
        child: Stack(
          children: [
            const _StarField(),
            Column(
              children: [
                const DesignStatusBar(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            '‹',
                            style: TextStyle(
                              fontSize: 20,
                              color: colors.ink,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI 남자친구 생성중 ✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: colors.ink,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '잠시만 기다려주세요, 최고의 남자친구를 만들고 있어요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: colors.ink2,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _ProgressRing(percent: _percent, colors: colors),
                      const SizedBox(height: 6),
                      Text(
                        '당신의 취향을 분석해 세상에\n하나뿐인 남자친구를 만들고 있어요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          color: colors.ink2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ..._steps.map((s) => _StepTile(step: s, colors: colors)),
                      const SizedBox(height: 14),
                      _TipBox(colors: colors),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GenStep {
  const _GenStep({
    required this.icon,
    required this.title,
    this.subtitle,
    this.done = false,
    this.progress,
    this.waiting = false,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final bool done;
  final double? progress;
  final bool waiting;
}

class _StarField extends StatelessWidget {
  const _StarField();

  static const _stars = [
    Offset(40, 70),
    Offset(300, 100),
    Offset(90, 140),
    Offset(200, 60),
    Offset(340, 120),
    Offset(30, 180),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _stars
          .map(
            (p) => Positioned(
              left: p.dx,
              top: p.dy,
              child: Container(
                width: 2,
                height: 2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({
    required this.percent,
    required this.colors,
  });

  final int percent;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    final progress = percent / 100;

    return Container(
          width: 190,
          height: 190,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: PubTokens.purple400.withValues(alpha: 0.45),
                blurRadius: 50,
              ),
            ],
          ),
          child: CustomPaint(
            painter: _RingPainter(progress: progress),
            child: Center(
              child: Container(
                width: 162,
                height: 162,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1334),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 24,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: Alignment(0, -0.3),
                            colors: [
                              Color(0xFF4A3A72),
                              Color(0xFF251C45),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 34,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 34,
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '$percent',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    color: colors.ink,
                                  ),
                                ),
                                TextSpan(
                                  text: '%',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: colors.ink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '생성 진행중',
                            style: TextStyle(fontSize: 11, color: colors.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const stroke = 14.0;

    final bg = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final fg = Paint()
      ..shader = SweepGradient(
        colors: [
          PubTokens.purple400,
          PubTokens.purple400,
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.08),
        ],
        stops: [0, progress, progress, 1],
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - stroke / 2, bg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - stroke / 2),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.colors});

  final _GenStep step;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colors.surface2,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: PubTokens.purple400.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Text(step.icon, style: const TextStyle(fontSize: 17)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: step.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: colors.ink,
                              ),
                            ),
                            if (step.subtitle != null)
                              TextSpan(
                                text: ' ${step.subtitle}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: colors.ink2,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      step.done
                          ? '완료 ✓'
                          : step.waiting
                              ? '대기중'
                              : '${((step.progress ?? 0) * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: step.done
                            ? const Color(0xFF7BE3A0)
                            : step.waiting
                                ? colors.ink2
                                : PubTokens.purple300,
                      ),
                    ),
                  ],
                ),
                if (step.progress != null || step.waiting) ...[
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: SizedBox(
                      height: 6,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                          if ((step.progress ?? 0) > 0)
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: step.progress ?? 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: colors.ctaGradient,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipBox extends StatelessWidget {
  const _TipBox({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: PubTokens.heartGradient,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 10.5,
                  height: 1.5,
                  color: colors.ink2,
                ),
                children: const [
                  TextSpan(
                    text: 'TIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(text: ' · 생성에는 약 1~3분 정도 소요돼요. 완료되면 알림과 함께 첫 인사를 시작할 수 있어요!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
