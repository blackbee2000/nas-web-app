import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/other_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class OtherView extends BaseView<OtherController> {
  const OtherView({super.key});

  Widget _itemCategory({
    required CategoryItem item,
    bool isBorderTop = false,
  }) =>
      InkWell(
        onTap: () async {
          if (item.title == S.current.deleteAccount) {
            controller.showErrorDialog(
              content: S.current.confirmDeleteAccount,
              textButton: S.current.confirm,
              onTap: () async => await controller.onDeleteAccount(),
              isCancelButton: true,
              textButtonCancel: S.current.close,
              onTapCancel: Get.back,
            );
            return;
          }

          if (item.route == AppRoutes.accountInformationScreen) {
            await controller.viewAccountInformation();
            return;
          }

          Get.toNamed(item.route);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimension.mediumSpace,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    item.icon,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackText,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppDimension.smallSpace),
                  TextWidget(
                    text: item.title,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimension.largeFontSize,
                  ),
                ],
              ),
              const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: AppColors.blackText,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace +
                (Platform.isAndroid ? AppDimension.mediumSpace : 0),
            viewPadding.top +
                (Platform.isAndroid ? AppDimension.mediumSpace : 0),
          ),
          AppDimension.mediumSpace,
          AppDimension.mediumSpace * 2.5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// Circle avatar
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: controller.user.value != null &&
                                controller.user.value!.avatar != null &&
                                (controller.user.value!.avatar!
                                        .contains("http") ||
                                    controller.user.value!.avatar!
                                        .contains("https"))
                            ? Image.network(
                                controller.user.value!.avatar!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder: (ct, w, e) {
                                  if (e == null) return w;

                                  return Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.pink600.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                        AppDimension.mediumBorderRadius,
                                      ),
                                    ),
                                    child: const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: AppColors.pink600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (ct, o, s) => Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.errorColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(
                                      AppDimension.mediumBorderRadius,
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
                            : Image.asset(AppPaths.avt),
                      ),
                    ),
                    const SizedBox(width: AppDimension.mediumSpace),

                    /// Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: S.current.wellcome,
                          color: AppColors.greyText,
                          fontSize: AppDimension.smallFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: AppDimension.smallSpace / 2),
                        Obx(
                          () => TextWidget(
                            text: controller.user.value != null &&
                                    controller.user.value!.fullName != null
                                ? controller.user.value!.fullName!
                                : S.current.notAvailable,
                            fontSize: AppDimension.extraLargeFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                  child: SvgPicture.asset(
                    AppPaths.icNotification,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.largeSpace),
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimension.mediumSpace),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          AppDimension.mediumBorderRadius,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: S.current.memberRank,
                                fontWeight: FontWeight.w700,
                              ),
                              const TextWidget(
                                text: '100/300',
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.smallSpace),
                          LinearProgressIndicator(
                            value: 0.3,
                            minHeight: 8,
                            backgroundColor: AppColors.greyBackground,
                            color: AppColors.pink600,
                            borderRadius: BorderRadius.circular(
                              AppDimension.largeBorderRadius,
                            ),
                          ),
                          const SizedBox(height: AppDimension.smallSpace),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: S.current.silver,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWidget(
                                text: S.current.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.largeSpace),
                    Container(
                      padding: const EdgeInsets.all(AppDimension.mediumSpace),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          AppDimension.mediumBorderRadius,
                        ),
                      ),
                      child: Column(
                        children: [
                          CategoryItem(
                            title: S.current.accountInformation,
                            icon: AppPaths.icAccount,
                            route: AppRoutes.accountInformationScreen,
                          ),
                          CategoryItem(
                            title: S.current.changePassword,
                            icon: AppPaths.icLock,
                            route: AppRoutes.changePasswordScreen,
                          ),
                          CategoryItem(
                            title: S.current.setting,
                            icon: AppPaths.icSetting,
                            route: AppRoutes.settingScreen,
                          ),
                          CategoryItem(
                            title: S.current.deleteAccount,
                            icon: AppPaths.icDeleteAccount,
                            route: '',
                          ),
                        ]
                            .asMap()
                            .entries
                            .map(
                              (e) => _itemCategory(
                                isBorderTop: e.key == 0 ? true : false,
                                item: e.value,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: AppDimension.largeSpace),
                    Container(
                      padding: const EdgeInsets.all(AppDimension.mediumSpace),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          AppDimension.mediumBorderRadius,
                        ),
                      ),
                      child: Column(
                        children: [
                          CategoryItem(
                            title: S.current.appointmentManage,
                            icon: AppPaths.icCalendar,
                            route: AppRoutes.appoinmentManageScreen,
                          ),
                          CategoryItem(
                            title: S.current.report,
                            icon: AppPaths.icReport,
                            route: AppRoutes.reportScreen,
                          ),
                          CategoryItem(
                            title: S.current.chat,
                            icon: AppPaths.icChat,
                            route: AppRoutes.chat,
                          ),
                        ]
                            .asMap()
                            .entries
                            .map(
                              (e) => _itemCategory(
                                isBorderTop: e.key == 0 ? true : false,
                                item: e.value,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: AppDimension.largeSpace),
                    TextWidget(
                      text: '${S.current.version}: 1.0.0',
                      fontSize: AppDimension.smallFontSize,
                    ),
                    const SizedBox(height: AppDimension.largeSpace),
                    RoundedButtonWidget(
                      text: S.current.signOut,
                      onPressed: () async => await controller.onSignOut(),
                      borderColor: AppColors.errorColor,
                      backgroundColor: Colors.white,
                      textColor: AppColors.errorColor,
                    ),
                    const SizedBox(height: AppDimension.largeSpace * 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
