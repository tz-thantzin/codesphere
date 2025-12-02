import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      constraints: BoxConstraints(minHeight: context.screenHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Headline – triggers on appear
            AnimatedFadeSlide(
              visibilityKey: 'hero-headline',
              delay: 100.ms,
              beginY: 0.4,
              child: SelectableText(
                "We Build Exceptional\nMobile Experiences",
                style: context.displayLarge.copyWith(
                  fontSize: isMobile ? 56 : 84,
                  height: 1.1,
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
                "CodeSphere – Premium Android & iOS Development Studio",
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
              child: _ResponsiveButtons(
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

class _ResponsiveButtons extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onGetQuote;
  final bool isMobile;

  const _ResponsiveButtons({
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
          text: "View Our Work",
          onPressed: onViewWork,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 28 : 36,
            vertical: isMobile ? 16 : 20,
          ),
        ),
        GlowingButton(
          text: "Get a Free Quote",
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
