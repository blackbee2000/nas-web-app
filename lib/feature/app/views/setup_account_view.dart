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
import 'package:nasmobile/feature/app/controllers/setup_account_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class SetupAccountView extends BaseView<SetupAccountController> {
  const SetupAccountView({super.key});

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
        titleName: S.current.setupAccount,
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${S.current.completeUnderInformation} ',
                    style: const TextStyle(
                      color: AppColors.thirdBlackText,
                      fontSize: AppDimension.largeFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      WidgetSpan(
                        child: ShaderMask(
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
                            text: S.current.nas,
                            fontSize: AppDimension.largeFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Email
                Obx(
                  () => TextFormFieldWidget(
                    labelText: controller.isLabelFullname.value
                        ? S.current.fullName
                        : null,
                    controller: controller.fullname,
                    hintText: S.current.enter_input(
                      S.current.fullName.toLowerCase(),
                    ),
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.isLabelFullname.value = true;
                      } else {
                        controller.isLabelFullname.value = false;
                      }
                    },
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
                        ? controller.onRegister
                        : null,
                    text: S.current.login,
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
