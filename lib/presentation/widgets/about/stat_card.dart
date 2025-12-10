// lib/presentation/widgets/about/stat_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/stat_model.dart';

class StatCard extends StatelessWidget {
  final StatModel stat;
  final Duration delay;

  const StatCard({super.key, required this.stat, this.delay = Duration.zero});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
          padding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final numberFontSize = (width * 0.11).clamp(24.0, 48.0);
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.adaptive(18, 24, sm: 20, md: 24, xl: 26),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BIG NUMBER
                    Expanded(
                      flex: 2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
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

                    // LABEL
                    Expanded(
                      child: BodyMedium(
                        stat.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
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

  double _parseNumericValue(StatModel stat) {
    return double.tryParse(stat.number.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }
}

class AnimatedStatNumber extends StatelessWidget {
  final double value;
  final StatModel stat;
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

String _formatNumber(int value, StatModel stat) {
  if (stat.number.contains('%')) return '$value%';
  if (stat.number.contains('+')) return '$value+';
  if (stat.number.contains('K')) return '${value}K';
  if (stat.number.contains('M')) return '${value}M';
  return value.toString();
}
