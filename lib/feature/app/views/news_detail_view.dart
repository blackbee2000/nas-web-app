import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/news_detail_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class NewsDetailView extends BaseView<NewsDetailController> {
  const NewsDetailView({super.key});

  Widget _buildIcSVGButton({
    VoidCallback? onTap,
    required String icon,
    Color? colorActive,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(
          AppDimension.largeBorderRadius * 10,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: InkWell(
            onTap: onTap,
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
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  colorActive ?? AppColors.secondBlackText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Obx(
        () => Stack(
          children: [
            /// Avatar
            SizedBox(
              width: screenSize.width,
              height: 282,
              child: Image.network(
                controller.news.value?.avatar ?? "",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (ct, w, e) {
                  if (e == null) return w;

                  return Container(
                    width: 80,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.pink600.withOpacity(0.2),
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

            /// Content
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBarWidget(
                backgroundColor: Colors.transparent,
                heightAppBar: 40,
                leadingWidth: 56,
                leading: Container(
                  margin: const EdgeInsets.only(left: AppDimension.mediumSpace),
                  child: _buildIcSVGButton(
                    onTap: () => Get.back(result: true),
                    icon: AppPaths.icArrowLeft,
                  ),
                ),
                titleName: "",
                actions: [
                  _buildIcSVGButton(
                    onTap: () async => await controller.likePost(),
                    icon: controller.news.value != null &&
                            controller.news.value!.isFavorite
                        ? AppPaths.icLikeActive
                        : AppPaths.icLike,
                    colorActive: controller.news.value != null &&
                            controller.news.value!.isFavorite
                        ? AppColors.redE54E4E
                        : null,
                  ),
                  const SizedBox(width: AppDimension.smallSpace),
                  _buildIcSVGButton(
                    onTap: () async => await controller.shareNews(),
                    icon: AppPaths.icShare,
                  ),
                  const SizedBox(width: AppDimension.mediumSpace),
                ],
              ),
              body: SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.7,
                  margin: EdgeInsets.only(top: screenSize.height * 0.3),
                  padding: const EdgeInsets.all(AppDimension.mediumSpace),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        (AppDimension.largeBorderRadius + 4) * 2,
                      ),
                      topRight: Radius.circular(
                        (AppDimension.largeBorderRadius + 4) * 2,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Date
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.brownA57B1E,
                                AppColors.brown723F00,
                                AppColors.brownCFA751,
                                AppColors.brownA27D27,
                                AppColors.brown8E6307,
                                AppColors.brown9A7014,
                              ],
                            ).createShader(bounds);
                          },
                          child: TextWidget(
                            text: controller.news.value?.created != null
                                ? DateFormatUtil.parseToString(
                                    controller.news.value!.created!,
                                  )
                                : S.current.notAvailable,
                            fontSize: AppDimension.largeFontSize,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimension.smallSpace,
                        ),

                        /// Title
                        TextWidget(
                          text: controller.news.value?.title ??
                              S.current.notAvailable,
                          fontSize: AppDimension.extraLargeFontSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.eleventBlackText,
                        ),
                        const SizedBox(
                          height: AppDimension.smallSpace / 2,
                        ),

                        /// Content HTML
                        HtmlWidget(controller.news.value?.content ?? ""),
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
