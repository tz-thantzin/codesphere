// lib/presentation/widgets/not_found_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_images.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/buttons/glowing_button.dart';
import '../../core/widgets/typography.dart';

class NotFoundSection extends StatelessWidget {
  final VoidCallback onGoHome;

  const NotFoundSection({required this.onGoHome, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return Container(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: context.screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  // ====================== Mobile Layout ======================
  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.appBarHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFadeSlide(
            visibilityKey: 'not-found-headline',
            delay: 100.ms,
            beginY: 0.4,
            visibleFraction: 0.1,
            child: DisplayLarge(
              '404',
              textAlign: TextAlign.center,
              color: kGrey200.withValues(alpha: 0.5), // Subtle watermark
            ),
          ),

          const SizedBox(height: 32),

          AnimatedFadeSlide(
            visibilityKey: 'not-found-subtitle',
            delay: 500.ms,
            beginY: 0.25,
            visibleFraction: 0.1,
            child: TitleLarge(
              context.localization.page_not_found,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),
          AnimatedFadeSlide(
            visibilityKey: 'not-found-image',
            delay: 300.ms,
            beginY: 0.3,
            visibleFraction: 0.1,
            child: Image.asset(
              kPageNotFound,
              height: context.screenHeight * 0.3,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),

          const SizedBox(height: 48),
          AnimatedFadeSlide(
            visibilityKey: 'not-found-description',
            delay: 700.ms,
            beginY: 0.2,
            visibleFraction: 0.01,
            child: BodyMedium(
              context.localization.the_page_you_are_looking_for_does_not_exist,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 80),

          AnimatedFadeSlide(
            visibilityKey: 'not-found-button',
            delay: 900.ms,
            beginY: 0.2,
            curve: Curves.easeOutBack,
            child: GlowingButton(
              text: context.localization.go_back_home,
              onPressed: onGoHome,
              filled: true,
              padding: EdgeInsets.symmetric(
                horizontal: context.isMobile ? 32 : 40,
                vertical: context.isMobile ? 16 : 20,
              ),
            ),
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }

  // ====================== Desktop & Tablet Layout ======================
  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side – Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedFadeSlide(
                    visibilityKey: 'not-found-headline',
                    delay: 100.ms,
                    beginY: 0.4,
                    visibleFraction: 0.1,
                    child: SelectableText(
                      '404',
                      style: TextStyle(
                        color: kGrey200.withValues(alpha: 0.9),
                        fontSize: 180,
                        letterSpacing: 8,
                        height: 0.9,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  AnimatedFadeSlide(
                    visibilityKey: 'not-found-subtitle',
                    delay: 500.ms,
                    beginY: 0.25,
                    visibleFraction: 0.1,
                    child: TitleLarge(
                      context.localization.page_not_found,
                      textAlign: TextAlign.left,
                    ),
                  ),

                  const SizedBox(height: 32),

                  AnimatedFadeSlide(
                    visibilityKey: 'not-found-description',
                    delay: 700.ms,
                    beginY: 0.2,
                    visibleFraction: 0.1,
                    child: BodyLarge(
                      context
                          .localization
                          .the_page_you_are_looking_for_does_not_exist,
                      textAlign: TextAlign.left,
                    ),
                  ),

                  const SizedBox(height: 32),

                  AnimatedFadeSlide(
                    visibilityKey: 'not-found-button',
                    delay: 900.ms,
                    beginY: 0.2,
                    visibleFraction: 0.1,
                    curve: Curves.easeOutBack,
                    child: GlowingButton(
                      text: context.localization.go_back_home,
                      onPressed: onGoHome,
                      filled: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.isMobile ? 32 : 40,
                        vertical: context.isMobile ? 16 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 80),

            // Right side – Image
            AnimatedFadeSlide(
              visibilityKey: 'not-found-image',
              delay: 300.ms,
              beginY: 0.3,
              visibleFraction: 0.1,
              child: SizedBox(
                width: context.screenWidth * 0.45,
                child: Image.asset(kPageNotFound, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
