import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/core/widgets/validator/validator.dart';
import 'package:nasmobile/feature/app/controllers/change_password_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ChangePasswordView extends BaseView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  Widget _buildPreIcon({required String icon, VoidCallback? onTap}) =>
      IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
      );

  Widget _ruleItem({
    bool isCheck = false,
    required String text,
  }) =>
      Row(
        children: [
          Icon(
            isCheck ? Icons.check : Icons.close_outlined,
            color: isCheck ? Colors.green : AppColors.errorColor,
            size: 18,
          ),
          const SizedBox(width: AppDimension.smallSpace),
          TextWidget(
            text: text,
            color: AppColors.thirdBlackText,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: AppBarWidget(
        titleName: S.current.resetPassword,
        backgroundColor: AppColors.greyBackground,
        elevation: 1,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.mediumSpace,
          vertical: AppDimension.largeSpace * 1.5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            onChanged: controller.onChangeActiveButton,
            child: Column(
              children: [
                TextWidget(
                  text: S.current.pleaseEnterFisrtIsOldPass,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimension.largeFontSize,
                  color: AppColors.thirdBlackText,
                  maxlines: 3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Old password
                Obx(
                  () => TextFormFieldWidget(
                    labelText: controller.isLabelOldPassword.value
                        ? S.current.oldPassword
                        : null,
                    controller: controller.oldPassword,
                    hintText: S.current.enter_input(
                      S.current.oldPassword.toLowerCase(),
                    ),
                    obscureText: !controller.showOldPassword.value,
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.isLabelOldPassword.value = true;
                      } else {
                        controller.isLabelOldPassword.value = false;
                      }
                    },
                    suffixIcon: _buildPreIcon(
                      onTap: () {
                        controller.showOldPassword.value =
                            !controller.showOldPassword.value;
                      },
                      icon: controller.showOldPassword.value
                          ? AppPaths.icOpenEye
                          : AppPaths.icCloseEye,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Password
                Obx(
                  () => TextFormFieldWidget(
                    labelText: controller.isLabelPassword.value
                        ? S.current.password
                        : null,
                    controller: controller.password,
                    hintText: S.current.enter_input(
                      S.current.password.toLowerCase(),
                    ),
                    obscureText: !controller.showPassword.value,
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.isLabelPassword.value = true;
                      } else {
                        controller.isLabelPassword.value = false;
                      }

                      if (value != null) {
                        controller.checkRule(value: value);
                      }
                    },
                    suffixIcon: _buildPreIcon(
                      onTap: () {
                        controller.showPassword.value =
                            !controller.showPassword.value;
                      },
                      icon: controller.showPassword.value
                          ? AppPaths.icOpenEye
                          : AppPaths.icCloseEye,
                    ),
                  ),
                ),
                Obx(
                  () => controller.isShowRule.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppDimension.smallSpace),
                            _ruleItem(
                              text: S.current.greaterThanOrEqual,
                              isCheck: controller.isGreaterThanOrEqual8.value,
                            ),
                            const SizedBox(height: AppDimension.smallSpace / 2),
                            _ruleItem(
                              text: S.current.haveUpperAndLower,
                              isCheck: controller.isUpperAndLower.value,
                            ),
                            const SizedBox(height: AppDimension.smallSpace / 2),
                            _ruleItem(
                              text: S.current.haveSpecialCharacters,
                              isCheck: controller.isHaveSpecialCharacters.value,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Confirm pass
                Obx(
                  () => TextFormFieldWidget(
                    labelText: controller.isLabelConfirmPassword.value
                        ? S.current.confirmPassword
                        : null,
                    controller: controller.confirmPassword,
                    hintText: S.current.enter_input(
                      S.current.confirmPassword.toLowerCase(),
                    ),
                    obscureText: !controller.showConfirmPassword.value,
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.isLabelConfirmPassword.value = true;
                      } else {
                        controller.isLabelConfirmPassword.value = false;
                      }
                    },
                    suffixIcon: _buildPreIcon(
                      onTap: () {
                        controller.showConfirmPassword.value =
                            !controller.showConfirmPassword.value;
                      },
                      icon: controller.showConfirmPassword.value
                          ? AppPaths.icOpenEye
                          : AppPaths.icCloseEye,
                    ),
                    validator: MultiValidator(
                      validators: [
                        MatchValidator(
                          error: S.current.matchPasswordNotValid,
                          valueFirst: () => controller.password.text,
                          valueSecond: () => controller.confirmPassword.text,
                        ),
                      ],
                    ).call,
                  ),
                ),

                const SizedBox(height: AppDimension.largeSpace * 2),

                /// Btn register
                Obx(
                  () => RoundedButtonWidget(
                    onPressed: controller.isActiveButton.value
                        ? controller.onChangePassword
                        : null,
                    text: S.current.resetPassword,
                    isGradient: controller.isActiveButton.value,
                    backgroundColor: AppColors.disableButtonColor,
                    borderColor: AppColors.disableButtonColor,
                    textColor: controller.isActiveButton.value
                        ? Colors.white
                        : AppColors.grey8C8984,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
