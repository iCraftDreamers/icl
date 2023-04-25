library blurred;

import 'dart:ui';

import 'package:flutter/material.dart';

/// Convenience widget to create blurred images.
/// `BlurredImage.asset` behaves like `Image.asset`, and
/// `BlurredImage.network` behaves like `Image.network`.
class BlurredImage extends StatelessWidget {
  BlurredImage.asset(
    String imagePath, {
    Key? key,
    this.blurValue = 5,
  })  : imageWidget = Image.asset(
          imagePath,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        super(key: key);

  BlurredImage.network(
    String url, {
    Key? key,
    this.blurValue = 5,
  })  : imageWidget = Image.network(
          url,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        super(key: key);

  final double blurValue;
  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return Blurred(
      imageWidget,
      blurValue: blurValue,
    );
  }
}

/// Wrapper widget that blurs the wudget passed to it.
/// Any widget passed to the `child` argument will not be blurred.
/// The higher the `blurValue`, the stronger the blur effect.
class Blurred extends StatelessWidget {
  const Blurred(
    this.widget, {
    Key? key,
    this.child,
    this.blurValue = 5,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Widget widget;
  final Widget? child;
  final double blurValue;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        alignment: alignment,
        children: <Widget>[
          widget,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
              child: Container(),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

/// Convenience wrapper to create an acrylic effect Container.
/// Any widget passed to the `child` argument will not be blurred.
/// The higher the `blurValue`, the stronger the blur effect.
/// The `color` and `alpha` can be adjusted to suit your needs.
class Acrylic extends StatelessWidget {
  final Widget? child;
  final double blurValue;
  final Color color;
  final int alpha;
  final AlignmentGeometry alignment;

  const Acrylic({
    Key? key,
    this.child,
    this.blurValue = 5,
    this.color = Colors.black,
    this.alpha = 50,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Blurred(
      Container(
        color: color.withAlpha(alpha),
      ),
      blurValue: blurValue,
      alignment: alignment,
      child: child,
    );
  }
}
