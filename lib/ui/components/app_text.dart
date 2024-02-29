import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Gradient? gradient;
  final Color color;
  final AppStyle style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign align;
  final double? letterSpacing;

  const AppText({
    required this.text,
    required this.style,
    required this.color,
    this.gradient,
    this.maxLines = 1,
    this.overflow,
    this.align = TextAlign.start,
    this.letterSpacing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (gradient != null) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: DefaultTextStyle(
          textAlign: align,
          style: TextStyle(
            letterSpacing: letterSpacing,
            fontSize: style.fontSize,
            fontWeight: style.fontWeight,
            fontFamily: style.fontFamily,
            fontStyle: style.fontStyle,
            overflow: overflow,
          ),
          child: Text(
            text,
            maxLines: maxLines,
          ),
        ),
      );
    } else {
      return DefaultTextStyle(
        textAlign: align,
        style: TextStyle(
          letterSpacing: letterSpacing,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          fontFamily: style.fontFamily,
          overflow: overflow,
          color: color,
          fontStyle: style.fontStyle,
        ),
        child: Text(
          text,
          maxLines: maxLines,
        ),
      );
    }
  }
}
