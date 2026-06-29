import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../app/theme/pub_tokens.dart';
import 'heart_icon.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.fontSize = 15});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: PubTokens.heartGradient,
            ),
          ),
          child: const Center(
            child: HeartIcon(size: 14, color: Colors.white),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          'AI Boyfriend',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: fontSize,
            color: colors.ink,
          ),
        ),
      ],
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.label = '또는'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(child: Divider(color: colors.line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: TextStyle(fontSize: 12, color: colors.ink3)),
        ),
        Expanded(child: Divider(color: colors.line)),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.logo,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.onPressed,
  });

  final String label;
  final Widget logo;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor ?? colors.line),
            boxShadow: [
              BoxShadow(
                color: colors.ink.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              logo,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: foregroundColor,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: colors.ink3, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLogo extends StatelessWidget {
  const SocialLogo({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
  });

  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ),
        child: child,
      ),
    );
  }
}
