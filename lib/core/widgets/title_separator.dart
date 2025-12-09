import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_sizes.dart';
import '../utils/extensions/extensions.dart';

class TitleSeparator extends StatelessWidget {
  final Color color;
  const TitleSeparator({super.key, this.color = kLightYellow});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: color,
          width: context.adaptive(s80, s100, md: s96),
          height: context.adaptive(s2, s8, md: s4),
        ),
        SizedBox(width: s8),
        Container(
          color: color,
          width: context.adaptive(s4, s16, md: s8),
          height: context.adaptive(s2, s8, md: s4),
        ),
      ],
    );
  }
}
