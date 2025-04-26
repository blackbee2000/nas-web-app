import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    this.width,
    this.height = 48,
    this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.textSize = AppDimension.largeFontSize,
    this.fontWeight = FontWeight.w600,
    this.fontStyle = FontStyle.normal,
    this.backgroundColor = AppColors.pink600,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        AppDimension.largeBorderRadius * 10,
      ),
    ),
    this.borderColor = AppColors.pink600,
    this.borderSize = 1.0,
    this.padding = const EdgeInsets.all(10),
    this.disable = false,
    this.align = TextAlign.center,
    this.icon,
    this.isGradient = true,
    this.boxShadows = const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 1,
      ),
    ],
    this.gradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.pinkFFBEFF,
          AppColors.pinkF01799,
        ]),
    this.textDirection = TextDirection.ltr,
    this.iconSuffix,
  });

  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double textSize;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderSize;
  final EdgeInsetsGeometry padding;
  final bool disable;
  final TextAlign align;
  final Widget? icon;
  final Widget? iconSuffix;
  final bool isGradient;
  final List<BoxShadow>? boxShadows;
  final Gradient? gradient;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: disable ? null : onPressed,
          borderRadius: borderRadius,
          child: Ink(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: isGradient
                  ? null
                  : disable
                      ? backgroundColor.withOpacity(0.5)
                      : backgroundColor,
              border: isGradient
                  ? null
                  : Border.all(
                      color:
                          disable ? borderColor.withOpacity(0.5) : borderColor,
                      width: borderSize,
                    ),
              borderRadius: borderRadius,
              boxShadow: boxShadows,
              gradient: isGradient ? gradient : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: textDirection,
              children: [
                if (icon != null)
                  Container(
                    margin: const EdgeInsets.only(
                      right: AppDimension.smallSpace,
                    ),
                    child: icon,
                  ),
                Text(
                  text.toUpperCase(),
                  maxLines: 2,
                  textAlign: align,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                  ),
                ),
                if (iconSuffix != null)
                  Container(
                    margin: const EdgeInsets.only(
                      left: AppDimension.smallSpace,
                    ),
                    child: iconSuffix,
                  ),
              ],
            ),
          ),
        ),
      );
}

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double borderWidth;
  final double borderRadius;

  GradientBorderPainter({
    required this.gradient,
    this.borderWidth = 1.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(
      rect.deflate(borderWidth / 2),
      Radius.circular(borderRadius),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SecondaryRoundedButonWidget extends StatelessWidget {
  const SecondaryRoundedButonWidget({
    super.key,
    this.width,
    this.height = 48,
    this.onPressed,
    required this.text,
    this.textColor = AppColors.pink900,
    this.textSize = AppDimension.largeFontSize,
    this.fontWeight = FontWeight.w600,
    this.fontStyle = FontStyle.normal,
    this.backgroundColor = AppColors.pink50,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        AppDimension.largeBorderRadius * 10,
      ),
    ),
    this.borderColor = AppColors.pink50,
    this.borderSize = 1.0,
    this.padding = const EdgeInsets.all(10),
    this.disable = false,
    this.align = TextAlign.center,
    this.icon,
    this.boxShadows = const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 1,
      ),
    ],
    this.gradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.pinkFFBEFF,
          AppColors.pinkF01799,
        ]),
    this.iconSuffix,
  });

  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double textSize;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderSize;
  final EdgeInsetsGeometry padding;
  final bool disable;
  final TextAlign align;
  final Widget? icon;
  final Widget? iconSuffix;
  final List<BoxShadow>? boxShadows;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(1),
      child: RoundedButtonWidget(
        width: width,
        height: height,
        onPressed: onPressed,
        text: text,
        textColor: textColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        textSize: textSize,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        borderColor: backgroundColor,
        borderSize: borderSize,
        padding: padding,
        disable: disable,
        align: align,
        icon: icon,
        iconSuffix: iconSuffix,
        boxShadows: boxShadows,
        isGradient: false,
        gradient: null,
      ),
    );
  }
}
