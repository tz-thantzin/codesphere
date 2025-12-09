import 'package:flutter/material.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/typography.dart';
import '../../../models/process_item.dart';

class ProcessCard extends StatelessWidget {
  final ProcessItem item;
  final int index;

  const ProcessCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final numberString = (index + 1).toString().padLeft(2, '0');

    return Container(
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
      child: Stack(
        children: [
          // Large Background Number (Top Right)
          Positioned(
            top: 10,
            right: 20,
            child: TitleLarge(
              numberString,
              color: kGrey200.withValues(alpha: 0.5),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(context.adaptive(24, 32)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Box
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
                      child: Image.asset(item.iconPath, fit: BoxFit.contain),
                    ),

                    SizedBox(height: context.adaptive(s24, s32)),

                    // Title
                    TitleSmall(
                      item.title,
                      color: kPrimary,
                      textAlign: TextAlign.left,
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

                    // Description
                    BodyMedium(
                      item.description,
                      color: kGrey800,
                      textAlign: TextAlign.left,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
