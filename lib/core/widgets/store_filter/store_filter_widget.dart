import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/store_filter/store_filter_controller.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class StoreFilterWidget extends StatelessWidget {
  final StoreFilterController storeFilterController;
  const StoreFilterWidget({super.key, required this.storeFilterController});

  Widget _buildTitle({required String title}) => TextWidget(
        text: title,
        fontWeight: FontWeight.w700,
        color: AppColors.greyText,
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreFilterController>(
      init: storeFilterController,
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(maxHeight: Get.height * 0.8),
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(context).viewPadding.bottom,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimension.largeBorderRadius),
            topRight: Radius.circular(AppDimension.largeBorderRadius),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Container(
                alignment: Alignment.center,
                child: TextWidget(
                  text: S.current.filter.toUpperCase(),
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDimension.largeSpace),

              /// Body
              /// Rating
              _buildTitle(title: S.current.rating),
              const SizedBox(height: AppDimension.mediumSpace),
              Obx(
                () => RatingStars(
                  value: controller.rating.value,
                  starSize: 30,
                  starColor: AppColors.pink600,
                  starOffColor: AppColors.greyText,
                  valueLabelVisibility: false,
                  onValueChanged: (value) {
                    controller.rating.value = value;
                  },
                ),
              ),
              const SizedBox(height: AppDimension.largeSpace),
              Row(
                children: [
                  Expanded(
                    child: RoundedButtonWidget(
                      text: S.current.close,
                      borderColor: AppColors.greyText,
                      backgroundColor: Colors.white,
                      textColor: AppColors.greyText,
                      onPressed: Get.back,
                    ),
                  ),
                  const SizedBox(width: AppDimension.smallSpace),
                  Expanded(
                    child: RoundedButtonWidget(
                      text: S.current.confirm,
                      onPressed: controller.onConfirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
