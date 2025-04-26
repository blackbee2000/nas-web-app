import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/store_detail_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class StoreDetailView extends BaseView<StoreDetailController> {
  const StoreDetailView({super.key});

  Widget _itemInformation({required String icon, required String text}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.sevenBlackText,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppDimension.smallSpace),
          Expanded(
            child: TextWidget(
              text: text,
              color: AppColors.sevenBlackText,
              maxlines: 3,
            ),
          ),
        ],
      );

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
              titleName: S.current.storeDetail,
              titleColor: Colors.white,
              actions: [
                Obx(
                  () => IconButton(
                    onPressed: () async => await controller.likeStore(),
                    icon: SvgPicture.asset(
                      controller.store.value != null &&
                              controller.store.value!.isFavorite
                          ? AppPaths.icLikeActive
                          : AppPaths.icLike,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        controller.store.value != null &&
                                controller.store.value!.isFavorite
                            ? AppColors.redE54E4E
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: SecondaryRoundedButonWidget(
                          onPressed: () => Get.toNamed(AppRoutes.service),
                          text: S.current.service,
                        ),
                      ),
                      const SizedBox(width: AppDimension.smallSpace),
                      Expanded(
                        child: RoundedButtonWidget(
                          onPressed: () => Get.toNamed(
                            AppRoutes.view360Store,
                            arguments: controller.store.value?.imageUrls.first,
                          ),
                          text: S.current.view360Store,
                        ),
                      ),
                    ],
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
                child: Obx(
                  () => Column(
                    children: [
                      /// Avatar
                      Container(
                        width: double.infinity,
                        height: 244,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: const Offset(0, 0),
                              blurRadius: 25,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius + 4,
                          ),
                          child: Image.network(
                            controller.store.value?.avatar ?? "",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (ct, w, e) {
                              if (e == null) return w;

                              return Container(
                                width: double.infinity,
                                height: double.infinity,
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
                      ),
                      const SizedBox(height: AppDimension.mediumSpace),

                      /// Information
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
                          children: [
                            _itemInformation(
                              icon: AppPaths.icAddress,
                              text: controller.store.value?.addressStore ?? "",
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
                            _itemInformation(
                              icon: AppPaths.icClock,
                              text:
                                  '${controller.store.value?.openTime?.split(":").sublist(0, 2).join(":")} -'
                                  ' ${controller.store.value?.closeTime?.split(":").sublist(0, 2).join(":")}',
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
                            _itemInformation(
                              icon: AppPaths.icPhone,
                              text: controller.store.value?.hotline ?? "",
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
                            _itemInformation(
                              icon: AppPaths.icEmail,
                              text: 'nail@gmail.com',
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.viewRating),
                              child: Row(
                                children: [
                                  const RatingStars(
                                    value: 5,
                                    starCount: 1,
                                    starSize: 16,
                                    starColor: AppColors.yellowF4D550,
                                    starOffColor: AppColors.greyText,
                                    valueLabelVisibility: false,
                                  ),
                                  const SizedBox(
                                      width: AppDimension.smallSpace),
                                  TextWidget(
                                    text: controller.store.value != null
                                        ? controller.store.value!.ratingStar
                                            .toString()
                                        : S.current.notAvailable,
                                    fontSize: AppDimension.smallFontSize,
                                    color: AppColors.sevenBlackText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimension.mediumSpace),

                      /// Introduce
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
                              text: S.current.introduce,
                              color: AppColors.twelveBlackText,
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimension.largeFontSize,
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
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
                      const SizedBox(height: AppDimension.mediumSpace),

                      /// Google map
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
                              text: S.current.directions,
                              color: AppColors.twelveBlackText,
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimension.largeFontSize,
                            ),
                            const SizedBox(height: AppDimension.mediumSpace),
                            SizedBox(
                              width: double.infinity,
                              height: 244,
                              child: Obx(
                                () => ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.largeBorderRadius + 4,
                                  ),
                                  child: GoogleMap(
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: false,
                                    markers: controller.marker.toSet(),
                                    initialCameraPosition:
                                        controller.initCamera.value,
                                    onMapCreated: controller.onMapCreated,
                                    zoomControlsEnabled: false,
                                    zoomGesturesEnabled: false,
                                    gestureRecognizers: <Factory<
                                        OneSequenceGestureRecognizer>>{
                                      Factory<TapGestureRecognizer>(
                                        () => TapGestureRecognizer(),
                                      ),
                                      Factory<ScaleGestureRecognizer>(
                                        () => ScaleGestureRecognizer(),
                                      ),
                                      Factory<PanGestureRecognizer>(
                                        () => PanGestureRecognizer(),
                                      ),
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
