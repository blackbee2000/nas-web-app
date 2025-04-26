import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/service_detail_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ServiceDetailView extends BaseView<ServiceDetailController> {
  const ServiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: AppColors.secondGreyBackground,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 110 + viewPadding.top,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  (AppDimension.largeBorderRadius + 4) * 2,
                ),
                bottomRight: Radius.circular(
                  (AppDimension.largeBorderRadius + 4) * 2,
                ),
              ),
              image: DecorationImage(
                image: AssetImage(AppPaths.backgroundAppBar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBarWidget(
              colorLeading: Colors.white,
              backgroundColor: Colors.transparent,
              titleName: "Tên dịch vụ",
              titleColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppPaths.icLike,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppPaths.icShare,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  AppDimension.largeBorderRadius + 4,
                ),
                topRight: Radius.circular(
                  AppDimension.largeBorderRadius + 4,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    AppDimension.mediumSpace,
                    AppDimension.mediumSpace,
                    AppDimension.mediumSpace,
                    max(
                      AppDimension.mediumSpace,
                      viewPadding.bottom,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        AppDimension.largeBorderRadius + 4,
                      ),
                      topRight: Radius.circular(
                        AppDimension.largeBorderRadius + 4,
                      ),
                    ),
                  ),
                  child: RoundedButtonWidget(
                    onPressed: () {},
                    text: S.current.appoinmentBook,
                  ),
                ),
              ),
            ),
            body: Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.fromLTRB(
                AppDimension.mediumSpace,
                AppDimension.smallSpace,
                AppDimension.mediumSpace,
                AppDimension.mediumSpace,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 244,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimension.largeBorderRadius + 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: const Offset(0, 0),
                            blurRadius: 25,
                          )
                        ],
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: double.infinity,
                          onPageChanged: (index, reason) {
                            controller.indexImageCurrent.value = index;
                          },
                        ),
                        items: [1, 2, 3]
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius + 4,
                                ),
                                child: Image.network(
                                  "https://www.lookme.vn/blog/wp-content/uploads/2021/01/nail-do-3.jpeg",
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (ct, w, e) {
                                    if (e == null) return w;

                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.pink600.withOpacity(0.2),
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
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.pink600.withOpacity(0.2),
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
                            )
                            .toList(),
                      ),
                    ),
                    Obx(
                      () => Container(
                        margin:
                            const EdgeInsets.only(top: AppDimension.smallSpace),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [1, 2, 3]
                              .map(
                                (e) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin: [1, 2, 3].indexOf(e) ==
                                          [1, 2, 3].length - 1
                                      ? EdgeInsets.zero
                                      : const EdgeInsets.only(
                                          right: AppDimension.smallSpace / 2,
                                        ),
                                  width: [1, 2, 3].indexOf(e) ==
                                          controller.indexImageCurrent.value
                                      ? 24
                                      : 12,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.disableButtonColor,
                                    gradient: [1, 2, 3].indexOf(e) ==
                                            controller.indexImageCurrent.value
                                        ? const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              AppColors.brownA57B1E,
                                              AppColors.brown723F00,
                                              AppColors.brownCFA751,
                                              AppColors.brownA27D27,
                                              AppColors.brown8E6307,
                                              AppColors.brown9A7014,
                                            ],
                                          )
                                        : null,
                                    borderRadius: BorderRadius.circular(
                                      AppDimension.largeBorderRadius,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimension.mediumSpace),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppDimension.mediumSpace),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppDimension.largeBorderRadius,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              RatingStars(
                                value: 5,
                                starCount: 1,
                                starSize: 16,
                                starColor: AppColors.yellowF4D550,
                                starOffColor: AppColors.greyText,
                                valueLabelVisibility: false,
                              ),
                              SizedBox(width: AppDimension.smallSpace / 2),
                              TextWidget(
                                text: "4.9 (456 đánh giá)",
                                color: AppColors.sevenBlackText,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimension.smallSpace),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppPaths.icMoney,
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(
                                width: AppDimension.smallSpace / 2,
                              ),
                              const TextWidget(
                                text: "2.000.000 ",
                                color: AppColors.blackText,
                                fontSize: AppDimension.largeFontSize,
                                fontWeight: FontWeight.w700,
                              ),
                              const TextWidget(
                                text: "vnd",
                                color: AppColors.sevenBlackText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimension.mediumSpace),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppDimension.mediumSpace),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppDimension.largeBorderRadius,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: S.current.describle,
                            fontSize: AppDimension.largeFontSize,
                            fontWeight: FontWeight.w700,
                            color: AppColors.twelveBlackText,
                          ),
                          const SizedBox(height: AppDimension.smallSpace),
                          const TextWidget(
                            text:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                'Mauris maximus nec tortor a scelerisque. Mauris varius, '
                                'sapien vel congue luctus, magna ex tincidunt orci, a consequat '
                                'magna nunc vel dui. Phasellus placerat lacinia quam, sit amet pharetra '
                                'felis iaculis quis. Vestibulum efficitur, lacus at rutrum sodales, est '
                                'nulla cursus libero, vitae venenatis mauris lectus id diam. Nunc iaculis, '
                                'nibh quis pellentesque pellentesque, dolor turpis egestas nisi, ut volutpat tellus magna eget nunc.',
                            color: AppColors.thirdteenBlackText,
                            maxlines: 100,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
