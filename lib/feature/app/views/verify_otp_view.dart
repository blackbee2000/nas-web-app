import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/verify_otp_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpView extends BaseView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: AppBarWidget(
        titleName: S.current.verifyOtp,
        backgroundColor: AppColors.greyBackground,
        elevation: 1,
      ),
      body: KeyboardActions(
        config: KeyboardActionsConfig(
          actions: [
            KeyboardActionsItem(
              focusNode: controller.focusNode,
              displayArrows: false,
            ),
          ],
          defaultDoneWidget: TextWidget(
            text: S.current.close,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimension.mediumSpace,
            vertical: AppDimension.largeSpace * 1.5,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextWidget(
                  text: S.current.otpCodeSentTo,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimension.largeFontSize,
                  color: AppColors.thirdBlackText,
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.pinkFFBEFF,
                        AppColors.pinkF01799,
                      ],
                    ).createShader(bounds);
                  },
                  child: const TextWidget(
                    text: 'phiulinh20092000@gmail.com',
                    fontSize: AppDimension.largeFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                /// Otp text field
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                PinCodeTextField(
                  focusNode: controller.focusNode,
                  length: 6,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(
                      AppDimension.largeBorderRadius,
                    ),
                    fieldHeight: 48,
                    fieldWidth: 48,
                    errorBorderColor: AppColors.grey8C8984,
                    activeColor: AppColors.fifBlackText,
                    activeFillColor: AppColors.fifBlackText,
                    inactiveColor: AppColors.grey8C8984,
                    disabledColor: AppColors.grey8C8984,
                    inactiveFillColor: AppColors.grey8C8984,
                    selectedColor: AppColors.fifBlackText,
                    selectedFillColor: AppColors.fifBlackText,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  controller: controller.otpCode,
                  onChanged: controller.onChangeCode,
                  appContext: Get.context!,
                  textStyle: const TextStyle(
                    color: AppColors.fifBlackText,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimension.extraLargeFontSize + 6,
                  ),
                  hintCharacter: "0",
                  hintStyle: const TextStyle(
                    color: AppColors.grey8C8984,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimension.extraLargeFontSize + 6,
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),

                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: S.current.pleaseEnterOTPCode,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimension.largeFontSize,
                      color: AppColors.thirdBlackText,
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.pinkFFBEFF,
                            AppColors.pinkF01799,
                          ],
                        ).createShader(bounds);
                      },
                      child: const TextWidget(
                        text: ' 120 ',
                        fontSize: AppDimension.largeFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextWidget(
                      text: S.current.second,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimension.largeFontSize,
                      color: AppColors.thirdBlackText,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.largeSpace * 5),

                /// Btn verify
                Obx(
                  () => RoundedButtonWidget(
                    onPressed: controller.isActiveButton.value
                        ? controller.onVerify
                        : null,
                    text: S.current.verify,
                    isGradient: controller.isActiveButton.value,
                    backgroundColor: AppColors.disableButtonColor,
                    borderColor: AppColors.disableButtonColor,
                    textColor: controller.isActiveButton.value
                        ? Colors.white
                        : AppColors.grey8C8984,
                  ),
                ),
                const SizedBox(height: AppDimension.mediumSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: '${S.current.cannotGetOtp} ',
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimension.largeFontSize,
                      color: AppColors.thirdBlackText,
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.pinkFFBEFF,
                            AppColors.pinkF01799,
                          ],
                        ).createShader(bounds);
                      },
                      child: TextWidget(
                        text: S.current.resentOtp,
                        fontSize: AppDimension.largeFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
