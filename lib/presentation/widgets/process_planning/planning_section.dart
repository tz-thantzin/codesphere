import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/constants/constant_sizes.dart';
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
    return Container(
      padding: context.defaultPagePadding(),
      child: VisibilityDetector(
        key: const Key('process-section'),
        onVisibilityChanged: (info) {
          if (!_isVisible && info.visibleFraction > 0.2) {
            setState(() => _isVisible = true);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caption
            AnimatedFadeSlide(
              visibilityKey: 'process-caption',
              delay: 100.ms,
              beginY: 0.15,
              child: Caption(
                '\\  ${context.localization.section_title_planning} \\',
                color: kWhite,
              ),
            ),

            SizedBox(height: context.adaptive(s8, s12, md: s10)),

            // Main Title
            AnimatedFadeSlide(
              visibilityKey: 'process-title',
              delay: 300.ms,
              beginY: 0.2,
              child: TitleSmall(
                context.localization.process_planning_title,
                textAlign: TextAlign.left,
                color: kWhite,
              ),
            ),

            SizedBox(height: context.adaptive(s8, s12, md: s10)),

            // Separator
            AnimatedFadeSlide(
              visibilityKey: 'process-separator',
              delay: 500.ms,
              beginY: 0.15,
              child: const TitleSeparator(),
            ),

            SizedBox(height: context.adaptive(s40, s80, md: s60)),

            // Description
            AnimatedFadeSlide(
              visibilityKey: 'process-description',
              delay: 600.ms,
              beginY: 0.2,
              child: BodyLarge(
                context.localization.process_planning_description,
                textAlign: TextAlign.left,
                color: kGrey300,
              ),
            ),

            SizedBox(height: context.adaptive(s40, s80, md: s60)),

            // Process Grid with Staggered Animation
            LayoutBuilder(
              builder: (_, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: processes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.adaptive(1, 4, md: 2, sm: 2),
                    crossAxisSpacing: context.adaptive(s20, s30),
                    mainAxisSpacing: context.adaptive(s20, s30),
                    mainAxisExtent: context.adaptive(s340, s380),
                  ),
                  itemBuilder: (context, index) {
                    final row = index ~/ context.adaptive(1, 4);
                    final col = index % context.adaptive(1, 4);
                    final delay = 100 + (row * 200) + (col * 100);

                    return AnimatedFadeSlide(
                      visibilityKey: 'process-card-$index',
                      delay: delay.ms,
                      beginY: 0.25,
                      curve: Curves.easeOutCubic,
                      child: ProcessCard(item: processes[index], index: index),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
