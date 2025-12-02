import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/constant_colors.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main gradient background
        Container(decoration: const BoxDecoration(gradient: kMainGradient)),

        // Top-left blob (purple)
        _AnimatedBlob(
          alignment: Alignment.topLeft,
          color: kAccentPurple.withValues(alpha: 0.15),
          baseScale: 1.5,
          delay: 0.ms,
        ),

        // Bottom-right blob (cyan)
        _AnimatedBlob(
          alignment: Alignment.bottomRight,
          color: kAccentCyan.withValues(alpha: 0.12),
          baseScale: 2.0,
          delay: 2000.ms,
        ),

        // a third subtle blob for depth
        _AnimatedBlob(
          alignment: Alignment.topRight,
          color: kAccentCyan.withValues(alpha: 0.08),
          baseScale: 1.8,
          delay: 4000.ms,
        ),
      ],
    );
  }
}

class _AnimatedBlob extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double baseScale;
  final Duration delay;

  const _AnimatedBlob({
    required this.alignment,
    required this.color,
    required this.baseScale,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child:
          Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [color, kTransparent],
                    stops: const [0.0, 0.7],
                  ),
                ),
              )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
                delay: delay,
              )
              .scale(
                begin: Offset(baseScale, baseScale),
                end: Offset(baseScale + 0.5, baseScale + 0.5),
                duration: 14.seconds,
                curve: Curves.easeInOut,
              )
              .shimmer(
                duration: 10.seconds,
                color: color.withValues(alpha: 0.3),
              ),
    );
  }
}
