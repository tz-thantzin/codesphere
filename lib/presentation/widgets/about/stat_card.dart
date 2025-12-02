import 'package:codesphere/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../model/stat.dart';

class StatCard extends StatefulWidget {
  final Stat stat;
  final Duration delay;

  const StatCard({super.key, required this.stat, this.delay = Duration.zero});

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 380;
    final numericValue =
        double.tryParse(widget.stat.number.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;

    return VisibilityDetector(
      key: Key('stat-${widget.stat.label}'),
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.3) {
          setState(() => _isVisible = true);
        }
      },
      child: GlassCard(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 16 : 20,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Number
            TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0.0,
                    end: _isVisible ? numericValue : 0.0,
                  ),
                  duration: 1800.ms,
                  curve: Curves.easeOutExpo,
                  builder: (context, value, _) {
                    final displayText = _formatNumber(value, widget.stat);
                    return SelectableText(
                      displayText,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 34 : 42,
                        fontWeight: superBold,
                        height: 1,
                        letterSpacing: -1.5,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [kAccentCyan, kPurpleGlow],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    );
                  },
                )
                .animate(target: _isVisible ? 1 : 0)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.3, curve: Curves.easeOutCubic)
                .then(delay: widget.delay),

            const SizedBox(height: 10),

            // Label
            SelectableText(
                  widget.stat.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: semiBold,
                    color: kWhite70,
                    height: 1.4,
                  ),
                )
                .animate(target: _isVisible ? 1 : 0)
                .fadeIn(delay: 200.ms, duration: 500.ms)
                .slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  String _formatNumber(double value, Stat stat) {
    final int intValue = value.toInt();
    if (stat.number.contains('%')) return '$intValue%';
    if (stat.number.contains('+')) return '$intValue+';
    if (stat.isNumeric) return intValue.toString();
    return stat.number;
  }
}
