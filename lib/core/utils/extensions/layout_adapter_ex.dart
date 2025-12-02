import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

extension LayoutAdapter on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  T adaptive<T>(T xs, T lg, {T? sm, T? md, T? xl}) {
    return layout.value<T>(
      xs: xs,
      sm: sm ?? (md ?? xs),
      md: md ?? sm,
      lg: lg,
      xl: xl ?? lg,
    );
  }

  double autoAdaptive(
    double def, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    final double base = def;

    return layout.value(
      xs: xs ?? base * 0.85,
      sm: sm ?? base * 0.95,
      md: md ?? base,
      lg: lg ?? base * 1.4,
      xl: xl ?? base * 1.8,
    );
  }

  double assignHeight(
    double fraction, {
    double additions = 0,
    double subs = 0,
  }) {
    return (screenHeight - (subs) + (additions)) * fraction;
  }

  double assignWidth(double fraction, {double additions = 0, double subs = 0}) {
    return (screenWidth - (subs) + (additions)) * fraction;
  }

  /// mobile < 780
  bool get isMobile => MediaQuery.of(this).size.width < 780;

  /// desktop >= 1100
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;

  // Custom getter from user's provided snippet
  double get appBarHeight => autoAdaptive(60);
}
