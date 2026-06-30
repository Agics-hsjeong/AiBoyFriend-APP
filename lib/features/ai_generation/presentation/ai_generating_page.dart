import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_status_bar_style.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../boyfriend_creation/application/wizard_controller.dart';

class AiGeneratingPage extends ConsumerStatefulWidget {
  const AiGeneratingPage({super.key});

  @override
  ConsumerState<AiGeneratingPage> createState() => _AiGeneratingPageState();
}

class _AiGeneratingPageState extends ConsumerState<AiGeneratingPage>
    with SingleTickerProviderStateMixin {
  static const _totalDuration = Duration(seconds: 14);

  static const _stepDefs = [
    (icon: '🔍', title: '1. 당신의 취향 분석', subtitle: null),
    (icon: '✨', title: '2. 페르소나 생성', subtitle: null),
    (icon: '🖼️', title: '3. 이미지 생성', subtitle: null),
    (icon: '🧊', title: '4. 3D 모델 생성', subtitle: 'Meshy'),
  ];

  static const _statusLines = [
    '당신의 취향을 분석하고 있어요…',
    '성격과 말투를 조합하고 있어요…',
    '외모 이미지를 생성하고 있어요…',
    '3D 모델을 완성하고 있어요…',
    '거의 다 됐어요! 마지막 마무리 중…',
  ];

  static const _sparkleOffsets = <Offset>[
    Offset(40, 72),
    Offset(300, 104),
    Offset(92, 148),
    Offset(204, 64),
    Offset(336, 126),
    Offset(28, 184),
  ];

  late final AnimationController _controller;
  late final Animation<double> _progress;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _totalDuration);
    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _controller.addStatusListener((status) {
      if (status != AnimationStatus.completed || _navigated || !mounted) return;
      _navigated = true;
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        if (mounted) context.go(RouteNames.firstMeeting);
      });
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _easedProgress() => _progress.value;

  int _percent() => (_easedProgress() * 100).round();

  int _activeStep(int percent) => switch (percent) {
        < 22 => 0,
        < 48 => 1,
        < 76 => 2,
        _ => 3,
      };

  int _statusIndex(int percent) => switch (percent) {
        < 18 => 0,
        < 42 => 1,
        < 68 => 2,
        < 92 => 3,
        _ => 4,
      };

  double _stepProgress(int index, int percent, int activeStep) {
    if (index < activeStep) return 1;
    if (index > activeStep) return 0;

    final band = switch (index) {
      0 => (0.0, 0.22),
      1 => (0.22, 0.48),
      2 => (0.48, 0.76),
      _ => (0.76, 1.0),
    };
    final t = (percent / 100 - band.$1) / (band.$2 - band.$1);
    return t.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);

    return AppStatusBarStyle(
      lightIcons: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3EDFC),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFEDE4FA),
                Color(0xFFF6F1FD),
                Color(0xFFFAF8FF),
              ],
            ),
          ),
          child: Stack(
            children: [
              const _SparkleField(),
              Column(
                children: [
                  const DesignStatusBar(),
                  Expanded(
                    child: SingleChildScrollView(
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
                          AnimatedBuilder(
                            animation: _progress,
                            builder: (context, _) {
                              final percent = _percent();
                              final activeStep = _activeStep(percent);
                              final statusIndex = _statusIndex(percent);

                              return Column(
                                children: [
                                  RepaintBoundary(
                                    child: _ProgressRing(
                                      progress: _easedProgress(),
                                      percent: percent,
                                      colors: colors,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _statusLines[statusIndex],
                                    key: ValueKey(statusIndex),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                      color: colors.ink2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${wizard.faceName} 타입 · ${wizard.voiceName} 목소리로 조합 중',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: PubTokens.purple600
                                          .withValues(alpha: 0.85),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  for (var i = 0; i < _stepDefs.length; i++)
                                    _StepTile(
                                      icon: _stepDefs[i].icon,
                                      title: _stepDefs[i].title,
                                      subtitle: _stepDefs[i].subtitle,
                                      progress: _stepProgress(
                                        i,
                                        percent,
                                        activeStep,
                                      ),
                                      isDone: i < activeStep || percent >= 100,
                                      isActive:
                                          i == activeStep && percent < 100,
                                      colors: colors,
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          _TipBox(colors: colors),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SparkleField extends StatelessWidget {
  const _SparkleField();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _AiGeneratingPageState._sparkleOffsets
          .map(
            (offset) => Positioned(
              left: offset.dx,
              top: offset.dy,
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: PubTokens.purple400.withValues(alpha: 0.35),
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
    required this.progress,
    required this.percent,
    required this.colors,
  });

  final double progress;
  final int percent;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 190,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x38A78BFA),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _RingPainter(progress: progress),
        child: Center(
          child: Container(
            width: 162,
            height: 162,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: colors.line),
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
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          PubTokens.purple100Light,
                          Color(0x59A78BFA),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 34,
                      color: PubTokens.purple600.withValues(alpha: 0.55),
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
                        percent >= 100 ? '생성 완료!' : '생성 진행중',
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
    final arcRect = Rect.fromCircle(center: center, radius: radius - stroke / 2);

    final bg = Paint()
      ..color = PubTokens.purple100Light.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - stroke / 2, bg);

    if (progress <= 0) return;

    final fg = Paint()
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        colors: [
          PubTokens.purple400,
          PubTokens.purple300,
          Color(0xFFF0A6D8),
          PubTokens.purple100Light,
        ],
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return (oldDelegate.progress - progress).abs() > 0.002;
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isDone,
    required this.isActive,
    required this.colors,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final double progress;
  final bool isDone;
  final bool isActive;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    final statusLabel = isDone
        ? '완료 ✓'
        : isActive
            ? '${(progress * 100).round()}%'
            : '대기중';

    final statusColor = isDone
        ? const Color(0xFF22C55E)
        : isActive
            ? PubTokens.purple600
            : colors.ink3;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : colors.surface2,
        border: Border.all(
          color: isActive
              ? PubTokens.purple400.withValues(alpha: 0.35)
              : colors.line,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isActive
            ? const [
                BoxShadow(
                  color: Color(0x148B5CF6),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isActive
                  ? PubTokens.purple400.withValues(alpha: 0.22)
                  : PubTokens.purple400.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 17)),
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
                              text: title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: colors.ink,
                              ),
                            ),
                            if (subtitle != null)
                              TextSpan(
                                text: ' $subtitle',
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
                      statusLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    height: 6,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        const ColoredBox(color: PubTokens.purple100Light),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: isDone ? 1 : progress,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient:
                                  LinearGradient(colors: colors.ctaGradient),
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

class _TipBox extends StatelessWidget {
  const _TipBox({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
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
                children: [
                  TextSpan(
                    text: 'TIP',
                    style: TextStyle(
                      color: colors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: ' · 생성에는 약 1~3분 정도 소요돼요. 완료되면 첫 만남 화면으로 이동해요!',
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
