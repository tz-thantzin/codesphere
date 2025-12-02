import 'package:codesphere/core/constants/constant_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/utils/extensions/layout_adapter_ex.dart';
import '../../core/utils/extensions/theme_ex.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/glass_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 32),
      child: Column(
        children: [
          // Title
          AnimatedFadeSlide(
            visibilityKey: 'services-title',
            delay: 500.ms,
            beginY: 0.4,
            child: SelectableText(
              "What We Build",
              style: context.displayMedium.copyWith(
                fontSize: context.adaptive(48, 72),
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 80),

          // Responsive Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final int crossAxisCount = constraints.maxWidth > 1200
                  ? 3
                  : constraints.maxWidth > 800
                  ? 2
                  : 1;

              final double aspectRatio = crossAxisCount == 1
                  ? 0.85 // Taller on mobile
                  : crossAxisCount == 2
                  ? 1.0
                  : 1.1; // Slightly wider on large screens

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                ),
                itemBuilder: (context, index) {
                  final service = serviceData[index];

                  return AnimatedFadeSlide(
                    visibilityKey: 'service-card-$index',
                    delay: Duration(milliseconds: 200 + index * 150),
                    beginY: 0.3,
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
  final IconData? icon;

  const _ServiceCard({required this.title, required this.desc, this.icon});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 600.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.05 : 1.0,
          _isHovered ? 1.05 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: GlassCard(
          padding: EdgeInsets.all(isMobile ? 28 : 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                    duration: 500.ms,
                    padding: EdgeInsets.all(isMobile ? 15 : 20),
                    decoration: BoxDecoration(
                      gradient: kButtonGradient,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: kAccentCyan.withValues(
                            alpha: _isHovered ? 0.7 : 0.4,
                          ),
                          blurRadius: _isHovered ? 60 : 30,
                          spreadRadius: _isHovered ? 12 : 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      size: isMobile ? 48 : 65,
                      color: Colors.white,
                    ),
                  )
                  .animate()
                  .scaleXY(begin: 1.0, end: 1.15, duration: 600.ms)
                  .shimmer(
                    duration: 1600.ms,
                    color: kAccentCyan.withValues(alpha: 0.6),
                  ),

              const SizedBox(height: 32),

              // TITLE
              SelectableText(
                widget.title,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: isMobile ? 21 : 24,
                  color: _isHovered ? kAccentCyan : kTextPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // DESCRIPTION
              Text(
                widget.desc,
                style: context.bodyMedium.copyWith(
                  color: kWhite70,
                  fontSize: isMobile ? 15 : 16,
                  height: 1.7,
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
