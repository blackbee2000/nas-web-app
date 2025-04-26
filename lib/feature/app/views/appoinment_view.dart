import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/enums/status_booking.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/decoration_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentView extends BaseView<AppoinmentController> {
  const AppoinmentView({super.key});

  Widget _buildItemAppoinment() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        margin: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.smallSpace,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius + 4,
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      const SizedBox(width: AppDimension.mediumSpace),
                      IntrinsicWidth(
                        child: Container(
                          padding:
                              const EdgeInsets.all(AppDimension.smallSpace / 2),
                          decoration: BoxDecoration(
                            color: AppColors.thirdGreyBackground,
                            borderRadius: BorderRadius.circular(
                              AppDimension.largeBorderRadius * 10,
                            ),
                          ),
                          child: TextWidget(
                            text: '20/10/2023 - 09:30 AM',
                            fontSize: AppDimension.extraSmallFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.thirdteenBlackText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.smallSpace),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimension.smallBorderRadius,
                        ),
                        child: Image.network(
                          "",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (ct, w, e) {
                            if (e == null) return w;

                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.pink600.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                  AppDimension.smallBorderRadius,
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.pink600.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                AppDimension.smallBorderRadius,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.error_outline,
                                size: 16,
                                color: AppColors.errorColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimension.mediumSpace),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Tên cửa hàng',
                              fontWeight: FontWeight.w600,
                              color: AppColors.twelveBlackText,
                            ),
                            const SizedBox(height: AppDimension.smallSpace / 2),
                            TextWidget(
                              text:
                                  '60-60A Phan Xích Long, Phường 1, Phú Nhuận, Thành phố Hồ Chí Minh',
                              fontSize: AppDimension.smallFontSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.thirdteenBlackText,
                              maxlines: 2,
                            ),
                            const SizedBox(height: AppDimension.smallSpace / 2),
                            TextWidget(
                              text: 'Tên khách hàng',
                              fontSize: AppDimension.smallFontSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.orangeF99917,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimension.smallSpace,
                                vertical: AppDimension.smallSpace / 3,
                              ),
                              decoration: BoxDecoration(
                                color: StatusBooking.cancelled.color,
                                border: Border.all(
                                  color: StatusBooking.cancelled.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius * 10,
                                ),
                              ),
                              child: TextWidget(
                                text: StatusBooking.cancelled.nameVN,
                                fontSize: AppDimension.extraSmallFontSize,
                                color: StatusBooking.cancelled.colorText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                colorFilter: ColorFilter.mode(
                  AppColors.thirdteenBlackText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }

        Get.back(result: true);
      },
      child: Scaffold(
        backgroundColor: AppColors.secondGreyBackground,
        appBar: AppBarWidget(
          leadingWidth: 0,
          titleName: S.current.news,
          imagePath: AppPaths.backgroundAppBar,
          titleColor: Colors.white,
          heightAppBar: 110,
          actions: [
            IconButton(
              onPressed: controller.openOptionBooking,
              icon: SvgPicture.asset(
                AppPaths.icAddBooking,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.mediumSpace,
              ),
              child: Obx(
                () => DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: TabBar(
                    indicator: RoundedTabIndicator(
                      color: Colors.white,
                      radius: AppDimension.largeBorderRadius,
                      indicatorHeight: 6,
                    ),
                    onTap: controller.onChangeTab,
                    tabs: controller.tabs
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimension.mediumSpace,
                            ),
                            child: Opacity(
                              opacity: controller.currentTab.value ==
                                      controller.tabs.indexOf(e)
                                  ? 1
                                  : 0.7,
                              child: TextWidget(
                                text: e,
                                color: Colors.white,
                                fontSize: AppDimension.largeFontSize,
                                fontWeight: FontWeight.w700,
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
        ),
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.all(AppDimension.mediumSpace),
              child: Column(
                children: [
                  const SizedBox(height: AppDimension.mediumSpace),
                  Image.asset(
                    AppPaths.emptyBooking,
                    width: 252,
                    height: 224,
                  ),
                  const SizedBox(height: AppDimension.largeSpace * 2),
                  TextWidget(
                    text: S.current.emptyBooking,
                    fontSize: AppDimension.largeFontSize,
                    color: AppColors.nineBlackText,
                  ),
                  const SizedBox(height: AppDimension.mediumSpace),
                  RoundedButtonWidget(
                    width: screenSize.width - (AppDimension.largeSpace * 4),
                    onPressed: controller.openOptionBooking,
                    text: S.current.bookingNow,
                  ),
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimension.mediumSpace,
              ),
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (ct, i) => _buildItemAppoinment(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
