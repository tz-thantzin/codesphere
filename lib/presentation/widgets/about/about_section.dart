import 'package:codesphere/core/constants/constant_colors.dart';
import 'package:codesphere/core/widgets/animated_fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_data.dart';
import '../../../core/constants/constant_images.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_blur_widget.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import 'stat_card.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _statsVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Container(
      padding: context.defaultPagePadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          AnimatedFadeSlide(
            visibilityKey: 'section-title-about',
            delay: 200.ms,
            beginY: 0.2,
            child: Caption(
              '\\  ${context.localization.section_title_about_us} \\',
              color: kWhite,
            ),
          ),
          SizedBox(height: context.adaptive(8, 12, md: 10)),

          // Main Title
          AnimatedFadeSlide(
            visibilityKey: 'about-main-title',
            delay: 400.ms,
            beginY: 0.2,
            child: TitleSmall(
              context.localization.about_us_main_title,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: context.adaptive(8, 12, md: 10)),

          // Title Separator
          AnimatedFadeSlide(
            visibilityKey: 'about-title-separator',
            delay: 200.ms,
            beginY: 0.2,
            child: const TitleSeparator(),
          ),

          SizedBox(height: context.adaptive(32, 48, md: 40)),
          _buildProfileAndDescription(context, isDesktop),

          SizedBox(height: context.adaptive(60, 100, md: 80)),
          VisibilityDetector(
            key: const Key('stats-grid'),
            onVisibilityChanged: (info) {
              if (!_statsVisible && info.visibleFraction > 0.3) {
                setState(() => _statsVisible = true);
              }
            },
            child: _buildStatsGrid(context, _statsVisible),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProfileAndDescription(BuildContext context, bool isDesktop) {
    final imageWidget = AnimatedImage(
      visibilityKey: "about-image",
      visibleFraction: 0.3,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isDesktop
              ? context.screenWidth * 0.3
              : context.screenWidth * 0.7,
        ),
        child: Image.asset(kAboutUsProfile, fit: BoxFit.contain),
      ),
    );

    // The main description text
    final descriptionText = AnimatedFadeSlide(
      visibilityKey: 'about-main-description',
      delay: 500.ms,
      beginY: 0.2,
      child: BodyLarge(
        context.localization.about_us_sub_description,
        textAlign: TextAlign.left,
      ),
    );

    final textContent = Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        descriptionText,
        SizedBox(height: context.adaptive(s24, s32)),

        _buildHighLights(context, isDesktop),
      ],
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: textContent),
          const Spacer(flex: 1),
          Expanded(flex: 3, child: imageWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageWidget,
          SizedBox(height: context.adaptive(32, 48)),
          textContent,
        ],
      );
    }
  }

  Widget _buildHighLights(BuildContext context, bool isDesktop) {
    final rawText = context.localization.about_us_highlights;
    final marks = rawText.split(',').map((s) => s.trim()).toList();

    return SizedBox(
      width: isDesktop ? 600 : context.screenWidth * 0.75,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: context.adaptive(5.5, 6.5),
        mainAxisSpacing: 2,
        crossAxisSpacing: 20,
        padding: EdgeInsets.zero,
        children: marks.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;

          return AnimatedFadeSlide(
            visibilityKey: 'key-mark-$index',
            delay: (600 + index * 100).ms,
            beginY: 0.2,
            child: Row(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mark Icon
                const Icon(Icons.check, color: kWhite, size: 18),
                const SizedBox(width: 8),
                // Text
                Expanded(
                  child: BodyMedium(
                    text,
                    color: kWhite.withValues(alpha: 0.8),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool startAnimation) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: context.adaptive(300, 350),
        childAspectRatio: context.adaptive(1.7, 2.2, sm: 1.9, md: 2.1, xl: 2.3),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        if (!startAnimation) return const SizedBox.shrink();
        return StatCard(stat: stats[index], delay: (index * 140).ms);
      },
    );
  }
}
