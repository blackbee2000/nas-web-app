import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/account_setting_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class AccountSettingView extends BaseView<AccountSettingController> {
  const AccountSettingView({super.key});

  Widget _buildItem({
    VoidCallback? onTap,
    required String icon,
    required String title,
    required String content,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppDimension.largeBorderRadius + 8,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius + 8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppDimension.mediumSpace),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.pink50,
                  borderRadius: BorderRadius.circular(
                    AppDimension.largeBorderRadius + 3,
                  ),
                ),
                padding: const EdgeInsets.all(AppDimension.smallSpace),
                child: SvgPicture.asset(icon),
              ),
              const SizedBox(width: AppDimension.mediumSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: title,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimension.largeFontSize,
                      color: AppColors.secondBlackText,
                    ),
                    const SizedBox(height: AppDimension.smallSpace / 2),
                    TextWidget(
                      text: content,
                      fontSize: AppDimension.largeFontSize,
                      color: AppColors.border,
                      maxlines: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimension.mediumSpace),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  AppPaths.icArrowLeft,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.secondBorder,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBarWidget(
        titleName: S.current.accountSetting,
        imagePath: AppPaths.backgroundAppBar,
        titleColor: Colors.white,
        heightAppBar: 60,
        colorLeading: Colors.white,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildItem(
                icon: AppPaths.icChangePassword,
                title: S.current.changePassword,
                content: S.current.contentOption1,
                onTap: () => Get.toNamed(AppRoutes.changePasswordScreen),
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              _buildItem(
                icon: AppPaths.icEdit,
                title: S.current.editAccount,
                content: S.current.contentOption2,
                onTap: () => Get.toNamed(AppRoutes.accountInformationScreen),
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              _buildItem(
                icon: AppPaths.icLogoutPink,
                title: S.current.signOut,
                content: S.current.contentOption3,
                onTap: controller.showPopupLogout,
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              _buildItem(
                icon: AppPaths.icDeleteAccount,
                title: S.current.deleteAccount,
                content: S.current.contentOption4,
                onTap: controller.showPopupDeleteAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
