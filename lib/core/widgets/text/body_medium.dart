part of '../typography.dart';

class BodyMedium extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyMedium(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.shadows,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.inter(
        fontSize: context.adaptive(ts14, ts17),
        height: 1.6,
        color: color ?? kTextSecondary,
        shadows: shadows,
      ),
    );
  }
}
