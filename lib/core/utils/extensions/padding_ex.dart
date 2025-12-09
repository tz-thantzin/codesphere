import 'package:flutter/material.dart';

import '../../constants/constant_sizes.dart';
import 'layout_adapter_ex.dart';

extension PaddingEX on BuildContext {
  EdgeInsetsGeometry defaultPagePadding({bool isFooter = false}) {
    final bool isDesktop = this.isDesktop;
    final double padding = isDesktop ? s64 : s32;
    return EdgeInsets.symmetric(
      horizontal: adaptive(padding * 0.8, padding),
      vertical: adaptive(padding * 0.8, padding),
    );
  }

  EdgeInsetsGeometry appbarPadding() {
    final bool isDesktop = this.isDesktop;
    final double padding = isDesktop ? s50 : s20;
    return EdgeInsets.symmetric(
      horizontal: adaptive(padding * 0.8, padding),
      vertical: adaptive(20, 28),
    );
  }
}
