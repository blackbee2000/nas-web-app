import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/feature/app/controllers/view_360_store_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class View360StoreView extends BaseView<View360StoreController> {
  const View360StoreView({super.key});

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
      child: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Obx(
              () => controller.imgUrl.value.isNotEmpty
                  ? PanoramaViewer(
                      animSpeed: .1,
                      sensorControl: SensorControl.orientation,
                      minZoom: 0.2,
                      zoom: 0.5,
                      child: Image.network(controller.imgUrl.value),
                    )
                  : const NoDataWidget(),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBarWidget(
              backgroundColor: Colors.transparent,
              heightAppBar: 40,
              leadingWidth: 56,
              leading: Container(
                margin: const EdgeInsets.only(left: AppDimension.mediumSpace),
                child: _buildIcSVGButton(
                  onTap: Get.back,
                  icon: AppPaths.icArrowLeft,
                ),
              ),
              titleName: "",
            ),
          ),
        ],
      ),
    );
  }
}
