import 'package:codesphere/core/constants/constant_colors.dart';
import 'package:codesphere/core/constants/constant_sizes.dart';
import 'package:codesphere/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

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
