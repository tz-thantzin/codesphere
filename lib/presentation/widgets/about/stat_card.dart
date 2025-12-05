// lib/presentation/widgets/about/stat_card.dart
import 'package:codesphere/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/stat.dart';

class StatCard extends StatelessWidget {
  final Stat stat;
  final Duration delay;

  const StatCard({super.key, required this.stat, this.delay = Duration.zero});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
          padding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              final numberFontSize = width * 0.26;
              final verticalPadding =
                  height * (context.isMobile ? 0.17 : 0.26).clamp(0.17, 0.28);

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: width * 0.1,
                ),
                child: Column(
                  children: [
                    // BIG NUMBER
                    Expanded(
                      flex: 6,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: stat.isNumeric
                            ? AnimatedStatNumber(
                                value: _parseNumericValue(stat),
                                stat: stat,
                                fontSize: numberFontSize,
                              )
                            : StaticStatNumber(
                                text: stat.number,
                                fontSize: numberFontSize,
                              ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // LABEL
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BodyLarge(
                          stat.label,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: delay)
        .slideY(begin: 0.35, curve: Curves.easeOutCubic);
  }

  double _parseNumericValue(Stat stat) {
    return double.tryParse(stat.number.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }
}

// Reusable animated number with gradient
class AnimatedStatNumber extends StatelessWidget {
  final double value;
  final Stat stat;
  final double fontSize;

  const AnimatedStatNumber({
    super.key,
    required this.value,
    required this.stat,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: value),
      duration: 2400.ms,
      curve: Curves.easeOutExpo,
      builder: (context, val, _) {
        return GradientText(
          _formatNumber(val.toInt(), stat),
          fontSize: fontSize,
          letterSpacing: 1,
        );
      },
    );
  }
}

// static number with gradient
class StaticStatNumber extends StatelessWidget {
  final String text;
  final double fontSize;

  const StaticStatNumber({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GradientText(text, fontSize: fontSize, letterSpacing: -1.5);
  }
}

String _formatNumber(int value, Stat stat) {
  if (stat.number.contains('%')) return '$value%';
  if (stat.number.contains('+')) return '$value+';
  if (stat.number.contains('K')) return '${value}K';
  if (stat.number.contains('M')) return '${value}M';
  return value.toString();
}
