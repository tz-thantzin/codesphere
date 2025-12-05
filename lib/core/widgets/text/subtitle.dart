part of '../typography.dart';

class SubtitleLarge extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const SubtitleLarge(
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
        fontSize: context.adaptive(ts18, ts24), // Mobile: 18 → Desktop: 24
        fontWeight: medium,
        height: 1.6,
        color: color ?? kTextSecondary,
        letterSpacing: 0.2,
      ),
    );
  }
}
