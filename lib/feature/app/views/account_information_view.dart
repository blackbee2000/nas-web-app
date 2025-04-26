import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/enums/sex_type.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/core/widgets/validator/validator.dart';
import 'package:nasmobile/feature/app/controllers/account_information_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class AccountInformationView extends BaseView<AccountInformationController> {
  const AccountInformationView({super.key});

  Widget _buildTitle({required String title, bool isRequired = true}) => Row(
        children: [
          TextWidget(
            text: title,
            fontSize: AppDimension.largeFontSize,
            fontWeight: FontWeight.w500,
            color: AppColors.secondGreyText,
          ),
          isRequired
              ? const TextWidget(
                  text: '*',
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.errorColor,
                )
              : const SizedBox(),
        ],
      );

  Widget _buildSuffixIcon({required String icon, VoidCallback? onTap}) =>
      IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.grey8C8984,
            BlendMode.srcIn,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBarWidget(
        titleName: S.current.accountInformation,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(context).viewPadding.bottom,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimension.largeBorderRadius + 4),
            topRight: Radius.circular(AppDimension.largeBorderRadius + 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: SecondaryRoundedButonWidget(
                width: double.infinity,
                onPressed: Get.back,
                text: S.current.cancel,
              ),
            ),
            const SizedBox(width: AppDimension.smallSpace),
            Expanded(
              child: RoundedButtonWidget(
                width: double.infinity,
                onPressed: () async => await controller.onSave(),
                text: S.current.done,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formSaveKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                GestureDetector(
                  onTap: () async => await controller.openOptionAvatar(),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Obx(
                          () => SizedBox(
                            width: 110,
                            height: 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: controller.avatar.value.isNotEmpty
                                  ? File(controller.avatar.value).existsSync()
                                      ? Image.file(
                                          File(controller.avatar.value),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (ct, o, s) => Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.pink600
                                                  .withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.error_outline,
                                                size: 30,
                                                color: AppColors.errorColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : controller.avatar.value
                                                  .contains("http") ||
                                              controller.avatar.value
                                                  .contains("https")
                                          ? Image.network(
                                              controller.avatar.value,
                                              width: 150,
                                              height: 70,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (ct, w, e) {
                                                if (e == null) return w;

                                                return Container(
                                                  width: 150,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.pink600
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      AppDimension
                                                          .mediumBorderRadius,
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            AppColors.pink600,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorBuilder: (ct, o, s) =>
                                                  Container(
                                                width: 150,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: AppColors.errorColor
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    AppDimension
                                                        .mediumBorderRadius,
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.error_outline,
                                                    size: 30,
                                                    color: AppColors.errorColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Image.asset(
                                              controller.sex.value ==
                                                      SexType.male
                                                  ? AppPaths.male
                                                  : controller.sex.value ==
                                                          SexType.female
                                                      ? AppPaths.female
                                                      : AppPaths.avt,
                                              fit: BoxFit.cover,
                                            )
                                  : Image.asset(
                                      controller.sex.value == SexType.male
                                          ? AppPaths.male
                                          : controller.sex.value ==
                                                  SexType.female
                                              ? AppPaths.female
                                              : AppPaths.avt,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimension.largeBorderRadius * 10,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius * 10,
                                ),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimension.smallSpace - 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    AppPaths.icCamera,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace),

                /// Username
                _buildTitle(title: S.current.fullName),
                const SizedBox(height: AppDimension.smallSpace),
                TextFormFieldWidget(
                  controller: controller.fullName,
                  hintText: S.current.enter_input(
                    S.current.fullName.toLowerCase(),
                  ),
                  validator: RequiredValidator(
                    error: S.current.required_field(S.current.fullName),
                    ignoreEmptyValues: false,
                  ).call,
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Birthday
                _buildTitle(title: S.current.birthday, isRequired: false),
                const SizedBox(height: AppDimension.smallSpace),
                TextFormFieldWidget(
                  readOnly: true,
                  controller: controller.birthdayController,
                  hintText: S.current.enter_input(
                    S.current.birthday.toLowerCase(),
                  ),
                  suffixIcon: _buildSuffixIcon(icon: AppPaths.icCalendar),
                  onTap: () async => await controller.onOpenDateSelectWidget(),
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Sex
                _buildTitle(title: S.current.sex, isRequired: false),
                const SizedBox(height: AppDimension.smallSpace),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.sex.value = SexType.male;
                          },
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            padding: const EdgeInsets.all(
                              AppDimension.smallSpace,
                            ),
                            decoration: BoxDecoration(
                              color: controller.sex.value == SexType.male
                                  ? Colors.white
                                  : AppColors.secondGreyBackground,
                              borderRadius: BorderRadius.circular(
                                AppDimension.largeBorderRadius,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(0, 0),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(AppPaths.male),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppDimension.smallSpace,
                                    ),
                                    TextWidget(
                                      text: SexType.male.name,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.thirdteenBlackText,
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  controller.sex.value == SexType.male
                                      ? AppPaths.icCheckCircleActive
                                      : AppPaths.icCheckCircle,
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimension.smallSpace),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.sex.value = SexType.female;
                          },
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            padding: const EdgeInsets.all(
                              AppDimension.smallSpace,
                            ),
                            decoration: BoxDecoration(
                              color: controller.sex.value == SexType.female
                                  ? Colors.white
                                  : AppColors.secondGreyBackground,
                              borderRadius: BorderRadius.circular(
                                AppDimension.largeBorderRadius,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(0, 0),
                                  blurRadius: 24,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(AppPaths.female),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppDimension.smallSpace,
                                    ),
                                    TextWidget(
                                      text: SexType.female.name,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.thirdteenBlackText,
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  controller.sex.value == SexType.female
                                      ? AppPaths.icCheckCircleActive
                                      : AppPaths.icCheckCircle,
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Phone number
                _buildTitle(title: S.current.phoneNumber),
                const SizedBox(height: AppDimension.smallSpace),
                TextFormFieldWidget(
                  controller: controller.phoneNumber,
                  hintText: S.current.enter_input(
                    S.current.phoneNumber.toLowerCase(),
                  ),
                  validator: RequiredValidator(
                    error: S.current.required_field(S.current.phoneNumber),
                    ignoreEmptyValues: false,
                  ).call,
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Email
                _buildTitle(title: S.current.email),
                const SizedBox(height: AppDimension.smallSpace),
                TextFormFieldWidget(
                  controller: controller.email,
                  hintText: S.current.enter_input(
                    S.current.email.toLowerCase(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Address
                _buildTitle(title: S.current.address, isRequired: false),
                const SizedBox(height: AppDimension.smallSpace),
                TextFormFieldWidget(
                  controller: controller.address,
                  hintText: S.current.enter_input(
                    S.current.address.toLowerCase(),
                  ),
                  suffixIcon: _buildSuffixIcon(icon: AppPaths.icAddress),
                ),
                const SizedBox(height: AppDimension.mediumSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
