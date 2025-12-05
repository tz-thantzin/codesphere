part of '../typography.dart';

class DisplayLarge extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;

  const DisplayLarge(
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
        fontSize: context.adaptive(ts120, ts140),
        fontWeight: superBold,
        height: 1.0,
        letterSpacing: -1.5,
        color: color ?? kWhite,
        shadows: shadows,
      ),
    );
  }
}
