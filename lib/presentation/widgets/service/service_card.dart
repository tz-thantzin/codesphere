import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/typography.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;
    final double iconBoxSize = context.adaptive(s60, s80);
    final double iconSize = context.adaptive(s32, s48);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 600.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.04 : 1.0,
          _isHovered ? 1.04 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        padding: EdgeInsets.all(context.adaptive(s24, s32)),
        decoration: BoxDecoration(
          color: kGrey25,
          borderRadius: BorderRadius.circular(s20),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: 0.04),
              blurRadius: _isHovered ? 32 : 20,
              offset: Offset(0, _isHovered ? 12 : 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
                  width: iconBoxSize,
                  height: iconBoxSize,
                  padding: const EdgeInsets.all(s16),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(s16),
                    boxShadow: [
                      BoxShadow(
                        color: kLightYellow.withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(widget.icon, size: iconSize, color: kDeepOrange),
                )
                .animate(target: _isHovered ? 1 : 0)
                .shimmer(
                  duration: 2400.ms,
                  color: kDeepOrange.withValues(alpha: 0.15),
                )
                .scaleXY(begin: 1.0, end: 1.12, curve: Curves.easeOutBack),

            SizedBox(height: context.adaptive(s24, s32)),

            // Title
            TitleSmall(
              widget.title,
              color: kPrimary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: s12),

            // Decorative Separator
            Row(
              children: [
                Container(
                  width: s28,
                  height: s4,
                  decoration: BoxDecoration(
                    color: kDeepOrange,
                    borderRadius: BorderRadius.circular(s2),
                  ),
                ),
                const SizedBox(width: s6),
                Container(
                  width: s8,
                  height: s4,
                  decoration: BoxDecoration(
                    color: kDeepOrange.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(s2),
                  ),
                ),
              ],
            ),

            const SizedBox(height: s20),

            // Description
            BodyMedium(
              widget.description,
              color: kGrey700,
              maxLines: isMobile ? 3 : 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
