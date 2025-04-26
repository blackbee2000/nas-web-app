import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/core/widgets/validator/validator.dart';
import 'package:nasmobile/feature/app/controllers/forgot_password_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ForgotPasswordView extends BaseView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: AppBarWidget(
        titleName: S.current.forgetPassword,
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
                  text: S.current.enterEmailRegister,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimension.largeFontSize,
                  color: AppColors.thirdBlackText,
                  maxlines: 2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Email
                Obx(
                  () => TextFormFieldWidget(
                    labelText:
                        controller.isLabelEmail.value ? S.current.email : null,
                    controller: controller.email,
                    hintText: S.current.enter_input(
                      S.current.email.toLowerCase(),
                    ),
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.isLabelEmail.value = true;
                      } else {
                        controller.isLabelEmail.value = false;
                      }
                    },
                    validator: MultiValidator(
                      validators: [
                        EmailValidator(error: S.current.emailNotValid),
                      ],
                    ).call,
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace * 2),

                /// Btn register
                Obx(
                  () => RoundedButtonWidget(
                    onPressed: controller.isActiveButton.value
                        ? controller.onNext
                        : null,
                    text: S.current.next,
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
