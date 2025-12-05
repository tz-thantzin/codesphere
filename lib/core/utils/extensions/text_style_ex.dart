import 'package:flutter/material.dart';

import '../../widgets/typography.dart';

extension TextStyleOverride on Widget {
  Widget copyWithStyle({
    FontWeight? fontWeight,
    double? height,
    Color? color,
    double? letterSpacing,
  }) {
    return Builder(
      builder: (context) {
        final widget = this;
        if (widget is BaseText) {
          return BaseText(
            widget.text,
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            style: widget.style.copyWith(
              fontWeight: fontWeight ?? widget.style.fontWeight,
              height: height ?? widget.style.height,
              color: color ?? widget.style.color,
              letterSpacing: letterSpacing,
            ),
          );
        }
        return widget;
      },
    );
  }
}
