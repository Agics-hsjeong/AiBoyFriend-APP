import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep3BodyPage extends ConsumerWidget {
  const WizardStep3BodyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);
    final body = WizardOptions.bodies[wizard.bodyIndex];

    return WizardShell(
      step: 3,
      stepCount: '3 / 7',
      footnote: '💜 키와 비율은 자동으로 조화롭게 적용돼요',
      onBack: () => context.go(RouteNames.wizardHair),
      onNext: () => context.go(RouteNames.wizardStyle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '💡 미리보기 자동 반영'),
          const WizardQuestionHeader(
            step: 3,
            title: '어떤 체형이\n가장 마음에 드나요? 💜',
            subtitle: '원하는 체형을 선택해보세요',
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
                childAspectRatio: 0.78,
              ),
              itemCount: WizardOptions.bodies.length,
              itemBuilder: (context, i) {
                final b = WizardOptions.bodies[i];
                return WizardOptionTile(
                  title: b.$1,
                  subtitle: b.$2,
                  selected: wizard.bodyIndex == i,
                  imageHeight: 70,
                  onTap: () => controller.setBody(i),
                );
              },
            ),
            preview: Column(
              children: [
                const WizardPreviewImage(aspectRatio: 2 / 3),
                const SizedBox(height: 10),
                WizardPreviewCard(
                  title: '💪 ${body.$1} 미리보기',
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatBox(label: body.$3, value: '키', colors: colors),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _StatBox(label: body.$4, value: '스타일', colors: colors),
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

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.colors,
  });

  final String label;
  final String value;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: colors.brand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: colors.brand,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 9.5, color: colors.ink3),
          ),
        ],
      ),
    );
  }
}
