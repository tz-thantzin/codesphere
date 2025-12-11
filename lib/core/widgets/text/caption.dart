part of '../typography.dart';

class Caption extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;

  const Caption(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        fontSize: context.adaptive(ts12, ts14),
        fontWeight: fontWeight ?? light,
        height: 1.7,
        color: color ?? kTextSecondary,
      ),
    );
  }
}
