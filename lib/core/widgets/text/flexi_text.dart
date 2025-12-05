part of '../typography.dart';

class FlexiText extends StatelessWidget {
  final String text;
  final double factor; // e.g. 0.09 → 9% of available height
  final double minSize;
  final double maxSize;
  final FontWeight fontWeight;
  final Color? color;
  final double height;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const FlexiText({
    super.key,
    required this.text,
    required this.factor,
    this.minSize = 12.0,
    this.maxSize = 64.0,
    this.fontWeight = FontWeight.w800,
    this.color,
    this.height = 1.2,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final calculatedSize = (availableHeight * factor).clamp(
          minSize,
          maxSize,
        );

        return BaseText(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.inter(
            fontSize: calculatedSize,
            fontWeight: fontWeight,
            height: height,
            color: color,
          ),
        );
      },
    );
  }
}
