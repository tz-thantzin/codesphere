import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/theme_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/feature_model.dart';

class FeatureCard extends StatelessWidget {
  final FeatureModel data;

  const FeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'feature-${data.title}',
      delay: data.delay.ms,
      beginY: 0.2,
      child: Container(
        constraints: const BoxConstraints(minHeight: s180),
        padding: const EdgeInsets.all(s22),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(s18),
          boxShadow: [
            BoxShadow(
              color: kGrey200.withValues(alpha: 0.4),
              blurRadius: s18,
              offset: const Offset(0, s8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Background
            Container(
              width: s55,
              height: s55,
              padding: const EdgeInsets.all(s12),
              decoration: BoxDecoration(
                color: kRed.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(s14),
              ),
              child: Image.asset(data.icon, color: kRed),
            ),

            const SizedBox(height: s16),

            // Title
            BodyMedium(data.title, color: kRed, fontWeight: bold),

            const SizedBox(height: s10),

            // Description
            Caption(data.description, color: kGrey700),
          ],
        ),
      ),
    );
  }
}
