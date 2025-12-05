// lib/presentation/widgets/services_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/typography.dart';
import 'service_grid.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: context.adaptive(80, 160, md: 100),
        horizontal: 24,
      ),
      child: Column(
        children: [
          // TITLE
          AnimatedFadeSlide(
            visibilityKey: 'services-title',
            delay: 300.ms,
            beginY: 0.4,
            child: TitleLarge(
              context.localization.what_we_build,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: context.adaptive(60, 100, md: 80)),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.adaptive(24, 32),
              ),
              child: ServicesGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
