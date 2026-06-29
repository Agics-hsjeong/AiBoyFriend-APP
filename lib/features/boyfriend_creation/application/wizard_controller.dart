import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wizard_options.dart';

class WizardState {
  const WizardState({
    this.faceIndex = 0,
    this.hairIndex = 0,
    this.hairColorIndex = 0,
    this.bodyIndex = 2,
    this.styleIndex = 0,
    this.personality = const [0.8, 0.65, 0.7, 0.55, 0.6],
    this.voiceIndex = 0,
  });

  final int faceIndex;
  final int hairIndex;
  final int hairColorIndex;
  final int bodyIndex;
  final int styleIndex;
  final List<double> personality;
  final int voiceIndex;

  String get faceName => WizardOptions.faces[faceIndex].title;
  String get hairName => WizardOptions.hairs[hairIndex].$1;
  String get bodyName => WizardOptions.bodies[bodyIndex].$1;
  String get styleName => WizardOptions.styles[styleIndex].$1;
  String get voiceName => WizardOptions.voices[voiceIndex].$1;

  String get personalitySummary {
    final pct = (personality.first * 100).round();
    return '다정함 $pct%';
  }

  int get previewHeightCm => WizardOptions.bodies[bodyIndex].$5;

  String personalityPreviewQuote(double warmth) {
    if (warmth >= 0.75) {
      return '“자기야 오늘 하루도 정말 고생 많았어! 내가 늘 응원하는 거 알지? 푹 쉬어 💜”';
    }
    if (warmth >= 0.5) {
      return '“오늘 하루 어땠어? 나한테 이야기해줘.”';
    }
    return '“오늘도 잘 해냈어. 편하게 쉬어.”';
  }

  WizardState copyWith({
    int? faceIndex,
    int? hairIndex,
    int? hairColorIndex,
    int? bodyIndex,
    int? styleIndex,
    List<double>? personality,
    int? voiceIndex,
  }) {
    return WizardState(
      faceIndex: faceIndex ?? this.faceIndex,
      hairIndex: hairIndex ?? this.hairIndex,
      hairColorIndex: hairColorIndex ?? this.hairColorIndex,
      bodyIndex: bodyIndex ?? this.bodyIndex,
      styleIndex: styleIndex ?? this.styleIndex,
      personality: personality ?? this.personality,
      voiceIndex: voiceIndex ?? this.voiceIndex,
    );
  }
}

class WizardController extends Notifier<WizardState> {
  @override
  WizardState build() => const WizardState();

  void setFace(int index) => state = state.copyWith(faceIndex: index);
  void setHair(int index) => state = state.copyWith(hairIndex: index);
  void setHairColor(int index) => state = state.copyWith(hairColorIndex: index);
  void setBody(int index) => state = state.copyWith(bodyIndex: index);
  void setStyle(int index) => state = state.copyWith(styleIndex: index);
  void setVoice(int index) => state = state.copyWith(voiceIndex: index);

  void setPersonality(int sliderIndex, double value) {
    final next = List<double>.from(state.personality);
    next[sliderIndex] = value;
    state = state.copyWith(personality: next);
  }
}

final wizardControllerProvider =
    NotifierProvider<WizardController, WizardState>(WizardController.new);
