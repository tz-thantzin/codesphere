// lib/presentation/widgets/hero_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/glowing_button.dart';
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
    return Container(
      constraints: BoxConstraints(minHeight: context.screenHeight * 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      margin: EdgeInsets.only(top: context.appBarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedFadeSlide(
            visibilityKey: 'hero-headline',
            delay: 100.ms,
            beginY: 0.4,
            child: TitleLarge(
              context.localization.we_build_exceptional,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          AnimatedFadeSlide(
            visibilityKey: 'hero-subtitle',
            delay: 500.ms,
            beginY: 0.25,
            child: SubtitleLarge(
              context.localization.premium_android_ios_studio,
            ),
          ),

          const SizedBox(height: 80),

          AnimatedFadeSlide(
            visibilityKey: 'hero-buttons',
            delay: 800.ms,
            beginY: 0.2,
            curve: Curves.easeOutBack,
            child: _HeroButtons(
              onViewWork: onViewWork,
              onGetQuote: onGetQuote,
              isMobile: context.isMobile,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroButtons extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onGetQuote;
  final bool isMobile;

  const _HeroButtons({
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
