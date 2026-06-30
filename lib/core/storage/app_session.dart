import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app_constants.dart';
import '../../app/router/route_names.dart';

class AppSession {
  AppSession(this._prefs);

  final SharedPreferences _prefs;

  bool get onboardingComplete =>
      _prefs.getBool(PrefKeys.onboardingComplete) ?? false;

  bool get hasBoyfriend => _prefs.getBool(PrefKeys.hasBoyfriend) ?? false;

  bool get isGuest => _prefs.getBool(PrefKeys.isGuest) ?? false;

  /// 남자친구 생성을 완료한 경우에만 홈으로 바로 진입합니다.
  String get initialRoute =>
      hasBoyfriend ? RouteNames.home : RouteNames.onboardingWelcome;

  Future<void> markOnboardingComplete() =>
      _prefs.setBool(PrefKeys.onboardingComplete, true);

  Future<void> markBoyfriendCreated() async {
    await _prefs.setBool(PrefKeys.hasBoyfriend, true);
    await _prefs.setBool(PrefKeys.isGuest, false);
    await _prefs.setBool(PrefKeys.onboardingComplete, true);
  }

  Future<void> migrateLegacyFlags() async {
    if (isGuest && !hasBoyfriend) {
      await _prefs.remove(PrefKeys.isGuest);
      await _prefs.remove(PrefKeys.onboardingComplete);
    }
  }

  Future<void> logout() => reset();

  Future<void> reset() async {
    await _prefs.remove(PrefKeys.onboardingComplete);
    await _prefs.remove(PrefKeys.hasBoyfriend);
    await _prefs.remove(PrefKeys.isGuest);
  }
}

final appSessionProvider = Provider<AppSession>((ref) {
  throw UnimplementedError('appSessionProvider must be overridden in main()');
});
