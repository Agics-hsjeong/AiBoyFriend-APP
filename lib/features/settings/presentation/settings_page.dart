import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pub_photo.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../shared/widgets/app_bar_header.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool pushNotif = true;
  bool callNotif = true;
  bool anniversaryNotif = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final settings = ref.watch(themeSettingsProvider);

    return Scaffold(
      backgroundColor: colors.bg,
      body: Column(
        children: [
          AppBarHeader(
            title: '설정 💜',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: settings.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('설정을 불러올 수 없습니다: $e')),
              data: (data) => ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                children: [
                  _ProfileCard(colors: colors),
                  _SettingsGroup(
                    title: '계정',
                    colors: colors,
                    items: const [
                      _SettingsRowData('👤', '계정 관리'),
                      _SettingsRowData('🛡️', '개인정보 보안'),
                      _SettingsRowData('🔑', '비밀번호 변경'),
                    ],
                  ),
                  _SettingsGroup(
                    title: '알림',
                    colors: colors,
                    items: [
                      _SettingsRowData(
                        '🔔',
                        '푸시 알림',
                        trailing: _ToggleSwitch(
                          value: pushNotif,
                          onChanged: (v) => setState(() => pushNotif = v),
                        ),
                      ),
                      const _SettingsRowData('💬', '채팅 알림', value: '매번 받기 ›'),
                      _SettingsRowData(
                        '📞',
                        '통화 알림',
                        trailing: _ToggleSwitch(
                          value: callNotif,
                          onChanged: (v) => setState(() => callNotif = v),
                        ),
                      ),
                      _SettingsRowData(
                        '🎉',
                        '기념일 알림',
                        trailing: _ToggleSwitch(
                          value: anniversaryNotif,
                          onChanged: (v) => setState(() => anniversaryNotif = v),
                        ),
                      ),
                    ],
                  ),
                  _SettingsGroup(
                    title: '화면 및 음성',
                    colors: colors,
                    items: [
                      _SettingsRowData(
                        '🌙',
                        '테마',
                        trailing: _ThemeModeSegment(
                          selected: data.themeMode,
                          onChanged: ref
                              .read(themeSettingsProvider.notifier)
                              .setThemeMode,
                        ),
                      ),
                      const _SettingsRowData('🔤', '글자 크기', value: '보통 ›'),
                      _SettingsRowData(
                        '🎨',
                        '테마 색상',
                        trailing: _AccentSwatches(
                          selected: data.accentColor,
                          onChanged: ref
                              .read(themeSettingsProvider.notifier)
                              .setAccentColor,
                        ),
                      ),
                    ],
                  ),
                  _SettingsGroup(
                    title: 'AI 남자친구 설정',
                    colors: colors,
                    items: const [
                      _SettingsRowData('💜', '성격 및 말투 설정'),
                      _SettingsRowData('📈', '관계 설정'),
                      _SettingsRowData('📷', '추억 설정'),
                      _SettingsRowData('🎙️', '음성 및 통화 설정'),
                    ],
                  ),
                  _SettingsGroup(
                    title: '기타',
                    colors: colors,
                    items: const [
                      _SettingsRowData('❓', '자주 묻는 질문'),
                      _SettingsRowData('📄', '이용약관'),
                      _SettingsRowData('ℹ️', '앱 버전', value: 'v1.3.0'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => context.go(RouteNames.login),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: BorderSide(color: const Color(0xFFFF6B7A).withValues(alpha: 0.3)),
                      backgroundColor: const Color(0xFFFF6B7A).withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      '⎋ 로그아웃',
                      style: TextStyle(
                        color: Color(0xFFFF6B7A),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.colors});

  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Row(
        children: [
          ClipOval(
            child: PubPhoto(
              variant: PubPhotoVariant.night,
              width: 54,
              height: 54,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '민준 💜',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                Text(
                  '당신만을 위해 만들어진 AI 남자친구',
                  style: TextStyle(fontSize: 11, color: colors.ink2),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '프로필 편집',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: colors.brand,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRowData {
  const _SettingsRowData(this.icon, this.title, {this.value, this.trailing});

  final String icon;
  final String title;
  final String? value;
  final Widget? trailing;
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.colors,
    required this.items,
  });

  final String title;
  final AppColorTokens colors;
  final List<_SettingsRowData> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 9),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: colors.brand,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.line),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [PubTokens.shadowCard],
            ),
            child: Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  _SettingsRow(item: items[i], colors: colors),
                  if (i < items.length - 1)
                    Divider(height: 1, color: colors.line, indent: 57),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.item, required this.colors});

  final _SettingsRowData item;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.brand.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Text(item.icon, style: const TextStyle(fontSize: 15)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colors.ink,
              ),
            ),
          ),
          if (item.trailing != null)
            item.trailing!
          else if (item.value != null)
            Text(
              item.value!,
              style: TextStyle(fontSize: 11.5, color: colors.ink2),
            )
          else
            Icon(Icons.chevron_right, size: 18, color: colors.ink3),
        ],
      ),
    );
  }
}

class _ToggleSwitch extends StatelessWidget {
  const _ToggleSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: value ? LinearGradient(colors: colors.ctaGradient) : null,
          color: value ? null : const Color(0xFF8C82AA).withValues(alpha: 0.3),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeModeSegment extends StatelessWidget {
  const _ThemeModeSegment({
    required this.selected,
    required this.onChanged,
  });

  final ThemeMode selected;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SegButton(
            label: '시스템',
            selected: selected == ThemeMode.system,
            onTap: () => onChanged(ThemeMode.system),
          ),
          _SegButton(
            label: '라이트',
            selected: selected == ThemeMode.light,
            onTap: () => onChanged(ThemeMode.light),
          ),
          _SegButton(
            label: '다크',
            selected: selected == ThemeMode.dark,
            onTap: () => onChanged(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}

class _SegButton extends StatelessWidget {
  const _SegButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: selected ? colors.surface : Colors.transparent,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: selected ? colors.brand : colors.ink2,
            ),
          ),
        ),
      ),
    );
  }
}

class _AccentSwatches extends StatelessWidget {
  const _AccentSwatches({
    required this.selected,
    required this.onChanged,
  });

  final AccentColor selected;
  final ValueChanged<AccentColor> onChanged;

  static const _swatches = {
    AccentColor.purple: Color(0xFFA78BFA),
    AccentColor.pink: Color(0xFFF472B6),
    AccentColor.blue: Color(0xFF60A5FA),
    AccentColor.green: Color(0xFF34D399),
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _swatches.entries.map((entry) {
        final isOn = entry.key == selected;
        return GestureDetector(
          onTap: () => onChanged(entry.key),
          child: Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(left: 7),
            decoration: BoxDecoration(
              color: entry.value,
              shape: BoxShape.circle,
              border: isOn ? Border.all(color: colors.ink, width: 2) : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
