import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep1FacePage extends ConsumerWidget {
  const WizardStep1FacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);
    final selected = WizardOptions.faces[wizard.faceIndex];

    return WizardShell(
      step: 1,
      showPrev: false,
      footnote: '💜 고른 얼굴상은 AI 이미지 생성에 반영돼요',
      onNext: () => context.go(RouteNames.wizardHair),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '💡 미리보기 자동 반영'),
          const WizardQuestionHeader(
            step: 1,
            title: '어떤 얼굴상이\n가장 좋으세요?',
            subtitle: '선호하는 얼굴상을 선택해 주세요.\n나중에 변경할 수 있어요.',
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
                childAspectRatio: 0.72,
              ),
              itemCount: WizardOptions.faces.length,
              itemBuilder: (context, i) {
                final o = WizardOptions.faces[i];
                return WizardOptionTile(
                  title: o.title,
                  subtitle: o.subtitle,
                  imageTint: o.tint,
                  selected: wizard.faceIndex == i,
                  onTap: () => controller.setFace(i),
                );
              },
            ),
            preview: Column(
              children: [
                WizardPreviewImage(tint: selected.tint),
                const SizedBox(height: 10),
                WizardPreviewCard(
                  title: '💜 ${selected.title} 특징',
                  child: Column(
                    children: selected.features.map(WizardFeatureRow.new).toList(),
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
