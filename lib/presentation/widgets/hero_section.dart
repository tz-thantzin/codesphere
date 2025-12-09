// lib/presentation/widgets/hero_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_images.dart';
import '../../core/constants/constant_sizes.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_blur_widget.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/buttons/gradient_button.dart';
import '../../core/widgets/typography.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onGetQuote;

  const HeroSection({
    required this.onViewWork,
    required this.onGetQuote,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.isDesktop;
    return Container(
      constraints: BoxConstraints(minHeight: context.sectionHeight),
      padding: context.defaultPagePadding(),
      alignment: Alignment.topCenter,
      child: isDesktop
          ? Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: _HeroTextContent(
                      onBuildTeam: onViewWork,
                      isMobile: false,
                    ),
                  ),
                  const Spacer(flex: 1),

                  Expanded(flex: 5, child: _HeroImage(isMobile: false)),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _HeroTextContent(onBuildTeam: onViewWork, isMobile: true),
                const SizedBox(height: 64),
                _HeroImage(isMobile: true),
              ],
            ),
    );
  }
}

class _HeroTextContent extends StatelessWidget {
  final VoidCallback onBuildTeam;
  final bool isMobile;

  const _HeroTextContent({required this.onBuildTeam, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final String headline = context.localization.hero_building_mobile_apps;
    final String body = context.localization.hero_mobile_app_description;

    final TextAlign textAlign = isMobile ? TextAlign.center : TextAlign.left;
    final CrossAxisAlignment alignment = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        AnimatedFadeSlide(
          visibilityKey: 'hero-headline',
          delay: 100.ms,
          beginY: 0.4,
          visibleFraction: 0.1,
          child: TitleLarge(headline, textAlign: textAlign),
        ),

        SizedBox(height: isMobile ? 16 : 24),

        AnimatedFadeSlide(
          visibilityKey: 'hero-subtitle',
          delay: 500.ms,
          beginY: 0.25,
          visibleFraction: 0.1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? 400 : double.infinity,
            ),
            child: BodyMedium(body, textAlign: textAlign),
          ),
        ),

        SizedBox(height: isMobile ? 32 : 48),

        AnimatedFadeSlide(
          visibilityKey: 'hero-button',
          delay: 800.ms,
          beginY: 0.2,
          visibleFraction: 0.1,
          curve: Curves.easeOutBack,
          child: _HeroButton(
            text: context.localization.view_our_work,
            onPressed: onBuildTeam,
          ),
        ),
      ],
    );
  }
}

class _HeroButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _HeroButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      gradientColors: const [kLightYellow, kDeepOrange],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final bool isMobile;

  const _HeroImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = isMobile
            ? context.assignHeight(0.4)
            : context.assignHeight(0.65);

        return AnimatedImage(
          visibilityKey: "hero-image",
          visibleFraction: 0.1,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: kWhite, width: 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(s14),
                bottomLeft: Radius.circular(s32),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(s14),
                bottomLeft: Radius.circular(s32),
              ),
              child: Image.asset(kHeroSectionProfile, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
