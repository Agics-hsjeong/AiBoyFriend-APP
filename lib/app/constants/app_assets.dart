abstract final class AppAssets {
  static const loginModel = 'assets/images/login-model.jpg';
  static const onboardingScene = 'assets/images/ob01-scene.jpg';
}

abstract final class OnboardingFlow {
  static const totalSteps = 6;

  static String counterLabel(int step) =>
      '${step.toString().padLeft(2, '0')} / $totalSteps';
}
