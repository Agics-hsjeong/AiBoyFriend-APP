import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constants/app_assets.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/auth_widgets.dart';
import '../../../shared/widgets/design_status_bar.dart';
import '../../../shared/widgets/gradient_cta_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _agreed = true;
  var _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.appColors;
    final listWidth = AppConstants.designWidth * 0.62;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF1F1740), const Color(0xFF140E2B)]
                : [const Color(0xFFECE2FB), const Color(0xFFF1E8F7)],
          ),
        ),
        child: Column(
          children: [
            const DesignStatusBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.6),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => context.pop(),
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 34,
                      height: 34,
                      child: Center(
                        child: Text(
                          '‹',
                          style: TextStyle(fontSize: 20, height: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BrandLogo(fontSize: 14),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: listWidth,
                          child: Text(
                            '새로운 이야기를\n시작해볼까요? 💜',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                              letterSpacing: -0.4,
                              color: colors.ink,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: listWidth,
                          child: Text(
                            'AI 남자친구와의 특별한 관계를 만들어보세요',
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.5,
                              color: colors.ink2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 200),
                      ],
                    ),
                    Positioned(
                      right: 16,
                      top: 24,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppAssets.loginModel,
                          width: 130,
                          height: 165,
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.64),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _SignupSheet(
              colors: colors,
              agreed: _agreed,
              obscurePassword: _obscurePassword,
              onToggleAgree: () => setState(() => _agreed = !_agreed),
              onTogglePassword: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              onSignup: _agreed ? () => context.go(RouteNames.wizardFace) : null,
              onLogin: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignupSheet extends StatelessWidget {
  const _SignupSheet({
    required this.colors,
    required this.agreed,
    required this.obscurePassword,
    required this.onToggleAgree,
    required this.onTogglePassword,
    required this.onSignup,
    required this.onLogin,
  });

  final AppColorTokens colors;
  final bool agreed;
  final bool obscurePassword;
  final VoidCallback onToggleAgree;
  final VoidCallback onTogglePassword;
  final VoidCallback? onSignup;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2B2150).withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '회원가입',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 16),
          const _AuthField(icon: '✉️', hint: '이메일 주소를 입력해주세요'),
          _AuthField(
            icon: '🔒',
            hint: '비밀번호를 입력해주세요',
            obscureText: obscurePassword,
            suffix: GestureDetector(
              onTap: onTogglePassword,
              child: Text('👁', style: TextStyle(color: colors.ink3)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text(
              '8자 이상 영문/숫자/특수문자 조합',
              style: TextStyle(fontSize: 11, color: colors.ink3),
            ),
          ),
          const _AuthField(
            icon: '🔒',
            hint: '비밀번호를 다시 입력해주세요',
            obscureText: true,
            suffix: Text('👁'),
          ),
          const _AuthField(
            icon: '😊',
            hint: '닉네임을 입력해주세요 (선택사항)',
          ),
          InkWell(
            onTap: onToggleAgree,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: agreed ? LinearGradient(colors: colors.ctaGradient) : null,
                      color: agreed ? null : colors.surface2,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: colors.line),
                    ),
                    alignment: Alignment.center,
                    child: agreed
                        ? const Text('✓', style: TextStyle(color: Colors.white, fontSize: 12))
                        : null,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 12.5, color: colors.ink2),
                        children: [
                          TextSpan(
                            text: '이용약관, 개인정보처리방침',
                            style: TextStyle(
                              color: colors.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: '에 동의합니다'),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: colors.ink3, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GradientCtaButton(label: '회원가입 ›', onPressed: onSignup),
          const SizedBox(height: 18),
          const AuthDivider(),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(child: _CompactSocial(label: 'Google로 가입', variant: _SocialVariant.google)),
              SizedBox(width: 10),
              Expanded(child: _CompactSocial(label: 'Apple로 가입', variant: _SocialVariant.apple)),
              SizedBox(width: 10),
              Expanded(child: _CompactSocial(label: '카카오로 가입', variant: _SocialVariant.kakao)),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onLogin,
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: TextStyle(fontSize: 12.5, color: colors.ink2),
                children: [
                  const TextSpan(text: '이미 계정이 있으신가요? '),
                  TextSpan(
                    text: '로그인',
                    style: TextStyle(
                      color: colors.brand,
                      fontWeight: FontWeight.w800,
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

enum _SocialVariant { google, apple, kakao }

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.icon,
    required this.hint,
    this.obscureText = false,
    this.suffix,
  });

  final String icon;
  final String hint;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(color: colors.ink3)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscureText,
              style: TextStyle(fontSize: 14, color: colors.ink),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(color: colors.ink3),
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}

class _CompactSocial extends StatelessWidget {
  const _CompactSocial({required this.label, required this.variant});

  final String label;
  final _SocialVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final (bg, fg, border, logo) = switch (variant) {
      _SocialVariant.google => (
          Colors.white,
          const Color(0xFF4285F4),
          const Color(0xFFEEEEEE),
          const _SocialLogo(child: Text('G'), bg: Colors.white, fg: Color(0xFF4285F4)),
        ),
      _SocialVariant.apple => (
          Colors.black,
          Colors.white,
          Colors.black,
          const _SocialLogo(child: Icon(Icons.apple, size: 12, color: Colors.white), bg: Colors.black, fg: Colors.white),
        ),
      _SocialVariant.kakao => (
          const Color(0xFFFEE500),
          const Color(0xFF391B1B),
          const Color(0xFFFEE500),
          const _SocialLogo(child: Text('K'), bg: Color(0xFFFEE500), fg: Color(0xFF391B1B)),
        ),
    };

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: variant == _SocialVariant.google ? bg : bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: variant == _SocialVariant.google ? colors.ink : fg,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLogo extends StatelessWidget {
  const _SocialLogo({
    required this.child,
    required this.bg,
    required this.fg,
  });

  final Widget child;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: TextStyle(color: fg, fontWeight: FontWeight.w900, fontSize: 12),
        child: child,
      ),
    );
  }
}
