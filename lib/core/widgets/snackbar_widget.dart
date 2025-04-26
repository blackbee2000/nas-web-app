import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';

class SnackbarWidget {
  static SnackBar _base({
    required Size screenSize,
    required Icon leadingIcon,
    required Color backgroundColor,
    required String title,
    required String message,
    Function()? onClose,
    required Color textTitleColor,
    required Color borderColor,
  }) =>
      SnackBar(
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: screenSize.height * .68),
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        content: GestureDetector(
          onVerticalDragUpdate: (detail) {
            if (detail.delta.dy < 0) {
              onClose?.call();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimension.mediumSpace),
            constraints: const BoxConstraints(minHeight: 80),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(
                AppDimension.mediumBorderRadius,
              ),
            ),
            child: Row(
              children: [
                leadingIcon,
                const SizedBox(
                  width: AppDimension.smallSpace,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: title,
                        color: textTitleColor,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(
                        height: AppDimension.smallSpace / 3,
                      ),
                      TextWidget(text: message, maxlines: 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  static SnackBar success({
    required Size screenSize,
    required String title,
    required String message,
    Function()? onClose,
  }) =>
      _base(
        screenSize: screenSize,
        leadingIcon: const Icon(
          Icons.check_circle_outline,
          color: AppColors.successColor,
        ),
        backgroundColor: AppColors.greenLightColor,
        borderColor: AppColors.successColor,
        title: title,
        message: message,
        onClose: onClose,
        textTitleColor: AppColors.successColor,
      );

  static SnackBar failed({
    required Size screenSize,
    required String title,
    required String message,
    Function()? onClose,
  }) =>
      _base(
          screenSize: screenSize,
          leadingIcon: const Icon(
            Icons.error_outline,
            color: AppColors.errorColor,
          ),
          backgroundColor: AppColors.backgroundRedColor,
          title: title,
          message: message,
          onClose: onClose,
          textTitleColor: AppColors.errorColor,
          borderColor: AppColors.errorColor);
}
