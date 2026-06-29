import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep2HairPage extends ConsumerWidget {
  const WizardStep2HairPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);
    final hair = WizardOptions.hairs[wizard.hairIndex];

    return WizardShell(
      step: 2,
      stepCount: '2 / 7',
      footnote: '💡 헤어 컬러는 다음 단계에서 조정할 수 있어요',
      onBack: () => context.go(RouteNames.wizardFace),
      onNext: () => context.go(RouteNames.wizardBody),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '💡 미리보기 자동 반영'),
          const WizardQuestionHeader(
            step: 2,
            title: '어떤 헤어스타일이\n가장 마음에 드나요? ✨',
            subtitle: '잘 어울리는 헤어스타일을 선택해보세요',
          ),
          const SizedBox(height: 12),
          WizardSplitBody(
            options: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WizardCategoryChips(labels: ['전체', '클래식', '트렌디']),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: WizardOptions.hairs.length,
                  itemBuilder: (context, i) => WizardOptionTile(
                    title: WizardOptions.hairs[i].$1,
                    selected: wizard.hairIndex == i,
                    compact: true,
                    imageHeight: 48,
                    onTap: () => controller.setHair(i),
                  ),
                ),
              ],
            ),
            preview: Column(
              children: [
                const WizardPreviewImage(),
                const SizedBox(height: 10),
                WizardPreviewCard(
                  title: '✂️ ${hair.$1} 스타일',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...hair.$2.map(WizardFeatureRow.new),
                      const SizedBox(height: 8),
                      Row(
                        children: WizardOptions.hairColors
                            .asMap()
                            .entries
                            .map(
                              (e) => GestureDetector(
                                onTap: () => controller.setHairColor(e.key),
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  margin: const EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                    color: e.value,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: wizard.hairColorIndex == e.key
                                          ? colors.brand
                                          : colors.line,
                                      width: wizard.hairColorIndex == e.key ? 2 : 1,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
