part of '../typography.dart';

class BodyLarge extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;

  const BodyLarge(
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
        fontSize: context.adaptive(ts15, ts19),
        fontWeight: medium,
        height: 1.75,
        color: color ?? kWhite70,
        shadows: shadows,
      ),
    );
  }
}
