// lib/presentation/widgets/about/about_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/constant_data.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/typography.dart';
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
        horizontal: context.adaptive(20, 40),
      ),
      child: Column(
        children: [
          VisibilityDetector(
            key: const Key('about-title'),
            onVisibilityChanged: (info) {
              if (!_titleVisible && info.visibleFraction > 0.3) {
                setState(() => _titleVisible = true);
              }
            },
            child:
                TitleLarge(
                      context.localization.crafting_mobile,
                      textAlign: TextAlign.center,
                    )
                    .animate(target: _titleVisible ? 1 : 0)
                    .fadeIn(duration: 900.ms, delay: 300.ms)
                    .slideY(begin: 0.4, curve: Curves.easeOutCubic),
          ),

          SizedBox(height: context.adaptive(32, 48, md: 40)),

          VisibilityDetector(
            key: const Key('about-subtitle'),
            onVisibilityChanged: (info) {
              if (!_subtitleVisible && info.visibleFraction > 0.3) {
                setState(() => _subtitleVisible = true);
              }
            },
            child:
                Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.adaptive(16, 80),
                      ),
                      child: BodyLarge(
                        context.localization.about_codesphere_description,
                        textAlign: TextAlign.center,
                      ),
                    )
                    .animate(target: _subtitleVisible ? 1 : 0)
                    .fadeIn(duration: 900.ms, delay: 600.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOutCubic),
          ),

          SizedBox(height: context.adaptive(60, 100, md: 80)),

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
        final crossCount = context.adaptive(2, 4);
        final aspectRatio = context.adaptive(1.5, 1.7);
        final spacing = context.adaptive(20.0, 40.0);

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
            return StatCard(stat: stats[index], delay: (index * 140).ms);
          },
        );
      },
    );
  }
}
