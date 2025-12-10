part of '../typography.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool shimmer;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final double height;
  final double? letterSpacing;
  final Gradient? gradient;
  final String? fontFamily;

  const GradientText(
    this.text, {
    super.key,
    required this.fontSize,
    this.textAlign,
    this.shimmer = false,
    this.fontWeight = FontWeight.w900,
    this.height = 1.2,
    this.letterSpacing,
    this.gradient,
    this.fontFamily,
  });

  static final _defaultGradient = const LinearGradient(
    colors: [kAccentCyan, kPurpleGlow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(const Rect.fromLTWH(0, 0, 600, 200));

  @override
  Widget build(BuildContext context) {
    final paint = Paint()
      ..shader =
          gradient?.createShader(const Rect.fromLTWH(0, 0, 700, 200)) ??
          _defaultGradient;

    final textWidget = BaseText(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        height: height,
        letterSpacing:
            letterSpacing ??
            (text.contains('+') || text.contains('%') || text.contains('K')
                ? 1.0
                : -1.5),
        foreground: paint,
      ),
      textAlign: textAlign,
    );

    if (!shimmer) return textWidget;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient?.createShader(bounds) ?? _defaultGradient,
      child: textWidget.animate().shimmer(
        duration: 3000.ms,
        color: kAccentCyan.withValues(alpha: 0.25),
        size: 1.5,
      ),
    );
  }
}
