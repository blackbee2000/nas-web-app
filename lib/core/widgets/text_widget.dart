import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int maxlines;
  final TextAlign textAlign;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;
  final double? letterSpacing;
  final String? fontFamily;

  const TextWidget({
    super.key,
    required this.text,
    this.fontSize = AppDimension.mediumFontSize,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.blackText,
    this.maxlines = 1,
    this.textAlign = TextAlign.left,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.letterSpacing,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      ),
      maxLines: maxlines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
