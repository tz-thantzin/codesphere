part of '../typography.dart';

class BaseText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const BaseText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style;

    if (overflow != null || maxLines != null) {
      return Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: resolvedStyle,
      );
    }

    return SelectableText(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: resolvedStyle,
    );
  }
}
