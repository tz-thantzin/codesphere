import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/typography.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.adaptive(s30, s40);

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

        decoration: BoxDecoration(
          color: kGrey25,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(context.adaptive(s24, s32)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ICON BOX
                Container(
                      width: context.adaptive(s60, s70),
                      height: context.adaptive(s60, s70),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: kLightYellow.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        widget.icon,
                        size: iconSize,
                        color: kDeepOrange,
                      ),
                    )
                    .animate(target: _hovered ? 1 : 0)
                    .shimmer(duration: 2200.ms)
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.05, 1.05),
                      curve: Curves.easeOutBack,
                      duration: 600.ms,
                    ),

                SizedBox(height: context.adaptive(s24, s32)),

                // TITLE
                TitleSmall(
                  widget.title,
                  color: kPrimary,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),

                const SizedBox(height: 12),

                // Custom Separator
                Row(
                  children: [
                    Container(
                      width: 25,
                      height: 3,
                      decoration: BoxDecoration(
                        color: kDeepOrange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 5,
                      height: 3,
                      decoration: BoxDecoration(
                        color: kDeepOrange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // DESCRIPTION
                BodyMedium(
                  widget.desc,
                  color: kGrey800,
                  textAlign: TextAlign.left,
                  maxLines: 4,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
