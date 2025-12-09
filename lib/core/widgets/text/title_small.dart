part of '../typography.dart';

class TitleSmall extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const TitleSmall(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
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
        fontSize: context.adaptive(ts16, s24),
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: color ?? kTextPrimary,
      ),
    );
  }
}
