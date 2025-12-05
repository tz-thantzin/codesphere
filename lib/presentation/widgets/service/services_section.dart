// lib/presentation/widgets/services_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_data.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/typography.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: context.adaptive(80, 160, md: 100),
        horizontal: 24,
      ),
      child: Column(
        children: [
          // TITLE
          AnimatedFadeSlide(
            visibilityKey: 'services-title',
            delay: 300.ms,
            beginY: 0.4,
            child: TitleLarge(
              context.localization.what_we_build,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: context.adaptive(60, 100, md: 80)),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.adaptive(24, 32),
              ),
              child: _ServicesGrid(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = context.adaptive(20.0, 30.0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: serviceData.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: context.adaptive(400, 450),
        childAspectRatio: context.adaptive(0.7, 1.2, sm: 0.9, md: 1.0, xl: 1.3),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) {
        final service = serviceData[index];
        return AnimatedFadeSlide(
          visibilityKey: 'service-card-$index',
          delay: (200 + index * 160).ms,
          beginY: 0.4,
          child: _ServiceCard(
            title: service["title"]!,
            desc: service["description"]!,
            icon: service["icon"]!,
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;

  const _ServiceCard({
    required this.title,
    required this.desc,
    required this.icon,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 600.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _hovered ? 1.03 : 1.0,
          _hovered ? 1.03 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: GlassCard(
          padding: EdgeInsets.symmetric(
            horizontal: context.adaptive(8, 16),
            vertical: context.adaptive(16, 32),
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight;
                final iconSize = (maxHeight * 0.22).clamp(28.0, 45.0);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ICON
                    Container(
                          padding: EdgeInsets.all(iconSize * 0.45),
                          decoration: BoxDecoration(
                            gradient: kButtonGradient,
                            borderRadius: BorderRadius.circular(iconSize * 0.4),
                            boxShadow: [
                              BoxShadow(
                                color: kAccentCyan.withValues(
                                  alpha: _hovered ? 0.8 : 0.5,
                                ),
                                blurRadius: _hovered ? 60 : 30,
                                spreadRadius: _hovered ? 12 : 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            size: iconSize,
                            color: Colors.white,
                          ),
                        )
                        .animate(target: _hovered ? 1 : 0)
                        .shimmer(duration: 2200.ms)
                        .scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.1, 1.1),
                          curve: Curves.easeOutBack,
                          duration: 600.ms,
                        ),
                    SizedBox(height: maxHeight * 0.08),
                    // TITLE
                    FlexiText(
                      text: widget.title,
                      factor: 0.09,
                      minSize: 15.0,
                      maxSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: _hovered ? kAccentCyan : kTextPrimary,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: maxHeight * 0.04),
                    // DESCRIPTION
                    FlexiText(
                      text: widget.desc,
                      factor: 0.85,
                      minSize: 12.0,
                      maxSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: kWhite70,
                      height: 1.4,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
