import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/context_ex.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/utils/extensions/padding_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import 'services_grid.dart';

class OurServiceSection extends StatelessWidget {
  const OurServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPagePadding(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Caption
          AnimatedFadeSlide(
            visibilityKey: 'services-caption',
            delay: 100.ms,
            beginY: 0.15,
            child: Caption(
              '\\  ${context.localization.section_title_services} \\',
              color: kWhite,
            ),
          ),

          SizedBox(height: context.adaptive(s8, s16, md: s12)),

          // Main Title
          AnimatedFadeSlide(
            visibilityKey: 'services-title',
            delay: 300.ms,
            beginY: 0.2,
            child: TitleSmall(
              context.localization.service_main_title,
              textAlign: TextAlign.left,
              color: kWhite,
            ),
          ),

          SizedBox(height: context.adaptive(s8, s12, md: s10)),

          // Title Separator
          AnimatedFadeSlide(
            visibilityKey: 'services-separator',
            delay: 500.ms,
            beginY: 0.15,
            child: const TitleSeparator(),
          ),

          // Spacing before grid
          SizedBox(height: context.adaptive(s40, s80, md: s60)),

          // Services Grid (with staggered entry)
          const ServicesGrid()
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .slideY(begin: 0.1, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}
