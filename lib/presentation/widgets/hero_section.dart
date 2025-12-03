//lib/presentation/widgets/hero_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/utils/extensions/context_ex.dart';
import '../../core/utils/extensions/layout_adapter_ex.dart';
import '../../core/utils/extensions/theme_ex.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/glowing_button.dart';

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
    final bool isMobile = context.isMobile;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.screenHeight * 0.95),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Headline
            AnimatedFadeSlide(
              visibilityKey: 'hero-headline',
              delay: 100.ms,
              beginY: 0.4,
              child: SelectableText(
                context.localization.we_build_exceptional,
                style: context.displayLarge.copyWith(
                  fontSize: context.adaptive(36, 65),
                  height: 1.05,
                  fontWeight: superBold,
                  color: kWhite,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Subtitle
            AnimatedFadeSlide(
              visibilityKey: 'hero-subtitle',
              delay: 500.ms,
              beginY: 0.25,
              child: SelectableText(
                context.localization.premium_android_ios_studio,
                style: context.titleMedium.copyWith(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 80),

            // Buttons – scale + fade in together
            AnimatedFadeSlide(
              visibilityKey: 'hero-buttons',
              delay: 800.ms,
              beginY: 0.2,
              curve: Curves.easeOutBack,
              child: _buildButtons(
                onViewWork: onViewWork,
                onGetQuote: onGetQuote,
                isMobile: isMobile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildButtons extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onGetQuote;
  final bool isMobile;

  const _buildButtons({
    required this.onViewWork,
    required this.onGetQuote,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: isMobile ? 20 : 32,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        GlowingButton(
          text: context.localization.view_our_work,
          onPressed: onViewWork,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 28 : 36,
            vertical: isMobile ? 16 : 20,
          ),
        ),
        GlowingButton(
          text: context.localization.get_free_quote,
          onPressed: onGetQuote,
          filled: true,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 40,
            vertical: isMobile ? 16 : 20,
          ),
        ),
      ],
    );
  }
}
