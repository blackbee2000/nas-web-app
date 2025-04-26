import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/form_rating/form_rating_controller.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/core/widgets/validator/validator.dart';
import 'package:nasmobile/generated/l10n.dart';

class FormRatingWidget extends StatelessWidget {
  final FormRatingController formRatingController;
  const FormRatingWidget({super.key, required this.formRatingController});

  Widget _buildTitle({required String title}) => TextWidget(
        text: title,
        fontWeight: FontWeight.w700,
        color: AppColors.greyText,
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormRatingController>(
      init: formRatingController,
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
                  text: S.current.rating.toUpperCase(),
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDimension.largeSpace),

              /// Body
              /// Rating store
              _buildTitle(
                title: '${S.current.rating} ${S.current.store.toLowerCase()}',
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimension.mediumBorderRadius,
                    ),
                    child: Image.network(
                      "https://2fdecor.com/wp-content/uploads/2022/07/z3594499415978_288e8f9d8802425e34c378c4c0860187-1.jpg",
                      width: 150,
                      height: 70,
                      fit: BoxFit.cover,
                      loadingBuilder: (ct, w, e) {
                        if (e == null) return w;

                        return Container(
                          width: 150,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.pink600.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              AppDimension.mediumBorderRadius,
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
                        width: 150,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColors.errorColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppDimension.mediumBorderRadius,
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
                  const SizedBox(width: AppDimension.mediumSpace),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Tên cửa hàng',
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimension.largeFontSize,
                        ),
                        SizedBox(height: AppDimension.smallSpace / 3),
                        TextWidget(
                          text: 'Địa chỉ cửa hàng',
                          maxlines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              const SizedBox(height: AppDimension.mediumSpace),

              /// Note
              TextFormFieldWidget(
                controller: controller.note,
                hintText: S.current.enter_input(
                  S.current.note.toLowerCase(),
                ),
                maxLines: 3,
                validator: RequiredValidator(
                  error: S.current.required_field(S.current.note),
                ).call,
              ),
              const SizedBox(height: AppDimension.largeSpace),

              /// Rating
              _buildTitle(
                title:
                    '${S.current.rating} ${S.current.technician.toLowerCase()}',
              ),
              const SizedBox(height: AppDimension.smallSpace),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Tên kỹ thuật viên',
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimension.largeFontSize,
                  ),
                  SizedBox(height: AppDimension.smallSpace / 3),
                  TextWidget(
                    text: '0329011888',
                    maxlines: 3,
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              Obx(
                () => RatingStars(
                  value: controller.technicianRating.value,
                  starSize: 30,
                  starColor: AppColors.pink600,
                  starOffColor: AppColors.greyText,
                  valueLabelVisibility: false,
                  onValueChanged: (value) {
                    controller.technicianRating.value = value;
                  },
                ),
              ),
              const SizedBox(height: AppDimension.mediumSpace),

              /// Note
              TextFormFieldWidget(
                controller: controller.noteTechnician,
                hintText: S.current.enter_input(
                  S.current.note.toLowerCase(),
                ),
                maxLines: 3,
                validator: RequiredValidator(
                  error: S.current.required_field(S.current.note),
                ).call,
              ),
              const SizedBox(height: AppDimension.largeSpace),
              Row(
                children: [
                  Obx(
                    () => FlutterSwitch(
                      width: 55,
                      height: 30,
                      toggleSize: 28,
                      padding: 2.0,
                      inactiveColor: AppColors.greyText,
                      activeColor: AppColors.pink600,
                      value: controller.isPrivate.value,
                      onToggle: (value) {
                        controller.isPrivate.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimension.smallSpace),
                  TextWidget(
                    text: S.current.sendRatingPrivate,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimension.largeFontSize,
                  ),
                ],
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
