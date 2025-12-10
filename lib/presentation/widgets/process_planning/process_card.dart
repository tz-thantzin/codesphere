import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/process_item_model.dart';

class ProcessCard extends StatefulWidget {
  final ProcessItemModel item;
  final int index;

  const ProcessCard({super.key, required this.item, required this.index});

  @override
  State<ProcessCard> createState() => _ProcessCardState();
}

class _ProcessCardState extends State<ProcessCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String numberString = (widget.index + 1).toString().padLeft(2, '0');
    final bool isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 700.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.04 : 1.0,
          _isHovered ? 1.04 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: kGrey25,
          borderRadius: BorderRadius.circular(s20),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: _isHovered ? 0.08 : 0.04),
              blurRadius: _isHovered ? 40 : 20,
              offset: Offset(0, _isHovered ? 16 : 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Number
            Positioned(
              top: s10,
              right: s20,
              child: Opacity(
                opacity: 0.4,
                child: TitleLarge(numberString, color: kGrey300),
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.all(context.adaptive(s24, s32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Box
                  Container(
                        width: context.adaptive(s60, s70),
                        height: context.adaptive(s60, s70),
                        padding: const EdgeInsets.all(s16),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(s18),
                          boxShadow: [
                            BoxShadow(
                              color: kLightYellow.withValues(alpha: 0.18),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          widget.item.iconPath,
                          fit: BoxFit.contain,
                          color: kDeepOrange,
                        ),
                      )
                      .animate(target: _isHovered ? 1 : 0)
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.15, 1.15),
                        curve: Curves.easeOutBack,
                      )
                      .shimmer(
                        duration: 2800.ms,
                        color: kDeepOrange.withValues(alpha: 0.1),
                      ),

                  SizedBox(height: context.adaptive(s24, s32)),

                  // Title
                  TitleSmall(
                    widget.item.title,
                    color: kPrimary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: s14),

                  // Decorative Separator
                  Row(
                    children: [
                      Container(
                        width: s32,
                        height: s4,
                        decoration: BoxDecoration(
                          color: kDeepOrange,
                          borderRadius: BorderRadius.circular(s2),
                        ),
                      ),
                      const SizedBox(width: s8),
                      Container(
                        width: s10,
                        height: s4,
                        decoration: BoxDecoration(
                          color: kDeepOrange.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(s2),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: s24),

                  // Description
                  BodyMedium(
                    widget.item.description,
                    color: kGrey700,
                    maxLines: isMobile ? 4 : 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
