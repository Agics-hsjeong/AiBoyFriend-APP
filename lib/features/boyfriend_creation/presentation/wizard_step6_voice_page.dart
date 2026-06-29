import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../application/wizard_controller.dart';
import '../application/wizard_options.dart';
import 'wizard_shell.dart';
import 'wizard_widgets.dart';

class WizardStep6VoicePage extends ConsumerStatefulWidget {
  const WizardStep6VoicePage({super.key});

  @override
  ConsumerState<WizardStep6VoicePage> createState() => _WizardStep6VoicePageState();
}

class _WizardStep6VoicePageState extends ConsumerState<WizardStep6VoicePage>
    with SingleTickerProviderStateMixin {
  var _playing = false;
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _playing = false);
          _waveController.reset();
        }
      });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _playPreview() {
    setState(() => _playing = true);
    _waveController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final wizard = ref.watch(wizardControllerProvider);
    final controller = ref.read(wizardControllerProvider.notifier);
    final voice = WizardOptions.voices[wizard.voiceIndex];
    const barHeights = [12.0, 26, 18, 34, 22, 38, 16, 28, 20, 30, 14];

    return WizardShell(
      step: 6,
      stepCount: '6 / 7',
      footnote: '💜 선택한 목소리로 실제 통화를 할 수 있어요',
      onBack: () => context.go(RouteNames.wizardPersonality),
      onNext: () => context.go(RouteNames.wizardComplete),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WizardTip(label: '🔊 ▶ 눌러 미리듣기'),
          const WizardQuestionHeader(
            step: 6,
            title: '어떤 목소리가\n가장 마음에 드나요? 💜',
            subtitle: '목소리는 대화와 음성 통화에 사용돼요',
          ),
          const SizedBox(height: 12),
          WizardSplitBody(
            optionsFlex: 56,
            previewFlex: 40,
            options: Column(
              children: List.generate(WizardOptions.voices.length, (i) {
                final v = WizardOptions.voices[i];
                return WizardVoiceOption(
                  title: v.$1,
                  subtitle: v.$2,
                  tag: v.$3,
                  isCustom: v.$4,
                  selected: wizard.voiceIndex == i,
                  onTap: () {
                    controller.setVoice(i);
                    if (!v.$4) _playPreview();
                  },
                );
              }),
            ),
            preview: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.line),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [PubTokens.shadowCard],
              ),
              child: Column(
                children: [
                  Text(
                    '🎧 미리 들어보기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: colors.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: AnimatedBuilder(
                      animation: _waveController,
                      builder: (context, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(barHeights.length, (i) {
                            final scale = _playing
                                ? 0.55 +
                                    0.45 *
                                        (0.5 +
                                            0.5 *
                                                (i.isEven
                                                    ? _waveController.value
                                                    : 1 - _waveController.value))
                                : 1.0;
                            return Container(
                              width: 3,
                              height: barHeights[i] * scale,
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Color(0xFFA78BFA), Color(0xFFF0A6D8)],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    voice.$5,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      color: colors.ink2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
