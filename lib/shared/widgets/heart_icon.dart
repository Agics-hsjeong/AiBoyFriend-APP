import 'package:flutter/material.dart';

import '../../app/theme/pub_tokens.dart';

class HeartIcon extends StatelessWidget {
  const HeartIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
    this.gradient,
  });

  final double size;
  final Color color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final fill = gradient ??
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: PubTokens.heartGradient,
        );

    return ShaderMask(
      shaderCallback: (bounds) => fill.createShader(bounds),
      child: Icon(
        Icons.favorite,
        size: size,
        color: color,
      ),
    );
  }
}

class GradientHeartBadge extends StatelessWidget {
  const GradientHeartBadge({
    super.key,
    this.size = 60,
    this.iconSize = 28,
    this.rotation = -0.12,
  });

  final double size;
  final double iconSize;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x8CDC96DC),
              blurRadius: 34,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: const Color(0x80C896F0),
              blurRadius: 24,
            ),
          ],
        ),
        child: HeartIcon(size: size * 0.88, color: Colors.white),
      ),
    );
  }
}
