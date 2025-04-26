import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/intro_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class IntroView extends BaseView<IntroController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Obx(
          () => CarouselSlider(
            controller: controller.carouselSliderController,
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: false,
              height: MediaQuery.of(context).size.height,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index, reason) {
                controller.currentIndex.value = index;
              },
            ),
            items: controller.introItems
                .map(
                  (e) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(AppDimension.largeSpace + 4),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppPaths.intro1,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          e.image,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: AppDimension.largeSpace),
                        Image.asset(
                          AppPaths.blurIntro,
                          width: 190,
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 3),
                        TextWidget(
                          text: e.title,
                          fontSize: AppDimension.extraLargeFontSize + 2,
                          fontWeight: FontWeight.w700,
                          maxlines: 2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimension.smallSpace),
                        TextWidget(
                          text: e.content,
                          fontSize: AppDimension.largeFontSize,
                          color: AppColors.secondBlackText,
                          maxlines: 10,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 4),
                        Row(
                          mainAxisAlignment: controller.currentIndex.value ==
                                  controller.introItems.length - 1
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            controller.currentIndex.value ==
                                    controller.introItems.length - 1
                                ? const SizedBox()
                                : TextWidget(
                                    text: S.current.skip,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondBlackText,
                                    fontSize:
                                        AppDimension.extraLargeFontSize + 2,
                                  ),
                            controller.currentIndex.value ==
                                    controller.introItems.length - 1
                                ? RoundedButtonWidget(
                                    width: 152,
                                    onPressed: controller.onChangeIntro,
                                    text: S.current.start,
                                    iconSuffix: SvgPicture.asset(
                                      AppPaths.icArrowRightDouble,
                                      width: 24,
                                      height: 24,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: controller.onChangeIntro,
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                          ),
                                        ],
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.pinkFFBEFF,
                                            AppColors.pinkF01799,
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          AppPaths.icArrowRight,
                                          width: 24,
                                          height: 24,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
