import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText({
    this.text = '',
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.style,
    super.key
  });

  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      textWidthBasis: TextWidthBasis.longestLine,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      text: TextSpan(
        text: text,
        style: style,
      ),
    );
  }
}