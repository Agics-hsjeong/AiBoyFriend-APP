abstract final class RouteNames {
  static const home = '/home';
  static const chat = '/chat';
  static const memory = '/memory';
  static const profile = '/profile';
  static const settings = '/settings';
  static const login = '/login';
  static const signup = '/signup';

  static const onboardingWelcome = '/onboarding/welcome';
  static const onboardingIdeal = '/onboarding/ideal';
  static const onboardingMemory = '/onboarding/memory';
  static const onboardingDate = '/onboarding/date';
  static const onboarding3d = '/onboarding/3d';
  static const onboardingStart = '/onboarding/start';

  static const wizardFace = '/wizard/face';
  static const wizardHair = '/wizard/hair';
  static const wizardBody = '/wizard/body';
  static const wizardStyle = '/wizard/style';
  static const wizardPersonality = '/wizard/personality';
  static const wizardVoice = '/wizard/voice';
  static const wizardComplete = '/wizard/complete';
  static const aiGenerating = '/ai/generating';
  static const firstMeeting = '/first-meeting';
  static const voiceCall = '/voice-call';
  static const modelViewer = '/model-viewer';
  static const datePlaces = '/date-places';
  static const giftShop = '/gift-shop';
  static const relationship = '/relationship';
  static const warmthShop = '/warmth-shop';
  static const subscription = '/subscription';
}

abstract final class ImmersiveRoutes {
  static const all = {
    RouteNames.onboardingWelcome,
    RouteNames.aiGenerating,
    RouteNames.firstMeeting,
    RouteNames.voiceCall,
    RouteNames.modelViewer,
  };

  static bool isImmersive(String location) => all.contains(location);
}
