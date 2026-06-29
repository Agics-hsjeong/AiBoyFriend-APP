import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/theme_preferences.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/chat/presentation/chat_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/main/presentation/main_shell.dart';
import '../../features/memory_album/presentation/memory_album_page.dart';
import '../../features/onboarding/presentation/onboarding_3d_page.dart';
import '../../features/onboarding/presentation/onboarding_date_page.dart';
import '../../features/onboarding/presentation/onboarding_ideal_page.dart';
import '../../features/onboarding/presentation/onboarding_memory_page.dart';
import '../../features/onboarding/presentation/onboarding_start_page.dart';
import '../../features/onboarding/presentation/onboarding_welcome_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/ai_generation/presentation/ai_generating_page.dart';
import '../../features/first_meeting/presentation/first_meeting_page.dart';
import '../../features/voice_call/presentation/voice_call_page.dart';
import '../../features/model_viewer/presentation/model_viewer_page.dart';
import '../../features/date_place/presentation/date_places_page.dart';
import '../../features/premium/presentation/gift_shop_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step1_face_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step2_hair_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step3_body_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step4_style_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step5_personality_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step6_voice_page.dart';
import '../../features/boyfriend_creation/presentation/wizard_step7_complete_page.dart';
import '../../features/relationship/presentation/relationship_page.dart';
import '../../features/subscription/presentation/subscription_page.dart';
import '../../features/warmth_shop/presentation/warmth_shop_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../shared/widgets/immersive_theme_wrapper.dart';
import '../router/route_names.dart';
import '../theme/theme_controller.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  ref.watch(themeSettingsProvider);

  return GoRouter(
    initialLocation: RouteNames.onboardingWelcome,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.chat,
                builder: (context, state) => const ChatPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.memory,
                builder: (context, state) => const MemoryAlbumPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.relationship,
        builder: (context, state) => const RelationshipPage(),
      ),
      GoRoute(
        path: RouteNames.warmthShop,
        builder: (context, state) => const WarmthShopPage(),
      ),
      GoRoute(
        path: RouteNames.subscription,
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(
        path: RouteNames.wizardFace,
        builder: (context, state) => const WizardStep1FacePage(),
      ),
      GoRoute(
        path: RouteNames.wizardHair,
        builder: (context, state) => const WizardStep2HairPage(),
      ),
      GoRoute(
        path: RouteNames.wizardBody,
        builder: (context, state) => const WizardStep3BodyPage(),
      ),
      GoRoute(
        path: RouteNames.wizardStyle,
        builder: (context, state) => const WizardStep4StylePage(),
      ),
      GoRoute(
        path: RouteNames.wizardPersonality,
        builder: (context, state) => const WizardStep5PersonalityPage(),
      ),
      GoRoute(
        path: RouteNames.wizardVoice,
        builder: (context, state) => const WizardStep6VoicePage(),
      ),
      GoRoute(
        path: RouteNames.wizardComplete,
        builder: (context, state) => const WizardStep7CompletePage(),
      ),
      GoRoute(
        path: RouteNames.aiGenerating,
        builder: (context, state) => const ImmersiveTheme(
          child: AiGeneratingPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.firstMeeting,
        builder: (context, state) => const ImmersiveTheme(
          child: FirstMeetingPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.voiceCall,
        builder: (context, state) => const ImmersiveTheme(
          child: VoiceCallPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.modelViewer,
        builder: (context, state) => const ImmersiveTheme(
          child: ModelViewerPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.datePlaces,
        builder: (context, state) => const DatePlacesPage(),
      ),
      GoRoute(
        path: RouteNames.giftShop,
        builder: (context, state) => const GiftShopPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RouteNames.onboardingWelcome,
        builder: (context, state) => const ImmersiveTheme(
          child: OnboardingWelcomePage(),
        ),
      ),
      GoRoute(
        path: RouteNames.onboardingIdeal,
        builder: (context, state) => const OnboardingIdealPage(),
      ),
      GoRoute(
        path: RouteNames.onboardingMemory,
        builder: (context, state) => const OnboardingMemoryPage(),
      ),
      GoRoute(
        path: RouteNames.onboardingDate,
        builder: (context, state) => const OnboardingDatePage(),
      ),
      GoRoute(
        path: RouteNames.onboarding3d,
        builder: (context, state) => const Onboarding3dPage(),
      ),
      GoRoute(
        path: RouteNames.onboardingStart,
        builder: (context, state) => const OnboardingStartPage(),
      ),
    ],
    refreshListenable: _RouterRefresh(ref),
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(this._ref) {
    _sub = _ref.listen(themeSettingsProvider, (_, next) => notifyListeners());
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<ThemeSettings>> _sub;

  @override
  void dispose() {
    _sub.close();
    super.dispose();
  }
}
