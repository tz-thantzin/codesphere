import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/utils/extensions/context_ex.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/utils/extensions/padding_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import 'process_card.dart';

class ProcessSection extends StatefulWidget {
  const ProcessSection({super.key});

  @override
  State<ProcessSection> createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Container(
      padding: context.defaultPagePadding(),
      child: VisibilityDetector(
        key: const Key('process-section-visibility'),
        onVisibilityChanged: (info) {
          if (!_isVisible && info.visibleFraction > 0.2) {
            setState(() => _isVisible = true);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            AnimatedFadeSlide(
              visibilityKey: 'section-title-planning',
              delay: 200.ms,
              beginY: 0.2,
              child: Caption(
                '\\  ${context.localization.section_title_planning} \\',
                color: kWhite,
              ),
            ),
            SizedBox(height: context.adaptive(8, 12, md: 10)),
            AnimatedFadeSlide(
              visibilityKey: 'planning-main-title',
              delay: 400.ms,
              beginY: 0.2,
              child: TitleSmall(
                context.localization.process_planning_title,
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
            AnimatedFadeSlide(
              visibilityKey: 'planning-main-description',
              delay: 500.ms,
              beginY: 0.2,
              child: BodyLarge(
                context.localization.process_planning_description,
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: context.adaptive(40, 60)),

            // --- Process Grid ---
            LayoutBuilder(
              builder: (_, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: processes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.adaptive(1, 4, md: 4, sm: 2),
                    crossAxisSpacing: context.adaptive(20, 30),
                    mainAxisSpacing: context.adaptive(20, 30),
                    mainAxisExtent: context.adaptive(
                      340, // mobile
                      380, // desktop
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final delay = 400 + (index * 150);

                    return AnimatedFadeSlide(
                      visibilityKey: 'process-card-$index',
                      delay: delay.ms,
                      beginY: 0.1,
                      child: ProcessCard(item: processes[index], index: index),
                    );
                  },
                );
              },
            ),
            SizedBox(height: context.adaptive(40, 60)),
          ],
        ),
      ),
    );
  }
}
