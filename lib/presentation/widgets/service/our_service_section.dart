// lib/presentation/widgets/our_service_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import 'service_grid.dart';

class OurServiceSection extends StatelessWidget {
  const OurServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPagePadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          AnimatedFadeSlide(
            visibilityKey: 'section-title-services',
            delay: 200.ms,
            beginY: 0.2,
            child: Caption(
              '\\  ${context.localization.section_title_services} \\',
              color: kWhite,
            ),
          ),

          SizedBox(height: context.adaptive(8, 12, md: 10)),
          AnimatedFadeSlide(
            visibilityKey: 'service-main-title',
            delay: 400.ms,
            beginY: 0.2,
            child: TitleSmall(
              context.localization.service_main_title,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: context.adaptive(8, 12, md: 10)),
          AnimatedFadeSlide(
            visibilityKey: 'planning-title-separator',
            delay: 200.ms,
            beginY: 0.2,
            child: const TitleSeparator(),
          ),
          SizedBox(height: context.adaptive(40, 60)),
          ServicesGrid(),
        ],
      ),
    );
  }
}
