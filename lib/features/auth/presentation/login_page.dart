import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constants/app_assets.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/pub_tokens.dart';
import '../../../shared/widgets/auth_widgets.dart';
import '../../../shared/widgets/design_status_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const _features = [
    ('💬', '24시간 대화', '언제든 함께하는 대화'),
    ('🧠', 'AI 기억 시스템', '당신을 기억해요'),
    ('🧊', '3D 모델 & 데이트', '현실 같은 경험'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 4),
                child: _LoginHero(features: _features),
              ),
            ),
            _LoginSheet(
              onGoogle: () => context.go(RouteNames.wizardFace),
              onApple: () => context.go(RouteNames.wizardFace),
              onKakao: () => context.go(RouteNames.wizardFace),
              onEmail: () => context.go(RouteNames.wizardFace),
              onSignup: () => context.push(RouteNames.signup),
              onGuest: () => context.go(RouteNames.home),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginHero extends StatelessWidget {
  const _LoginHero({required this.features});

  final List<(String, String, String)> features;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final listWidth = AppConstants.designWidth * 0.6;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 24, 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandLogo(),
              const SizedBox(height: 18),
              SizedBox(
                width: listWidth + 20,
                child: Text(
                  '다시 만나서\n반가워요 💜',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                    letterSpacing: -0.4,
                    color: colors.ink,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: listWidth + 20,
                child: Text(
                  'AI 남자친구와의 특별한 이야기를\n지금 이어가세요',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: colors.ink2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: _FeatureTile(
                    width: listWidth,
                    emoji: f.$1,
                    title: f.$2,
                    subtitle: f.$3,
                  ),
                ),
              ),
              const SizedBox(height: 22),
            ],
          ),
          Positioned(
            right: 14,
            top: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                AppAssets.loginModel,
                width: 150,
                height: 200,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.64),
                errorBuilder: (_, error, stackTrace) => Container(
                  width: 150,
                  height: 200,
                  color: const Color(0xFFE8E0F5),
                  alignment: Alignment.center,
                  child: Icon(Icons.person, size: 48, color: colors.ink3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.width,
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  final double width;
  final String emoji;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.07)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.9),
        ),
        boxShadow: const [PubTokens.shadowCard],
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: PubTokens.purple100Light,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: colors.ink,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10, color: colors.ink3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginSheet extends StatelessWidget {
  const _LoginSheet({
    required this.onGoogle,
    required this.onApple,
    required this.onKakao,
    required this.onEmail,
    required this.onSignup,
    required this.onGuest,
  });

  final VoidCallback onGoogle;
  final VoidCallback onApple;
  final VoidCallback onKakao;
  final VoidCallback onEmail;
  final VoidCallback onSignup;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '간편 로그인하기',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: colors.ink,
            ),
          ),
          const SizedBox(height: 16),
          SocialLoginButton(
            label: 'Google로 계속하기',
            backgroundColor: colors.surface,
            foregroundColor: colors.ink,
            borderColor: const Color(0xFFEEEEEE),
            logo: const SocialLogo(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF4285F4),
              child: Text('G'),
            ),
            onPressed: onGoogle,
          ),
          const SizedBox(height: 11),
          SocialLoginButton(
            label: 'Apple로 계속하기',
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            borderColor: Colors.black,
            logo: const SocialLogo(
              backgroundColor: Colors.black,
              child: Icon(Icons.apple, color: Colors.white, size: 16),
            ),
            onPressed: onApple,
          ),
          const SizedBox(height: 11),
          SocialLoginButton(
            label: '카카오로 계속하기',
            backgroundColor: const Color(0xFFFEE500),
            foregroundColor: const Color(0xFF391B1B),
            borderColor: const Color(0xFFFEE500),
            logo: const SocialLogo(
              backgroundColor: Color(0xFFFEE500),
              foregroundColor: Color(0xFF391B1B),
              child: Text('K'),
            ),
            onPressed: onKakao,
          ),
          const SizedBox(height: 18),
          const AuthDivider(),
          const SizedBox(height: 18),
          _DashedEmailButton(onTap: onEmail, colors: colors),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onSignup,
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 13, color: colors.ink2),
                children: [
                  const TextSpan(text: '계정이 없으신가요? '),
                  TextSpan(
                    text: '회원가입',
                    style: TextStyle(
                      color: colors.brand,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onGuest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('✨', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 6),
                Text(
                  '게스트로 둘러보기',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.ink3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedEmailButton extends StatelessWidget {
  const _DashedEmailButton({required this.onTap, required this.colors});

  final VoidCallback onTap;
  final AppColorTokens colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: PubTokens.purple200,
            radius: 16,
            strokeWidth: 1.5,
          ),
          child: SizedBox(
            height: 54,
            width: double.infinity,
            child: Center(
              child: Text(
                '✉️  이메일로 로그인 ›',
                style: TextStyle(
                  color: colors.brand,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
