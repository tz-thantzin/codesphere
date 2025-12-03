// lib/presentation/widgets/about/stat_card.dart
import 'package:codesphere/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/widgets/glass_card.dart';
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
              final double width = constraints.maxWidth;
              final double height = constraints.maxHeight;

              final double numberFontSize = width * 0.28;
              final double labelFontSize = width * 0.05;

              final double verticalPadding =
                  height * (context.isMobile ? 0.18 : 0.21);

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: width * 0.05,
                ),
                child: Column(
                  children: [
                    // NUMBER (Animated or Static)
                    Expanded(
                      flex: 6,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: stat.isNumeric
                            ? HugeAnimatedNumber(
                                value: _parseNumericValue(stat),
                                stat: stat,
                                fontSize: numberFontSize,
                              )
                            : HugeStaticNumber(
                                text: stat.number,
                                fontSize: numberFontSize,
                              ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // LABEL
                    Expanded(
                      flex: 4,
                      child: HugeLabel(
                        text: stat.label,
                        fontSize: labelFontSize,
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

class HugeAnimatedNumber extends StatelessWidget {
  final double value;
  final Stat stat;
  final double fontSize;

  const HugeAnimatedNumber({
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
        return Text(
          _formatNumber(val.toInt(), stat),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: superBold,
            height: 1.2,
            letterSpacing: 1,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [kAccentCyan, kPurpleGlow],
              ).createShader(const Rect.fromLTWH(0, 0, 600, 200)),
          ),
        );
      },
    );
  }
}

class HugeStaticNumber extends StatelessWidget {
  final String text;
  final double fontSize;

  const HugeStaticNumber({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1.5,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: [kAccentCyan, kPurpleGlow],
          ).createShader(const Rect.fromLTWH(0, 0, 600, 200)),
      ),
    );
  }
}

class HugeLabel extends StatelessWidget {
  final String text;
  final double fontSize;

  const HugeLabel({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 3,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: kWhite70,
        height: 1.25,
        letterSpacing: 1.0,
      ),
    );
  }
}

String _formatNumber(int value, Stat stat) {
  if (stat.number.contains('%')) return '$value%';
  if (stat.number.contains('+')) return '$value+';
  if (stat.number.contains('K')) return '${value}K';
  if (stat.number.contains('M')) return '${value}M';
  return value.toString();
}
