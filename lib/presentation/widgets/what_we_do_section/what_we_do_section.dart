import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_images.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/feature_model.dart';
import 'feature_card.dart';

class WhatWeDoSection extends StatefulWidget {
  const WhatWeDoSection({super.key});

  @override
  State<WhatWeDoSection> createState() => _WhatWeDoSectionState();
}

class _WhatWeDoSectionState extends State<WhatWeDoSection> {
  bool _isSectionVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Container(
      padding: context.defaultPagePadding(),
      child: VisibilityDetector(
        key: const Key('what-we-do-section'),
        onVisibilityChanged: (info) {
          if (!_isSectionVisible && info.visibleFraction > 0.2) {
            setState(() => _isSectionVisible = true);
          }
        },
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _buildImage()),
        SizedBox(width: context.adaptive(s40, s80)),
        Expanded(flex: 6, child: _buildContent(isDesktop: true)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        SizedBox(height: context.adaptive(s40, s60)),
        _buildContent(isDesktop: false),
      ],
    );
  }

  Widget _buildImage() {
    return AnimatedFadeSlide(
      visibilityKey: 'wwd-image',
      beginY: 0.15,
      child: Container(
        height: context.adaptive(s300, s500),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s20),
          image: const DecorationImage(
            image: AssetImage(kWhatWeDoProfile),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: 0.1),
              blurRadius: s20,
              offset: const Offset(0, s10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Caption
        AnimatedFadeSlide(
          visibilityKey: 'wwd-caption',
          delay: 200.ms,
          child: Caption(
            '\\  ${context.localization.section_title_wwd} \\',
            color: kWhite,
          ),
        ),
        SizedBox(height: context.adaptive(s8, s12, md: s10)),

        // Main Title
        AnimatedFadeSlide(
          visibilityKey: 'wwd-title',
          delay: 400.ms,
          child: TitleSmall(
            context.localization.what_we_do_main_title,
            textAlign: TextAlign.left,
            color: kWhite,
          ),
        ),
        SizedBox(height: context.adaptive(s8, s12, md: s10)),

        // Separator
        AnimatedFadeSlide(
          visibilityKey: 'wwd-separator',
          delay: 500.ms,
          child: const TitleSeparator(),
        ),
        SizedBox(height: context.adaptive(s32, s48, md: s40)),

        // Description
        AnimatedFadeSlide(
          visibilityKey: 'wwd-description',
          delay: 600.ms,
          child: BodyLarge(
            context.localization.what_we_do_main_description,
            textAlign: TextAlign.left,
            color: kGrey300,
          ),
        ),
        SizedBox(height: context.adaptive(s30, s40)),

        // Feature Cards
        _buildFeatureCards(isDesktop: isDesktop),
      ],
    );
  }

  Widget _buildFeatureCards({required bool isDesktop}) {
    final features = [
      FeatureModel(
        icon: kOurVisionIcon,
        title: context.localization.our_vision_title,
        description: context.localization.our_vision_description,
        delay: 700,
      ),
      FeatureModel(
        icon: kOurGoalIcon,
        title: context.localization.our_goal_title,
        description: context.localization.our_goal_description,
        delay: 850,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: features
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: e.key == 0 ? context.adaptive(s20, s30) : 0,
                  ),
                  child: FeatureCard(data: e.value),
                ),
              ),
            )
            .toList(),
      );
    }

    return Column(
      children: features
          .map(
            (data) => Padding(
              padding: const EdgeInsets.only(bottom: s20),
              child: FeatureCard(data: data),
            ),
          )
          .toList(),
    );
  }
}
