import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? icon;
  final String textButton;
  final VoidCallback onTap;
  final bool isCancelButton;
  final String? textButtonCancel;
  final VoidCallback? onTapCancel;
  final Color? backgroundColorButton;
  final Color? backgroundColorButtonCancel;
  final bool isGradientButton;
  const BaseDialog({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    required this.textButton,
    required this.onTap,
    this.isCancelButton = false,
    this.textButtonCancel,
    this.onTapCancel,
    this.backgroundColorButton,
    this.backgroundColorButtonCancel,
    this.isGradientButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - (AppDimension.largeSpace * 4),
      padding: const EdgeInsets.all(AppDimension.largeSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppDimension.largeBorderRadius * 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: title,
            fontSize: AppDimension.extraLargeFontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.fifBlackText,
          ),
          icon != null
              ? Container(
                  margin: const EdgeInsets.only(top: AppDimension.mediumSpace),
                  child: SvgPicture.asset(
                    icon!,
                    width: 50,
                    height: 50,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: AppDimension.mediumSpace),
          TextWidget(
            text: content,
            maxlines: 10,
            textAlign: TextAlign.center,
            color: AppColors.thirdBlackText,
            fontSize: AppDimension.largeFontSize,
          ),
          const SizedBox(height: AppDimension.mediumSpace),
          Row(
            children: [
              if (isCancelButton)
                Expanded(
                  child: SecondaryRoundedButonWidget(
                    width: double.infinity,
                    text: textButtonCancel ?? "",
                    onPressed: onTapCancel,
                    backgroundColor:
                        backgroundColorButtonCancel ?? AppColors.pink50,
                  ),
                ),
              if (isCancelButton)
                const SizedBox(width: AppDimension.smallSpace),
              Expanded(
                child: RoundedButtonWidget(
                  width: double.infinity,
                  onPressed: onTap,
                  text: textButton,
                  backgroundColor: backgroundColorButton ?? AppColors.pink600,
                  isGradient: isGradientButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ErrorDialog extends BaseDialog {
  const ErrorDialog({
    super.key,
    required super.title,
    required super.textButton,
    required super.content,
    super.icon,
    required super.onTap,
    super.isCancelButton,
    super.textButtonCancel,
    super.onTapCancel,
    super.backgroundColorButton,
    super.backgroundColorButtonCancel,
    super.isGradientButton,
  });
}
