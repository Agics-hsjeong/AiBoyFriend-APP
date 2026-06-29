import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class WizardShell extends StatelessWidget {
  const WizardShell({
    super.key,
    required this.step,
    required this.child,
    this.onBack,
    this.onNext,
    this.nextLabel = '다음 ›',
    this.showPrev = true,
    this.footnote,
    this.stepCount = '1 / 7',
  });

  final int step;
  final Widget child;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final String nextLabel;
  final bool showPrev;
  final String? footnote;
  final String stepCount;

  static const _labels = ['얼굴상', '헤어', '체형', '스타일', '성격', '목소리', '완성'];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.bg,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -1),
            radius: 1.4,
            colors: isDark
                ? [const Color(0xFF241C45), colors.bg]
                : [const Color(0xFFEFE9FB), colors.bg],
            stops: const [0, 0.6],
          ),
        ),
        child: Column(
          children: [
            const DesignStatusBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 8),
              child: Row(
                children: [
                  Material(
                    color: colors.brand.withValues(alpha: 0.08),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onBack ?? () => context.pop(),
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(
                          child: Text(
                            '‹',
                            style: TextStyle(
                              fontSize: 20,
                              height: 1,
                              color: colors.ink,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '이상형 생성하기 💜',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: colors.ink,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.home),
                    child: Text(
                      '나중에',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: colors.ink3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
              child: Row(
                children: List.generate(_labels.length, (i) {
                  final idx = i + 1;
                  return Expanded(
                    child: _StepNode(
                      index: idx,
                      label: _labels[i],
                      done: idx < step,
                      current: idx == step,
                      showLeftLine: i > 0,
                      leftLineDone: idx > 1 && (idx - 1) < step,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 8),
                child: child,
              ),
            ),
            if (footnote != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        footnote!,
                        style: TextStyle(fontSize: 11, color: colors.ink3),
                      ),
                    ),
                    Text(
                      stepCount,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: PubTokens.purple400,
                      ),
                    ),
                  ],
                ),
              ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.96),
                    border: Border(top: BorderSide(color: colors.line)),
                  ),
                  child: Row(
                children: [
                  if (showPrev) ...[
                    SizedBox(
                      width: 90,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: onBack ?? () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.line),
                          backgroundColor: colors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          '이전',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: colors.ink2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: GradientCtaButton(
                      label: nextLabel,
                      height: 56,
                      onPressed: onNext,
                    ),
                  ),
                ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.index,
    required this.label,
    required this.done,
    required this.current,
    required this.showLeftLine,
    required this.leftLineDone,
  });

  final int index;
  final String label;
  final bool done;
  final bool current;
  final bool showLeftLine;
  final bool leftLineDone;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        SizedBox(
          height: 26,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (showLeftLine)
                Positioned(
                  left: 0,
                  right: 26,
                  top: 12,
                  child: Container(
                    height: 2,
                    color: leftLineDone ? PubTokens.purple400 : PubTokens.purple200,
                  ),
                ),
              Transform.scale(
                scale: current ? 1.12 : 1,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: current ? LinearGradient(colors: colors.ctaGradient) : null,
                    color: done
                        ? PubTokens.purple400
                        : (current ? null : colors.surface),
                    border: Border.all(
                      color: done || current
                          ? Colors.transparent
                          : PubTokens.purple200,
                      width: 1.5,
                    ),
                    boxShadow: current
                        ? [
                            BoxShadow(
                              color: colors.brand.withValues(alpha: 0.5),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: done
                      ? const Text(
                          '✓',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      : Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: done || current ? Colors.white : colors.ink3,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: done || current ? PubTokens.purple600 : colors.ink3,
          ),
        ),
      ],
    );
  }
}
