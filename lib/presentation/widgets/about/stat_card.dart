import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.adaptive(s20, s28),
              horizontal: context.adaptive(s16, s24),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final double numberFontSize = (maxWidth * 0.10).clamp(s28, s40);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated or Static Number
                    Center(
                      child: stat.isNumeric
                          ? AnimatedStatNumber(
                              targetValue: _parseValue(stat),
                              suffix: _getSuffix(stat),
                              fontSize: numberFontSize,
                            )
                          : StaticStatNumber(
                              text: stat.number,
                              fontSize: numberFontSize,
                            ),
                    ),

                    SizedBox(height: context.adaptive(s8, s12)),

                    // Label
                    BodyMedium(
                      stat.label,
                      textAlign: TextAlign.center,
                      color: kGrey300,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: delay)
        .slideY(begin: 0.3, end: 0.0, curve: Curves.easeOutCubic)
        .scale(
          begin: Offset(0.9, 0.9),
          end: Offset(1.0, 1.0),
          curve: Curves.easeOutBack,
        );
  }

  double _parseValue(StatModel stat) {
    final cleaned = stat.number.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  String _getSuffix(StatModel stat) {
    if (stat.number.contains('%')) return '%';
    if (stat.number.contains('+')) return '+';
    if (stat.number.contains('K')) return 'K';
    if (stat.number.contains('M')) return '';
    return '';
  }
}

class AnimatedStatNumber extends StatelessWidget {
  final double targetValue;
  final String suffix;
  final double fontSize;

  const AnimatedStatNumber({
    super.key,
    required this.targetValue,
    required this.suffix,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: targetValue),
      duration: 2600.ms,
      curve: Curves.easeOutExpo,
      builder: (context, value, _) {
        final displayValue = value.toInt();
        return GradientText(
          '$displayValue$suffix',
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
        );
      },
    );
  }
}

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
    return GradientText(
      text,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
    );
  }
}
