import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors.ctaGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}
