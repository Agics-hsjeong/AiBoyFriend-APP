import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ai_boyfriend_app/app/app.dart';
import 'package:ai_boyfriend_app/app/theme/theme_controller.dart';
import 'package:ai_boyfriend_app/core/storage/theme_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('앱이 온보딩 환영 화면을 표시한다', (tester) async {
    SharedPreferences.setMockInitialValues({});

    final themePrefs = await ThemePreferences.create();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePreferencesProvider.overrideWithValue(themePrefs),
        ],
        child: const AiBoyfriendApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('내 남자친구는'), findsOneWidget);
    expect(find.text('다음'), findsOneWidget);
  });
}
