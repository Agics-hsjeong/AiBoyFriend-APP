import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/heart_icon.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep7CompletePage extends ConsumerWidget {
  const WizardStep7CompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final face = WizardOptions.faces[wizard.faceIndex];

    return WizardShell(
      step: 7,
      stepCount: '7 / 7',
      nextLabel: '내 남자친구 생성하기 ✨',
      footnote: '💜 생성에는 약 1~3분 정도 소요돼요',
      onBack: () => context.go(RouteNames.wizardVoice),
      onNext: () => context.go(RouteNames.aiGenerating),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '🎉 설정 완료!'),
          const WizardQuestionHeader(
            step: 7,
            title: '모든 설정이\n완료됐어요! 🎉',
            subtitle: '선택한 정보를 확인하고 AI 남자친구를 만들어볼까요?',
          ),
          const SizedBox(height: 12),
          WizardSplitBody(
            options: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💜 내가 선택한 이상형',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 7),
                WizardSummaryRow(
                  icon: '🙂',
                  label: '얼굴상',
                  value: wizard.faceName,
                  onEdit: () => context.go(RouteNames.wizardFace),
                ),
                WizardSummaryRow(
                  icon: '💇',
                  label: '헤어',
                  value: wizard.hairName,
                  onEdit: () => context.go(RouteNames.wizardHair),
                ),
                WizardSummaryRow(
                  icon: '💪',
                  label: '체형',
                  value: wizard.bodyName,
                  onEdit: () => context.go(RouteNames.wizardBody),
                ),
                WizardSummaryRow(
                  icon: '👕',
                  label: '스타일',
                  value: wizard.styleName,
                  onEdit: () => context.go(RouteNames.wizardStyle),
                ),
                WizardSummaryRow(
                  icon: '💗',
                  label: '성격',
                  value: wizard.personalitySummary,
                  onEdit: () => context.go(RouteNames.wizardPersonality),
                ),
                WizardSummaryRow(
                  icon: '🎧',
                  label: '목소리',
                  value: wizard.voiceName,
                  onEdit: () => context.go(RouteNames.wizardVoice),
                ),
              ],
            ),
            preview: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.line),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [PubTokens.shadowCard],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WizardPreviewImage(tint: face.tint),
                  const SizedBox(height: 9),
                  Text(
                    '✨ AI 남자친구 미리보기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: colors.ink,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      _PreviewStat(label: '나이', value: '25세', colors: colors),
                      const SizedBox(width: 6),
                      _PreviewStat(
                        label: '키',
                        value: '${wizard.previewHeightCm}cm',
                        colors: colors,
                      ),
                      const SizedBox(width: 6),
                      _PreviewStat(label: 'MBTI', value: 'ENFP', colors: colors),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.08),
              border: Border.all(color: colors.brand.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: colors.ctaGradient),
                  ),
                  child: const Center(
                    child: HeartIcon(size: 17, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        color: colors.ink2,
                      ),
                      children: [
                        TextSpan(
                          text: 'AI 분석 미리보기\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: colors.ink,
                          ),
                        ),
                        const TextSpan(
                          text:
                              '당신의 취향을 분석해 이름·직업·가치관까지 가진 단 하나의 남자친구를 만들어요',
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

class _PreviewStat extends StatelessWidget {
  const _PreviewStat({
    required this.label,
    required this.value,
    required this.colors,
  });

  final String label;
  final String value;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
        decoration: BoxDecoration(
          color: colors.brand.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: colors.brand,
              ),
            ),
            Text(label, style: TextStyle(fontSize: 9, color: colors.ink3)),
          ],
        ),
      ),
    );
  }
}
