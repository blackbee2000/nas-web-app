import 'dart:io';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/home_controller.dart';
import 'package:nasmobile/feature/app/controllers/main_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class MainView extends BaseView<MainController> {
  const MainView({super.key});

  Widget _buildBanner() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.mediumSpace,
        ),
        child: Column(
          children: [
            Obx(
              () => controller.banners.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      height: 132,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          autoPlay: true,
                          height: double.infinity,
                          onPageChanged: (index, reason) {
                            controller.indexCurrentBanner.value = index;
                          },
                        ),
                        items: controller.banners
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius + 4,
                                ),
                                child: Image.network(
                                  e.imageUrls.first,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fitWidth,
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
                                      color:
                                          AppColors.errorColor.withOpacity(0.2),
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
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => controller.banners.isNotEmpty &&
                      controller.banners.length > 1
                  ? Container(
                      margin:
                          const EdgeInsets.only(top: AppDimension.smallSpace),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.banners
                            .map(
                              (e) => AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                margin: controller.banners.indexOf(e) ==
                                        controller.banners.length - 1
                                    ? EdgeInsets.zero
                                    : const EdgeInsets.only(
                                        right: AppDimension.smallSpace / 2,
                                      ),
                                width: controller.banners.indexOf(e) ==
                                        controller.indexCurrentBanner.value
                                    ? 24
                                    : 12,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.disableButtonColor,
                                  gradient: controller.banners.indexOf(e) ==
                                          controller.indexCurrentBanner.value
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
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      );

  Widget _buildTitle({required String title, VoidCallback? onTap}) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.smallSpace,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: title,
              fontSize: AppDimension.largeFontSize,
              color: AppColors.sixBlackText,
              fontWeight: FontWeight.w700,
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  TextWidget(
                    text: S.current.viewAll,
                    color: AppColors.sevenBlackText,
                  ),
                  const SizedBox(width: AppDimension.smallSpace / 2),
                  SvgPicture.asset(
                    AppPaths.icArrowRightDouble,
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.sevenBlackText,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _itemStore({required StoreEntity item}) => GestureDetector(
        onTap: () => controller.onViewDetail(store: item),
        child: Container(
          width: 164,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius + 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackText.withOpacity(0.08),
                offset: const Offset(4, 8),
                blurRadius: 32,
              )
            ],
          ),
          margin: controller.stores.indexOf(item) == 0
              ? const EdgeInsets.fromLTRB(
                  AppDimension.mediumSpace,
                  0,
                  AppDimension.mediumSpace,
                  0,
                )
              : const EdgeInsets.only(right: AppDimension.mediumSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        AppDimension.largeBorderRadius + 6,
                      ),
                      topRight: Radius.circular(
                        AppDimension.largeBorderRadius + 6,
                      ),
                    ),
                    child: Image.network(
                      item.avatar ?? "",
                      width: double.infinity,
                      height: 138,
                      fit: BoxFit.cover,
                      loadingBuilder: (ct, w, e) {
                        if (e == null) return w;

                        return Container(
                          width: double.infinity,
                          height: 138,
                          decoration: BoxDecoration(
                            color: AppColors.pink600.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                AppDimension.largeBorderRadius + 6,
                              ),
                              topRight: Radius.circular(
                                AppDimension.largeBorderRadius + 6,
                              ),
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
                        height: 138,
                        decoration: BoxDecoration(
                          color: AppColors.errorColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              AppDimension.largeBorderRadius + 6,
                            ),
                            topRight: Radius.circular(
                              AppDimension.largeBorderRadius + 6,
                            ),
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
                  Positioned(
                    top: AppDimension.smallSpace,
                    right: AppDimension.smallSpace,
                    child: GestureDetector(
                      onTap: () async => await controller.likeStore(
                        store: item,
                      ),
                      child: Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(
                          AppDimension.smallSpace / 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item.isFavorite
                                ? AppPaths.icLikeActive
                                : AppPaths.icLike,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.smallSpace),

              /// Store name
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.smallSpace,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: item.storeName ?? S.current.notAvailable,
                        fontWeight: FontWeight.w500,
                        color: AppColors.sixBlackText,
                      ),
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: item.ratingStar.toString(),
                          fontSize: AppDimension.smallFontSize,
                          color: AppColors.eightBlackText,
                        ),
                        const RatingStars(
                          value: 5,
                          starCount: 1,
                          starSize: 16,
                          starColor: AppColors.yellowF4D550,
                          starOffColor: AppColors.greyText,
                          valueLabelVisibility: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimension.smallSpace),

              /// Address
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.smallSpace,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppPaths.icAddress,
                      width: 16,
                      height: 16,
                    ),
                    Expanded(
                      child: TextWidget(
                        text: item.addressStore ?? S.current.notAvailable,
                        fontSize: AppDimension.smallFontSize,
                        color: AppColors.eightBlackText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimension.smallSpace),

              /// Phone
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimension.smallSpace,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppPaths.icPhone,
                      width: 16,
                      height: 16,
                    ),
                    Expanded(
                      child: TextWidget(
                        text: item.hotline ?? S.current.notAvailable,
                        fontSize: AppDimension.smallFontSize,
                        color: AppColors.eightBlackText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _itemPost({required StoreEntity item}) => GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 125,
          margin:
              controller.stores.indexOf(item) == controller.stores.length - 1
                  ? const EdgeInsets.fromLTRB(
                      AppDimension.mediumSpace,
                      0,
                      AppDimension.mediumSpace,
                      0,
                    )
                  : const EdgeInsets.fromLTRB(
                      AppDimension.mediumSpace,
                      0,
                      AppDimension.mediumSpace,
                      AppDimension.mediumSpace,
                    ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius + 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(4, 8),
                blurRadius: 32,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    AppDimension.largeBorderRadius + 6,
                  ),
                  bottomLeft: Radius.circular(
                    AppDimension.largeBorderRadius + 6,
                  ),
                ),
                child: Image.network(
                  item.avatar ?? "",
                  width: 126,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (ct, w, e) {
                    if (e == null) return w;

                    return Container(
                      width: 126,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.pink600.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            AppDimension.largeBorderRadius + 6,
                          ),
                          bottomLeft: Radius.circular(
                            AppDimension.largeBorderRadius + 6,
                          ),
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
                    width: 126,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.errorColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          AppDimension.largeBorderRadius + 6,
                        ),
                        bottomLeft: Radius.circular(
                          AppDimension.largeBorderRadius + 6,
                        ),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppDimension.smallSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: item.storeName ?? S.current.notAvailable,
                            fontSize: AppDimension.largeFontSize,
                            fontWeight: FontWeight.w700,
                            color: AppColors.sixBlackText,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(
                                AppDimension.smallSpace / 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  item.isFavorite
                                      ? AppPaths.icLikeActive
                                      : AppPaths.icLike,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextWidget(
                        text: item.addressStore ?? S.current.notAvailable,
                        maxlines: 4,
                        color: AppColors.greyText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondGreyBackground,
        elevation: 0,
        centerTitle: true,
        leading: null,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonIcon(
              onTap: Get.find<HomeController>().openDrawer,
              icon: AppPaths.icMenu,
            ),
            Row(
              children: [
                TextWidget(
                  text: '${S.current.wellcome.split("").sublist(
                        0,
                        S.current.wellcome.length - 1,
                      ).join("")} ',
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondBlackText,
                ),
                Obx(
                  () => ShaderMask(
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
                      text: controller.user.value?.fullName ??
                          S.current.notAvailable,
                      fontSize: AppDimension.largeFontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const TextWidget(
                  text: '!',
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondBlackText,
                ),
              ],
            ),
            Row(
              children: [
                buttonIcon(icon: AppPaths.icMessage),
                const SizedBox(width: AppDimension.smallSpace / 2),
                buttonIcon(icon: AppPaths.icNotification),
              ],
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: () async => await controller.init(),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimension.mediumSpace),

                /// Banner
                _buildBanner(),
                const SizedBox(height: AppDimension.largeSpace * 1.5),

                /// Search
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.mediumSpace,
                  ),
                  child: TextWidget(
                    text: S.current.youWantSearch,
                    color: AppColors.fourBlackText,
                    fontSize: AppDimension.extraLargeFontSize,
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.mediumSpace,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppDimension.largeBorderRadius * 10,
                            ),
                            color: Colors.white,
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
                          child: TextFormFieldWidget(
                            isBorder: false,
                            controller: controller.search,
                            hintText: S.current.search,
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(
                                AppDimension.smallSpace + 2,
                              ),
                              child: SvgPicture.asset(
                                AppPaths.icSearch,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimension.mediumSpace),
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(
                          AppDimension.smallSpace + 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius + 3,
                          ),
                          color: Colors.white,
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
                        child: SvgPicture.asset(
                          AppPaths.icFilter,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimension.largeSpace * 1.5),

                /// Appoinment upcoming
                // _buildTitle(
                //   icon: AppPaths.icCalendar,
                //   title: S.current.appoinmentUpcoming,
                // ),
                // const SizedBox(height: AppDimension.smallSpace),
                // Obx(
                //   () => controller.bookingList.isNotEmpty
                //       ? ListView.builder(
                //           physics: const NeverScrollableScrollPhysics(),
                //           shrinkWrap: true,
                //           primary: false,
                //           padding: EdgeInsets.zero,
                //           itemCount: controller.bookingList.length,
                //           itemBuilder: (ct, i) {
                //             final item = controller.bookingList[i];

                //             return GestureDetector(
                //               onTap: () => controller.goDetail(booking: item),
                //               child: Container(
                //                 margin: const EdgeInsets.symmetric(
                //                   horizontal: AppDimension.mediumSpace,
                //                 ),
                //                 padding: i == 0
                //                     ? const EdgeInsets.only(
                //                         bottom: AppDimension.mediumSpace)
                //                     : const EdgeInsets.symmetric(
                //                         vertical: AppDimension.mediumSpace,
                //                       ),
                //                 decoration: const BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(color: AppColors.border),
                //                   ),
                //                 ),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         TextWidget(
                //                           text: item.store?.storeName ??
                //                               S.current.freelance,
                //                           fontSize: AppDimension.largeFontSize,
                //                           fontWeight: FontWeight.w700,
                //                         ),
                //                         Row(
                //                           children: [
                //                             const Icon(
                //                               Icons.access_time,
                //                               color: AppColors.pink600,
                //                               size: 20,
                //                             ),
                //                             const SizedBox(
                //                               width:
                //                                   AppDimension.smallSpace / 2,
                //                             ),
                //                             TextWidget(
                //                               text: item.bookingTime != null &&
                //                                       item.bookingDate != null
                //                                   ? "${item.bookingTime!.split(":").sublist(0, 2).join(":")} ${DateFormat(DateFormatUtil.kDDMMYYYY).format(
                //                                       item.bookingDate!,
                //                                     )}"
                //                                   : S.current.notAvailable,
                //                               fontSize:
                //                                   AppDimension.smallFontSize,
                //                               color: AppColors.greyText,
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                     const SizedBox(
                //                         height: AppDimension.smallSpace / 3),
                //                     TextWidget(
                //                         text:
                //                             '${S.current.technician}: ${item.technician?.technicianName ?? S.current.notAvailable}'),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         )
                //       : const Center(child: NoDataWidget()),
                // ),
                // const SizedBox(
                //   height: AppDimension.largeSpace,
                // ),

                /// Store review hot
                _buildTitle(title: S.current.store),
                const SizedBox(height: AppDimension.mediumSpace),
                Obx(
                  () => controller.stores.isNotEmpty
                      ? SizedBox(
                          width: double.infinity,
                          height: 230,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemCount: controller.stores.length,
                            itemBuilder: (ct, i) => _itemStore(
                              item: controller.stores[i],
                            ),
                          ),
                        )
                      : const Center(child: NoDataWidget()),
                ),
                const SizedBox(height: AppDimension.mediumSpace),

                /// Post
                _buildTitle(title: S.current.news),
                const SizedBox(height: AppDimension.mediumSpace),
                Obx(
                  () => controller.stores.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.stores.length,
                          itemBuilder: (ct, i) => _itemPost(
                            item: controller.stores[i],
                          ),
                        )
                      : const Center(child: NoDataWidget()),
                ),

                /// Space bottom
                SizedBox(
                  height: Platform.isAndroid
                      ? AppDimension.mediumSpace * 7
                      : AppDimension.mediumSpace * 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
