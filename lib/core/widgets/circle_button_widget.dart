import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class CircleButtonWidget extends StatelessWidget {
  final double widthHeight;
  final Color backgroundColor;
  final Widget child;
  final VoidCallback? onTap;
  final Color borderColor;
  const CircleButtonWidget({
    super.key,
    this.widthHeight = 55,
    this.backgroundColor = Colors.white,
    this.borderColor = AppColors.border,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthHeight,
      height: widthHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppDimension.largeBorderRadius * 2,
        ),
        onTap: onTap,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
