import 'package:flutter/material.dart';

import '../../app/constants/app_assets.dart';

/// 퍼블 `03 퍼블리싱/css/app.css` `.photo` 변형
enum PubPhotoVariant {
  /// `background: #c9b8e8` + model.jpg
  model(Color(0xFFC9B8E8), Alignment(0, -0.3)),

  /// `background: #241c40` + model-night.jpg
  night(Color(0xFF241C40), Alignment(0, -0.28)),

  /// `background: #eceef1` + model-body.jpg
  body(Color(0xFFECEEF1), Alignment(0, -0.14));

  const PubPhotoVariant(this.fallbackColor, this.alignment);

  final Color fallbackColor;
  final Alignment alignment;
}

class PubPhoto extends StatelessWidget {
  const PubPhoto({
    super.key,
    this.variant = PubPhotoVariant.model,
    this.asset = AppAssets.loginModel,
    this.overlay,
    this.alignment,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final PubPhotoVariant variant;
  final String? asset;
  final Color? overlay;
  final Alignment? alignment;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final imageAlignment = alignment ?? variant.alignment;

    Widget child = ColoredBox(
      color: variant.fallbackColor,
      child: asset == null
          ? null
          : Image.asset(
              asset!,
              fit: fit,
              alignment: imageAlignment,
              width: width,
              height: height,
              errorBuilder: (_, error, stackTrace) => const SizedBox.expand(),
            ),
    );

    if (overlay != null) {
      child = Stack(
        fit: StackFit.expand,
        children: [
          child,
          ColoredBox(color: overlay!),
        ],
      );
    }

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    if (width != null || height != null) {
      child = SizedBox(width: width, height: height, child: child);
    }

    return child;
  }
}
