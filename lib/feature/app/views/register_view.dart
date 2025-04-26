import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/core/widgets/validator/validator.dart';
import 'package:nasmobile/feature/app/controllers/register_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class RegisterView extends BaseView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppPaths.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: viewPadding.top),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: AppDimension.smallSpace / 2),
              child: IconButton(
                onPressed: Get.back,
                icon: SvgPicture.asset(
                  AppPaths.icArrowLeft,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Image.asset(
              AppPaths.mainLogo,
              width: 96,
              height: 96,
            ),
            TextWidget(
              text: S.current.nailsAndSpa,
              color: Colors.white,
              fontSize: AppDimension.largeFontSize * 2,
              fontFamily: GoogleFonts.berkshireSwash().fontFamily,
            ),
            const SizedBox(height: AppDimension.largeSpace * 2),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.mediumSpace,
                  vertical: AppDimension.largeSpace * 1.5,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      AppDimension.largeBorderRadius * 4,
                    ),
                    topRight: Radius.circular(
                      AppDimension.largeBorderRadius * 4,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    onChanged: controller.onChangeActiveButton,
                    child: Column(
                      children: [
                        TextWidget(
                          text: '${S.current.wellcome.split("").sublist(
                                0,
                                S.current.wellcome.length - 1,
                              ).join("")}!',
                          fontSize: AppDimension.extraLargeFontSize * 2,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 1.5),

                        /// Email
                        Obx(
                          () => TextFormFieldWidget(
                            labelText: controller.isLabelEmail.value
                                ? S.current.email
                                : null,
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
                        const SizedBox(height: AppDimension.mediumSpace),

                        /// Remember pass, forgot pass
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: controller.toggleCheck,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: controller.isToggleCheck.value
                                        ? null
                                        : Border.all(color: AppColors.border),
                                    gradient: controller.isToggleCheck.value
                                        ? const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.pinkFFBEFF,
                                              AppColors.pinkF01799,
                                            ],
                                          )
                                        : null,
                                  ),
                                  child: controller.isToggleCheck.value
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: AppDimension.smallSpace),
                              Expanded(
                                child: GestureDetector(
                                  onTap: controller.toggleCheck,
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${S.current.conditionRegister1} ',
                                      style: const TextStyle(
                                        color: AppColors.thirdBlackText,
                                        fontSize: AppDimension.smallFontSize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: S.current.conditionRegister2,
                                          style: const TextStyle(
                                            color: AppColors.pink400,
                                            fontSize:
                                                AppDimension.smallFontSize,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 1.5),

                        /// Btn login
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
                        const SizedBox(height: AppDimension.largeSpace * 1.5),

                        /// Login with gg, fb, apple
                        TextWidget(
                          text: S.current.or,
                          color: AppColors.secondGreyText,
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 1.5),
                        Row(
                          children: [
                            /// Google
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius + 4,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.secondBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppDimension.largeBorderRadius + 4,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppPaths.icGoogle,
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(
                                        width: AppDimension.mediumSpace,
                                      ),
                                      TextWidget(
                                        text: S.current.withGG,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondGreyText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimension.largeSpace + 5),

                            /// Facebook
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(
                                AppDimension.largeBorderRadius + 4,
                              ),
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.secondBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.largeBorderRadius + 4,
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppPaths.icFacebook,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimension.largeSpace + 5),

                            /// Apple
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(
                                AppDimension.largeBorderRadius + 4,
                              ),
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.secondBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.largeBorderRadius + 4,
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppPaths.icApple,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Go to register
                        const SizedBox(height: AppDimension.largeSpace + 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: '${S.current.youHaveAccount} ',
                              color: AppColors.fourBlackText,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                AppRoutes.loginScreen,
                              ),
                              child: TextWidget(
                                text: S.current.login,
                                color: AppColors.pink400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
