// lib/presentation/widgets/what_we_do_section/what_we_do_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_images.dart';
import '../../../core/utils/extensions/context_ex.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/utils/extensions/padding_ex.dart';
import '../../../core/widgets/animated_blur_widget.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';

class WhatWeDoSection extends StatefulWidget {
  const WhatWeDoSection({super.key});

  @override
  State<WhatWeDoSection> createState() => _WhatWeDoSectionState();
}

class _WhatWeDoSectionState extends State<WhatWeDoSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Container(
      padding: context.defaultPagePadding(),
      child: VisibilityDetector(
        key: const Key('what-we-do-visibility'),
        onVisibilityChanged: (info) {
          if (!_isVisible && info.visibleFraction > 0.2) {
            setState(() => _isVisible = true);
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
        Expanded(flex: 5, child: _buildImage(context)),
        SizedBox(width: context.adaptive(40, 80)),
        Expanded(flex: 6, child: _buildContent(context, isDesktop: true)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildImage(context),
        SizedBox(height: context.adaptive(40, 60)),
        _buildContent(context, isDesktop: false),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return AnimatedImage(
      visibilityKey: 'what-we-do-image',
      child: Container(
        height: context.adaptive(300, 500),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage(kWhatWeDoProfile),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedFadeSlide(
          visibilityKey: 'section-title-wwd',
          delay: 200.ms,
          beginY: 0.2,
          child: Caption(
            '\\  ${context.localization.section_title_wwd} \\',
            color: kWhite,
          ),
        ),

        SizedBox(height: context.adaptive(8, 12, md: 10)),

        AnimatedFadeSlide(
          visibilityKey: 'wwd-main-title',
          delay: 400.ms,
          beginY: 0.2,
          child: TitleSmall(
            context.localization.what_we_do_main_title,
            textAlign: TextAlign.left,
            color: kWhite,
          ),
        ),

        SizedBox(height: context.adaptive(8, 12, md: 10)),

        AnimatedFadeSlide(
          visibilityKey: 'about-title-separator',
          delay: 500.ms,
          beginY: 0.2,
          child: const TitleSeparator(),
        ),

        SizedBox(height: context.adaptive(32, 48, md: 40)),

        AnimatedFadeSlide(
          visibilityKey: 'wwd-main-desc',
          delay: 600.ms,
          beginY: 0.2,
          child: BodyLarge(
            context.localization.what_we_do_main_description,
            textAlign: TextAlign.left,
          ),
        ),

        SizedBox(height: context.adaptive(30, 40)),

        IntrinsicHeight(child: _buildFeatureCards(context, isDesktop)),
      ],
    );
  }

  Widget _buildFeatureCards(BuildContext context, bool isDesktop) {
    final items = [
      _FeatureItem(
        icon: kOurVisionIcon,
        title: context.localization.our_vision_title,
        desc: context.localization.our_vision_description,
        delay: 700,
      ),
      _FeatureItem(
        icon: kOurGoalIcon,
        title: context.localization.our_goal_title,
        desc: context.localization.our_goal_description,
        delay: 800,
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: items[0]),
          SizedBox(width: context.adaptive(20, 30)),
          Expanded(child: items[1]),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(child: items[0]),
          const SizedBox(height: 20),
          SizedBox(child: items[1]),
        ],
      );
    }
  }
}

class _FeatureItem extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final int delay;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.desc,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'feature-$title',
      delay: delay.ms,
      beginY: 0.2,
      child: Container(
        constraints: const BoxConstraints(minHeight: 180),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: kGrey200.withValues(alpha: 0.4),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ICON
            Container(
              width: 55,
              height: 55,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kRed.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.asset(icon, color: kRed),
            ),

            const SizedBox(height: 16),

            // TITLE
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kRed,
              ),
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            Text(
              desc,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: kGrey700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
