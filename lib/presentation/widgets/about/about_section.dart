import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/utils/extensions/extensions.dart';
import 'stat_card.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _titleVisible = false;
  bool _subtitleVisible = false;
  bool _statsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.assignHeight(0.12),
        horizontal: 20,
      ),
      child: Column(
        children: [
          // Title
          VisibilityDetector(
            key: const Key('about-title'),
            onVisibilityChanged: (info) {
              if (!_titleVisible && info.visibleFraction > 0.3) {
                setState(() => _titleVisible = true);
              }
            },
            child:
                SelectableText(
                      "Crafting the Future of Mobile,\nOne App at a Time",
                      style: context.displayMedium.copyWith(
                        fontSize: context.adaptive(36, 68),
                        fontWeight: superBold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate(target: _titleVisible ? 1 : 0)
                    .fadeIn(duration: 1000.ms, delay: 500.ms)
                    .slideY(begin: 0.4, curve: Curves.easeOutCubic),
          ),

          const SizedBox(height: 40),

          // Subtitle — animates only when visible
          VisibilityDetector(
            key: const Key('about-subtitle'),
            onVisibilityChanged: (info) {
              if (!_subtitleVisible && info.visibleFraction > 0.3) {
                setState(() => _subtitleVisible = true);
              }
            },
            child:
                Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SelectableText(
                        "At CodeSphere, we don’t just build apps — we architect digital experiences "
                        "that scale, perform, and delight. With experience in Flutter, Swift, Kotlin "
                        "and modern UI engineering, we deliver reliable and beautiful solutions.",
                        style: context.bodyLarge.copyWith(
                          fontSize: context.adaptive(15, 18),
                          height: 1.75,
                          color: kWhite70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                    .animate(target: _subtitleVisible ? 1 : 0)
                    .fadeIn(duration: 1000.ms, delay: 500.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          ),

          const SizedBox(height: 80),

          VisibilityDetector(
            key: const Key('stats-grid'),
            onVisibilityChanged: (info) {
              if (!_statsVisible && info.visibleFraction > 0.3) {
                setState(() => _statsVisible = true);
              }
            },
            child: _buildStatsGrid(_statsVisible),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool startAnimation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmall = width < 360;
        final isMobile = context.isMobile;

        final crossCount = isSmall ? 2 : (isMobile ? 2 : 4);
        final aspectRatio = isSmall ? 1.35 : (isMobile ? 1.5 : 1.7);
        final spacing = isSmall ? 16.0 : (isMobile ? 20.0 : 32.0);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            if (!startAnimation) return const SizedBox.shrink();
            return StatCard(stat: stats[index], delay: (index * 160).ms);
          },
        );
      },
    );
  }
}
