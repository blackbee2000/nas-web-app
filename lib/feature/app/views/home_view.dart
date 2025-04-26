import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/home_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/app/views/camera_try_on_nails/try_nails_view.dart';
import 'package:nasmobile/feature/app/views/main_view.dart';
import 'package:nasmobile/feature/app/views/news_view.dart';
import 'package:nasmobile/feature/app/views/stores_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  Widget _buildTitleOption({required String title}) => TextWidget(
        text: title,
        color: AppColors.fifBlackText,
        fontSize: AppDimension.largeFontSize,
        fontWeight: FontWeight.w700,
      );

  Widget _buildOption({
    VoidCallback? onTap,
    required String icon,
    required String title,
    Widget? widgetRight,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimension.mediumSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(
                      AppDimension.smallSpace - 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppDimension.largeBorderRadius + 3,
                      ),
                    ),
                    child: SvgPicture.asset(icon),
                  ),
                  const SizedBox(width: AppDimension.mediumSpace),
                  TextWidget(
                    text: title,
                    fontSize: AppDimension.largeFontSize,
                    color: AppColors.fourBlackText,
                  ),
                ],
              ),
              widgetRight ?? const SizedBox(),
            ],
          ),
        ),
      );

  Widget _buildDrawer() => Container(
        width: Get.width * 0.7,
        height: Get.height,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(Get.context!).viewPadding.top,
          ),
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(Get.context!).viewPadding.bottom,
          ),
        ),
        decoration: const BoxDecoration(
          color: AppColors.secondGreyBackground,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              AppDimension.largeBorderRadius + 4,
            ),
            bottomRight: Radius.circular(
              AppDimension.largeBorderRadius + 4,
            ),
          ),
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDimension.largeBorderRadius * 100,
                  ),
                  child: Image.network(
                    controller.user.value?.avatar ?? "",
                    width: 60,
                    height: 60,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (ct, w, e) {
                      if (e == null) return w;

                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.pink600.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius + 4,
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pink600,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (ct, o, s) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimension.largeBorderRadius + 4,
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
                  ),
                ),
                const SizedBox(height: AppDimension.mediumSpace),
                TextWidget(
                  text:
                      controller.user.value?.fullName ?? S.current.notAvailable,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimension.extraLargeFontSize + 4,
                  color: AppColors.secondBlackText,
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Ranking
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: AppDimension.mediumSpace,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 86,
                        padding: const EdgeInsets.all(AppDimension.largeSpace),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                          image: const DecorationImage(
                            image: AssetImage(
                              AppPaths.rankingbackground,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextWidget(
                                text:
                                    '${S.current.memberRank}:\n${S.current.gold}',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: AppDimension.largeFontSize,
                                maxlines: 2,
                              ),
                            ),
                            const RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 20,
                      child: Image.asset(
                        AppPaths.ranking,
                        width: 99,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),

                ///Option
                /// Account
                _buildTitleOption(title: S.current.account),
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                _buildOption(
                  icon: AppPaths.icHistoryActivity,
                  title: S.current.historyActivity,
                ),
                _buildOption(
                  icon: AppPaths.icSetting,
                  title: S.current.settingAccount,
                  onTap: () {
                    Get.toNamed(AppRoutes.accountSetting);
                    controller.scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.pinkFFBEFF,
                        AppColors.pinkF01799,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),

                /// General
                _buildTitleOption(title: S.current.general),
                _buildOption(
                  icon: AppPaths.icLanguage,
                  title: S.current.language2,
                  onTap: () {
                    Get.toNamed(AppRoutes.settingScreen);
                    controller.scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                _buildOption(
                  icon: AppPaths.icNotificationPink,
                  title: S.current.notification,
                ),
                _buildOption(
                  icon: AppPaths.icPrivacity,
                  title: S.current.privacity,
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.pinkFFBEFF,
                        AppColors.pinkF01799,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),
                _buildOption(
                  icon: AppPaths.icLogout,
                  title: S.current.signOut,
                  onTap: () async {
                    await controller.onSignOut();
                    controller.scaffoldKey.currentState?.closeDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      extendBody: true,
      drawer: _buildDrawer(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: const [
          MainView(),
          NewsView(),
          StoresView(),
          TryNailsView(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () async => await controller.gotoBooking(),
        child: Container(
          width: 55,
          height: 55,
          padding: const EdgeInsets.all(AppDimension.smallSpace + 4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.pinkFFBEFF,
                AppColors.pinkF01799,
              ],
            ),
          ),
          child: SvgPicture.asset(
            AppPaths.icBookAppoinment,
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          height: Platform.isAndroid ? 70 : 110,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimension.largeBorderRadius),
              topRight: Radius.circular(AppDimension.largeBorderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(4, 0),
                blurRadius: 8,
                spreadRadius: 3,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimension.largeBorderRadius),
              topRight: Radius.circular(AppDimension.largeBorderRadius),
            ),
            child: BottomAppBar(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              notchMargin: AppDimension.smallSpace / 2,
              child: Row(
                children: [
                  NavigatorBottomItem(
                    title: S.current.home,
                    icon: AppPaths.icHome,
                    activeIcon: AppPaths.icHomeActive,
                  ),
                  NavigatorBottomItem(
                    title: S.current.news,
                    icon: AppPaths.icPost,
                    activeIcon: AppPaths.icPostActive,
                  ),
                  NavigatorBottomItem(
                    title: S.current.store,
                    icon: AppPaths.icStore,
                    activeIcon: AppPaths.icStoreActive,
                  ),
                  NavigatorBottomItem(
                    title: S.current.vr360,
                    icon: AppPaths.icVrNail,
                    activeIcon: AppPaths.icVrNailActive,
                  )
                ]
                    .asMap()
                    .entries
                    .map(
                      (e) => Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: e.key == 1
                              ? const EdgeInsets.only(
                                  right: AppDimension.largeSpace * 2,
                                )
                              : e.key == 2
                                  ? const EdgeInsets.only(
                                      left: AppDimension.largeSpace * 2,
                                    )
                                  : EdgeInsets.zero,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius * 10,
                                ),
                                onTap: () =>
                                    controller.onChangeNavigatorBottom(e.key),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      e.key == controller.currentPage.value
                                          ? e.value.activeIcon
                                          : e.value.icon,
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      height: AppDimension.smallSpace,
                                    ),
                                    e.key == controller.currentPage.value
                                        ? ShaderMask(
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
                                              text: e.value.title,
                                              fontSize:
                                                  AppDimension.smallFontSize,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : TextWidget(
                                            text: e.value.title,
                                            fontSize:
                                                AppDimension.smallFontSize,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.thirdGreyText,
                                          ),
                                  ],
                                ),
                              ),
                              e.key == controller.currentPage.value
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        top: AppDimension.smallSpace,
                                      ),
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.pinkFFBEFF,
                                            AppColors.pinkF01799,
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
