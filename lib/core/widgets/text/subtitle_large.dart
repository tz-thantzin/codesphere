part of '../typography.dart';

class SubtitleLarge extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;

  const SubtitleLarge(
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
        fontSize: context.adaptive(ts24, ts32),
        fontWeight: bold,
        height: 1.3,
        letterSpacing: -0.2,
        color: color ?? kWhite,
        shadows: shadows,
      ),
    );
  }
}
