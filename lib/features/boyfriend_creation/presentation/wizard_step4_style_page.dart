import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep4StylePage extends ConsumerWidget {
  const WizardStep4StylePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);
    final style = WizardOptions.styles[wizard.styleIndex];

    return WizardShell(
      step: 4,
      stepCount: '4 / 7',
      footnote: '💡 선택한 스타일은 다양한 의상으로 표현돼요',
      onBack: () => context.go(RouteNames.wizardBody),
      onNext: () => context.go(RouteNames.wizardPersonality),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '✨ AI 추천 스타일'),
          const WizardQuestionHeader(
            step: 4,
            title: '어떤 스타일이\n가장 마음에 드나요? 💜',
            subtitle: '평소 즐겨 입는 스타일을 골라주세요',
          ),
          const SizedBox(height: 12),
          WizardSplitBody(
            options: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: WizardOptions.styles.length,
              itemBuilder: (context, i) {
                final s = WizardOptions.styles[i];
                return WizardOptionTile(
                  title: s.$1,
                  subtitle: s.$2,
                  selected: wizard.styleIndex == i,
                  imageHeight: 66,
                  onTap: () => controller.setStyle(i),
                );
              },
            ),
            preview: Column(
              children: [
                const WizardPreviewImage(),
                const SizedBox(height: 10),
                WizardPreviewCard(
                  title: '👕 ${style.$1} 미리보기',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...style.$3.map((f) => WizardFeatureRow(f)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 7,
                            decoration: BoxDecoration(
                              color: colors.brand2,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: colors.brand.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: colors.brand.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
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
