import 'package:flutter/material.dart';
import '../constants/assets.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool useMapBackground;
  final double opacity;

  const AppBackground({
    super.key,
    required this.child,
    this.useMapBackground = false,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    if (!useMapBackground) {
      return child;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.backgroundMap),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: opacity),
            BlendMode.darken,
          ),
        ),
      ),
      child: child,
    );
  }
}

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.appIcon,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
