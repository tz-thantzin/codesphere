import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_sizes.dart';

const superBold = FontWeight.w900;
const bold = FontWeight.w700;
const semiBold = FontWeight.w600;
const medium = FontWeight.w500;
const light = FontWeight.w300;

extension ThemeEx on BuildContext {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kPrimary,
      textTheme: GoogleFonts.interTextTheme(textTheme),
      colorScheme: colorScheme,
      textSelectionTheme: textSelectionTheme,
    );
  }

  // ColorScheme
  ColorScheme get colorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimary,
    onPrimary: kTextPrimary,
    secondary: kAccentCyan,
    onSecondary: kPrimary,
    surface: kCardBase,
    onSurface: kTextPrimary,
    error: Colors.red,
    onError: Colors.red.shade100,
  );

  // TextSelectionTheme
  TextSelectionThemeData get textSelectionTheme => TextSelectionThemeData(
    cursorColor: kAccentCyan,
    selectionColor: kAccentCyan.withValues(alpha: 0.3),
    selectionHandleColor: kAccentCyan,
  );

  // TextTheme (composed from individual styles)
  TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    headlineLarge: headlineLarge,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    labelLarge: labelLarge,
  );

  // Individual Text Styles
  TextStyle get displayLarge =>
      TextStyle(fontSize: s96, fontWeight: semiBold, color: kTextPrimary);

  TextStyle get displayMedium =>
      TextStyle(fontSize: s70, fontWeight: semiBold, color: kTextPrimary);

  TextStyle get headlineLarge =>
      TextStyle(fontSize: s64, fontWeight: bold, color: kTextPrimary);

  TextStyle get titleLarge =>
      TextStyle(fontSize: s48, fontWeight: bold, color: kTextPrimary);

  TextStyle get titleMedium =>
      TextStyle(fontSize: s36, fontWeight: bold, color: kAccentCyan);

  TextStyle get bodyLarge =>
      TextStyle(fontSize: s16, fontWeight: medium, color: kTextSecondary);

  TextStyle get bodyMedium =>
      TextStyle(fontSize: s14, fontWeight: medium, color: kTextSecondary);

  TextStyle get labelLarge =>
      TextStyle(fontSize: s20, fontWeight: semiBold, color: kTextPrimary);
}
