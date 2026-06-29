import 'package:flutter/material.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/app_bar_header.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class ModelViewerPage extends StatefulWidget {
  const ModelViewerPage({super.key});

  @override
  State<ModelViewerPage> createState() => _ModelViewerPageState();
}

class _ModelViewerPageState extends State<ModelViewerPage> {
  int _expression = 0;
  int _pose = 0;
  int _background = 0;

  static const _expressions = ['😊', '🙂', '😌', '😉', '🥹'];
  static const _poses = ['🧍', '👋', '🫰', '🙆', '🤔'];
  static const _backgrounds = [
    [Color(0xFF3A2C5E), Color(0xFF241A42)],
    [Color(0xFF2A3A5E), Color(0xFF1A2442)],
    [Color(0xFF3A5E4A), Color(0xFF1A4228)],
    [Color(0xFF5E3A3A), Color(0xFF421A1A)],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
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
            AppBarHeader(
              title: '3D 모델 뷰어 🧊',
              trailing: Text(
                '⤴ 공유',
                style: TextStyle(fontSize: 12, color: colors.ink2),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                children: [
                  SizedBox(
                    height: 330,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: colors.line),
                              gradient: RadialGradient(
                                center: const Alignment(0, -0.24),
                                radius: 0.7,
                                colors: [
                                  colors.brand.withValues(alpha: 0.3),
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
                                      colors: [
                                        const Color(0xFF3A2C5E),
                                        const Color(0xFF211940),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: PubPhoto(
                                      variant: PubPhotoVariant.body,
                                      width: 180,
                                      height: 240,
                                    ),
                                  ),
                                ),
                              ],
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
                              ),
                            ),
                            Expanded(
                              child: _ZoomControl(colors: colors),
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
                                      final bg = _backgrounds[i];
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
                                              colors: bg,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
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
                                child: const Text('▶', style: TextStyle(fontSize: 11, color: Colors.white)),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '인사 애니메이션 재생 중…',
                                style: TextStyle(fontSize: 12, color: colors.ink),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _InfoCard(colors: colors)),
                      const SizedBox(width: 10),
                      Expanded(child: _StatsCard(colors: colors)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GradientCtaButton(
                    label: '🔄 3D 모델 재생성',
                    height: 46,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
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
  const _JoystickControl({required this.title, required this.colors});

  final String title;
  final AppColorTokens colors;

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
              const Positioned(top: 6, child: Text('▲', style: TextStyle(fontSize: 10))),
              const Positioned(bottom: 6, child: Text('▼', style: TextStyle(fontSize: 10))),
              const Positioned(left: 6, child: Text('◀', style: TextStyle(fontSize: 10))),
              const Positioned(right: 6, child: Text('▶', style: TextStyle(fontSize: 10))),
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

class _ZoomControl extends StatelessWidget {
  const _ZoomControl({required this.colors});

  final AppColorTokens colors;

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
              Text('＋', style: TextStyle(color: colors.ink2, fontSize: 12)),
              Expanded(
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
                      decoration: BoxDecoration(
                        color: PubTokens.purple400,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Text('－', style: TextStyle(color: colors.ink2, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.colors});

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
            '모델 정보',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 7),
          _InfoRow(label: '엔진', value: 'Meshy 3D', colors: colors),
          _InfoRow(label: '폴리곤', value: '12.4K', colors: colors),
          _InfoRow(label: '텍스처', value: '2K PBR', colors: colors),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.colors});

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
            '상호작용',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 7),
          _InfoRow(label: '회전', value: '142회', colors: colors),
          _InfoRow(label: '표정 변경', value: '28회', colors: colors),
          _InfoRow(label: '포즈 변경', value: '11회', colors: colors),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.colors,
  });

  final String label;
  final String value;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10.5, color: colors.ink2)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
