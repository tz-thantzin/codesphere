// lib/presentation/widgets/services_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_data.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/glass_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.adaptive(120, 200, md: 160, xl: 240),
        horizontal: context.adaptive(24, 80, md: 60, xl: 120),
      ),
      child: Column(
        children: [
          // TITLE
          AnimatedFadeSlide(
            visibilityKey: 'services-title',
            delay: 300.ms,
            beginY: 0.4,
            child: SelectableText(
              context.localization.what_we_build,
              textAlign: TextAlign.center,
              style: context.displayMedium.copyWith(
                fontSize: context.adaptive(36, 55),
                height: 1.05,
                fontWeight: superBold,
                color: kWhite,
              ),
            ),
          ),

          SizedBox(height: context.adaptive(80, 140, md: 100)),

          // GRID
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = context.adaptive(1, 3);
              final aspectRatio = context.adaptive(0.9, 1.15);
              final spacing = context.adaptive(10.0, 30.0);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: aspectRatio,
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
            },
          ),
        ],
      ),
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
          _hovered ? 1.05 : 1.0,
          _hovered ? 1.05 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: GlassCard(
          padding: EdgeInsets.all(context.adaptive(28, 48)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.maxHeight;
              final iconSize = (maxHeight * 0.22).clamp(30.0, 64.0);
              final titleSize = (maxHeight * 0.09).clamp(15.0, 24.0);
              final descSize = (maxHeight * 0.07).clamp(10.0, 15.0);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ICON
                  Container(
                        padding: EdgeInsets.all(iconSize * 0.35),
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
                        end: const Offset(1.16, 1.16),
                        curve: Curves.easeOutBack,
                        duration: 600.ms,
                      ),

                  SizedBox(height: maxHeight * 0.12),

                  // TITLE
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      color: _hovered ? kAccentCyan : kTextPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: maxHeight * 0.06),

                  // DESCRIPTION
                  Expanded(
                    child: Text(
                      widget.desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: descSize,
                        height: 1.7,
                        color: kWhite70,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
