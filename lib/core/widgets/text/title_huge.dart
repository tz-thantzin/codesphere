part of '../typography.dart';

class TitleHuge extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;

  const TitleHuge(
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
        fontSize: context.adaptive(ts56, ts96),
        fontWeight: superBold,
        height: 1.05,
        letterSpacing: -0.5,
        color: color ?? kWhite,
        shadows: shadows,
      ),
    );
  }
}
