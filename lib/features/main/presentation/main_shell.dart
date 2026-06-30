import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../shared/widgets/app_status_bar_style.dart';
import '../../../shared/widgets/app_tab_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  static AppTab _tabFromIndex(int index) => AppTab.values[index];

  static int _indexFromTab(AppTab tab) => tab.index;

  @override
  Widget build(BuildContext context) {
    final currentTab = _tabFromIndex(navigationShell.currentIndex);

    return AppStatusBarStyle(
      lightIcons: currentTab != AppTab.home,
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: AppTabBar(
          current: currentTab,
          onChanged: (tab) {
            navigationShell.goBranch(
              _indexFromTab(tab),
              initialLocation: _indexFromTab(tab) == navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}

extension MainShellNavigation on BuildContext {
  void goHomeTab() => go(RouteNames.home);
  void goChatTab() => go(RouteNames.chat);
  void goMemoryTab() => go(RouteNames.memory);
  void goProfileTab() => go(RouteNames.profile);
  void goSettingsTab() => go(RouteNames.settings);
}
