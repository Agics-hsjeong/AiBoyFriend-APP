import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/pub_photo.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep5PersonalityPage extends ConsumerWidget {
  const WizardStep5PersonalityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);

    return WizardShell(
      step: 5,
      stepCount: '5 / 7',
      footnote: '💜 설정한 성격에 따라 말투와 반응이 달라져요',
      onBack: () => context.go(RouteNames.wizardStyle),
      onNext: () => context.go(RouteNames.wizardVoice),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '💡 슬라이더로 성격 조절'),
          const WizardQuestionHeader(
            step: 5,
            title: '어떤 성격이\n가장 마음에 드나요? 💜',
            subtitle: '슬라이더를 움직여 원하는 정도로 조절해보세요',
          ),
          const SizedBox(height: 12),
          ...List.generate(WizardOptions.personalitySliders.length, (i) {
            final s = WizardOptions.personalitySliders[i];
            return WizardPersonalitySlider(
              leftLabel: s.$1,
              rightLabel: s.$2,
              value: wizard.personality[i],
              onChanged: (v) => controller.setPersonality(i, v),
            );
          }),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.08),
              border: Border.all(color: colors.brand.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🤖 AI 반응 미리보기',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PubPhoto(
                        variant: PubPhotoVariant.model,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        wizard.personalityPreviewQuote(wizard.personality.first),
                        style: TextStyle(
                          fontSize: 11.5,
                          height: 1.5,
                          color: colors.ink2,
                        ),
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
