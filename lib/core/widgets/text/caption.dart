part of '../typography.dart';

class Caption extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;

  const Caption(this.text, {super.key, this.textAlign, this.color});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        fontSize: context.adaptive(ts14, ts16),
        height: 1.7,
        color: color ?? kTextSecondary,
      ),
    );
  }
}
