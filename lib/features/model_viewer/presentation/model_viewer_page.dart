import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_status_bar_style.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class ModelViewerPage extends StatefulWidget {
  const ModelViewerPage({super.key});

  @override
  State<ModelViewerPage> createState() => _ModelViewerPageState();
}

class _ModelViewerPageState extends State<ModelViewerPage>
    with SingleTickerProviderStateMixin {
  int _expression = 0;
  int _pose = 0;
  int _background = 0;
  double _rotationY = 0;
  double _rotationX = 0;
  double _scale = 1;
  double _baseScale = 1;
  bool _autoRotate = false;

  late final AnimationController _spinController;

  static const _expressions = ['😊', '🙂', '😌', '😉', '🥹'];
  static const _poses = ['🧍', '👋', '🫰', '🙆', '🤔'];
  static const _headTilt = [0.0, 0.12, -0.12, 0.18, -0.05];
  static const _poseOffset = [
    Offset.zero,
    Offset(0, -8),
    Offset(0, -4),
    Offset(0, -6),
    Offset(4, 0),
  ];

  static const _backgrounds = [
    (
      radial: Color(0x4DA78BFA),
      colors: [Color(0xFF3A2C5E), Color(0xFF211940)],
    ),
    (
      radial: Color(0x476EA0FF),
      colors: [Color(0xFF2A3A5E), Color(0xFF1A2442)],
    ),
    (
      radial: Color(0x47FF96AA),
      colors: [Color(0xFF5E2C3A), Color(0xFF33161F)],
    ),
  ];

  static const _animations = ['손인사', '고개 끄덕', '하트 포즈', '생각하기', '기본 대기'];

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..addListener(() {
        if (_autoRotate && mounted) {
          setState(() => _rotationY = _spinController.value * math.pi * 2);
        }
      });
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _toggleAutoRotate() {
    setState(() {
      _autoRotate = !_autoRotate;
      if (_autoRotate) {
        _spinController.repeat();
      } else {
        _spinController.stop();
      }
    });
  }

  void _onZoomDelta(double delta) {
    setState(() {
      _scale = (_scale + delta).clamp(0.75, 1.45);
      _baseScale = _scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bg = _backgrounds[_background];

    return AppStatusBarStyle(
      lightIcons: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF110B24),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.4),
              radius: 1.1,
              colors: [Color(0xFF241A45), Color(0xFF160F30), Color(0xFF110B24)],
              stops: [0, 0.6, 1],
            ),
          ),
          child: Column(
            children: [
              const DesignStatusBar(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        '‹',
                        style: TextStyle(fontSize: 22, color: colors.ink, height: 1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '3D 모델 뷰어 🧊',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: colors.ink,
                        ),
                      ),
                    ),
                    Text(
                      '⤴ 공유',
                      style: TextStyle(fontSize: 12, color: colors.ink2),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    SizedBox(
                      height: 330,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: GestureDetector(
                              onScaleStart: (_) => _baseScale = _scale,
                              onScaleUpdate: (d) {
                                if (_autoRotate) return;
                                setState(() {
                                  if (d.pointerCount > 1) {
                                    _scale = (_baseScale * d.scale).clamp(0.75, 1.45);
                                  } else {
                                    _rotationY += d.focalPointDelta.dx * 0.012;
                                    _rotationX += d.focalPointDelta.dy * 0.008;
                                    _rotationX = _rotationX.clamp(-0.45, 0.45);
                                  }
                                });
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: colors.line),
                                  gradient: RadialGradient(
                                    center: const Alignment(0, -0.24),
                                    radius: 0.7,
                                    colors: [
                                      bg.radial,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: bg.colors,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..setEntry(3, 2, 0.0012)
                                          ..rotateY(_rotationY)
                                          ..rotateX(_rotationX)
                                          ..scale(_scale),
                                        child: Transform.translate(
                                          offset: _poseOffset[_pose],
                                          child: Transform.rotate(
                                            angle: _headTilt[_expression],
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(22),
                                              child: PubPhoto(
                                                variant: PubPhotoVariant.body,
                                                width: 180,
                                                height: 240,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 28,
                                      child: Center(
                                        child: Container(
                                          width: 120,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(999),
                                            boxShadow: [
                                              BoxShadow(
                                                color: PubTokens.purple400
                                                    .withValues(alpha: 0.45),
                                                blurRadius: 18,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                              colors: [
                                                PubTokens.purple400
                                                    .withValues(alpha: 0.5),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 6,
                            child: _StripPicker(
                              label: '표정',
                              items: _expressions,
                              selected: _expression,
                              onSelect: (i) => setState(() => _expression = i),
                              colors: colors,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 6,
                            child: _StripPicker(
                              label: '포즈',
                              items: _poses,
                              selected: _pose,
                              onSelect: (i) => setState(() => _pose = i),
                              colors: colors,
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 9,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colors.brand.withValues(alpha: 0.35),
                                border: Border.all(
                                  color: colors.brand.withValues(alpha: 0.5),
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                '● LIVE 3D',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '🖐️ 화면을 드래그하면 모델을 회전시킬 수 있어요',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.5, color: colors.ink2),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: colors.surface2,
                        border: Border.all(color: colors.line),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _JoystickControl(
                                  title: '모델 회전',
                                  colors: colors,
                                  onNudge: (dx, dy) {
                                    if (_autoRotate) return;
                                    setState(() {
                                      _rotationY += dx;
                                      _rotationX += dy;
                                      _rotationX = _rotationX.clamp(-0.45, 0.45);
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: _ZoomControl(
                                  colors: colors,
                                  onZoom: _onZoomDelta,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '배경',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: colors.ink2,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(_backgrounds.length, (i) {
                                        final item = _backgrounds[i];
                                        return GestureDetector(
                                          onTap: () => setState(() => _background = i),
                                          child: Container(
                                            width: 34,
                                            height: 34,
                                            margin: const EdgeInsets.symmetric(horizontal: 3.5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: _background == i
                                                    ? PubTokens.purple400
                                                    : colors.line,
                                              ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: item.colors,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: _toggleAutoRotate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: _autoRotate ? 0.1 : 0.05),
                                border: Border.all(color: colors.line),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(colors: colors.ctaGradient),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _autoRotate ? '❚❚' : '▶',
                                      style: const TextStyle(fontSize: 9, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _autoRotate
                                          ? '자동 회전 중…'
                                          : '애니메이션 · ${_animations[_pose]}',
                                      style: TextStyle(fontSize: 12, color: colors.ink),
                                    ),
                                  ),
                                  Text('▾', style: TextStyle(color: colors.ink2)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _InfoCard(
                            title: '📊 모델 정보',
                            rows: const [
                              ('폴리곤', '126,842'),
                              ('텍스처', '4K PBR'),
                              ('포맷', 'GLB'),
                            ],
                            colors: colors,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _InfoCard(
                            title: '✨ AI 생성 정보',
                            rows: const [
                              ('엔진', 'Meshy'),
                              ('리깅', '완료'),
                              ('애니메이션', '12종'),
                            ],
                            colors: colors,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GradientCtaButton(
                      label: '🔄 모델 재생성하기',
                      height: 46,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('3D 모델 재생성을 시작했어요. 완료되면 알려드릴게요!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StripPicker extends StatelessWidget {
  const _StripPicker({
    required this.label,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.colors,
  });

  final String label;
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: colors.ink2,
          ),
        ),
        const SizedBox(height: 1),
        ...List.generate(items.length, (i) {
          final on = i == selected;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: Container(
              width: 46,
              height: 46,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: colors.surface2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: on ? PubTokens.purple400 : colors.line,
                ),
                boxShadow: on
                    ? [
                        BoxShadow(
                          color: PubTokens.purple400.withValues(alpha: 0.5),
                          blurRadius: 14,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(items[i], style: const TextStyle(fontSize: 17)),
            ),
          );
        }),
      ],
    );
  }
}

class _JoystickControl extends StatelessWidget {
  const _JoystickControl({
    required this.title,
    required this.colors,
    required this.onNudge,
  });

  final String title;
  final AppColorTokens colors;
  final void Function(double dx, double dy) onNudge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: colors.ink2,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(color: colors.line),
                ),
              ),
              Positioned(
                top: 2,
                child: _JoyBtn('▲', () => onNudge(0, -0.08)),
              ),
              Positioned(
                bottom: 2,
                child: _JoyBtn('▼', () => onNudge(0, 0.08)),
              ),
              Positioned(
                left: 2,
                child: _JoyBtn('◀', () => onNudge(-0.08, 0)),
              ),
              Positioned(
                right: 2,
                child: _JoyBtn('▶', () => onNudge(0.08, 0)),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: colors.ctaGradient),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _JoyBtn extends StatelessWidget {
  const _JoyBtn(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(label, style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}

class _ZoomControl extends StatelessWidget {
  const _ZoomControl({required this.colors, required this.onZoom});

  final AppColorTokens colors;
  final ValueChanged<double> onZoom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '확대 / 축소',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: colors.ink2,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onZoom(0.08),
                child: Text('＋', style: TextStyle(color: colors.ink2, fontSize: 12)),
              ),
              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (d) => onZoom(-d.delta.dy * 0.002),
                  child: Container(
                    width: 6,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                    child: Align(
                      alignment: const Alignment(0, -0.2),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: PubTokens.purple400,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onZoom(-0.08),
                child: Text('－', style: TextStyle(color: colors.ink2, fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.rows,
    required this.colors,
  });

  final String title;
  final List<(String, String)> rows;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface2,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 7),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(row.$1, style: TextStyle(fontSize: 10.5, color: colors.ink2)),
                  Text(
                    row.$2,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
