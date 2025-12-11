import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/constants/constant_images.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/context_ex.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/utils/extensions/padding_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
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
    final bool isDesktop = context.isDesktop;

    return Container(
      padding: context.defaultPagePadding(),
      child: isDesktop
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main content: Text on left, Image on right
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Caption, Title, Separator, Description, Highlights
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  SizedBox(height: context.adaptive(s40, s80, md: s60)),
                  _buildDescriptionAndHighlights(context),
                ],
              ),
            ),
            SizedBox(width: context.adaptive(s60, s100)),
            // Right side: Profile Image
            Expanded(
              flex: 5,
              child: _buildProfileImage(context, isDesktop: true),
            ),
          ],
        ),

        SizedBox(height: context.adaptive(s80, s120, md: s100)),

        // Stats Grid
        _buildStatsSection(context),

        SizedBox(height: context.adaptive(s60, s100)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        SizedBox(height: context.adaptive(s40, s80, md: s60)),
        _buildProfileImage(context, isDesktop: false),
        SizedBox(height: context.adaptive(s40, s60)),
        _buildDescriptionAndHighlights(context),
        SizedBox(height: context.adaptive(s80, s120, md: s100)),
        _buildStatsSection(context),
        SizedBox(height: context.adaptive(s60, s100)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Caption
        AnimatedFadeSlide(
          visibilityKey: 'about-caption',
          delay: 100.ms,
          child: Caption(
            '\\  ${context.localization.section_title_about_us} \\',
            color: kWhite,
          ),
        ),
        SizedBox(height: context.adaptive(s8, s16, md: s12)),
        // Main Title
        AnimatedFadeSlide(
          visibilityKey: 'about-title',
          delay: 300.ms,
          child: TitleSmall(
            context.localization.about_us_main_title,
            textAlign: TextAlign.left,
            color: kWhite,
          ),
        ),
        SizedBox(height: context.adaptive(s8, s12, md: s10)),
        // Separator
        AnimatedFadeSlide(
          visibilityKey: 'about-separator',
          delay: 500.ms,
          child: const TitleSeparator(),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, {required bool isDesktop}) {
    return AnimatedFadeSlide(
      visibilityKey: 'about-image',
      delay: 200.ms,
      beginY: 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(s20),
        child: Image.asset(
          kAboutUsProfile,
          height: isDesktop ? s500 : s380,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionAndHighlights(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedFadeSlide(
          visibilityKey: 'about-main-description',
          delay: 400.ms,
          child: BodyLarge(
            context.localization.about_us_sub_description,
            textAlign: TextAlign.left,
            color: kGrey300,
          ),
        ),
        SizedBox(height: context.adaptive(s32, s48)),
        _buildHighlights(context),
      ],
    );
  }

  Widget _buildHighlights(BuildContext context) {
    final items = context.localization.about_us_highlights
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.adaptive(5.8, 7.0),
        mainAxisSpacing: s8,
        crossAxisSpacing: context.adaptive(s16, s24),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AnimatedFadeSlide(
          visibilityKey: 'highlight-$index',
          delay: (600 + index * 100).ms,
          beginY: 0.15,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded, color: kAccentCyan, size: s20),
              SizedBox(width: s12),
              Expanded(
                child: BodyMedium(
                  items[index],
                  color: kWhite.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-stats'),
      onVisibilityChanged: (info) {
        if (!_statsVisible && info.visibleFraction > 0.3) {
          setState(() => _statsVisible = true);
        }
      },
      child: _buildStatsGrid(context, _statsVisible),
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool animate) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: context.adaptive(s300, s350),
        childAspectRatio: context.adaptive(2.0, 2.2),
        mainAxisSpacing: context.adaptive(s20, s30),
        crossAxisSpacing: context.adaptive(s20, s30),
      ),
      itemBuilder: (context, index) {
        if (!animate) return const SizedBox.shrink();
        return StatCard(stat: stats[index], delay: (index * 120).ms);
      },
    );
  }
}
