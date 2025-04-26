import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/enums/status_booking.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/utils/launcher_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_detail_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentDetailView extends BaseView<AppoinmentDetailController> {
  const AppoinmentDetailView({super.key});

  Widget _builtTitle({required String title}) => TextWidget(
        text: title,
        fontWeight: FontWeight.w700,
        fontSize: AppDimension.largeFontSize,
      );

  Widget _builtItemInfo({required String title, required String value}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: TextWidget(
              text: title,
            ),
          ),
          const SizedBox(width: AppDimension.smallSpace),
          Expanded(
            child: TextWidget(
              text: value,
              textAlign: TextAlign.right,
              maxlines: 10,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.appoinmentDetail),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(context).viewPadding.bottom,
          ),
        ),
        child: RoundedButtonWidget(
          width: double.infinity,
          onPressed: () {
            controller.showErrorDialog(
              isCancelButton: true,
              content: S.current.confirmCancelBooking,
              textButton: S.current.confirm,
              onTapCancel: Get.back,
              textButtonCancel: S.current.close,
              onTap: () async => await controller.cancelBooking(),
            );
          },
          text: S.current.cancelAppoinment,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                /// Appoinment
                controller.booking.value != null
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimension.mediumSpace),
                        margin: const EdgeInsets.only(
                          bottom: AppDimension.mediumSpace,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greyBackgroundSecond,
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _builtTitle(title: S.current.infoAppoinment),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.service,
                              value: 'Nails',
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.time,
                              value: controller.booking.value!.bookingTime !=
                                          null &&
                                      controller.booking.value!.bookingDate !=
                                          null
                                  ? "${controller.booking.value!.bookingTime!.split(":").sublist(0, 2).join(":")} ${DateFormat(DateFormatUtil.kDDMMYYYY).format(
                                      controller.booking.value!.bookingDate!,
                                    )}"
                                  : S.current.notAvailable,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: TextWidget(
                                    text: S.current.status,
                                  ),
                                ),
                                const SizedBox(width: AppDimension.smallSpace),
                                Expanded(
                                  child: TextWidget(
                                    text: StatusBooking.mapping(controller
                                                .booking.value!.status)
                                            ?.nameVN ??
                                        S.current.notAvailable,
                                    color: StatusBooking.mapping(controller
                                                .booking.value!.status)
                                            ?.color ??
                                        AppColors.blackText,
                                    textAlign: TextAlign.right,
                                    maxlines: 10,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.note,
                              value: controller.booking.value?.note ??
                                  S.current.notAvailable,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),

                /// Store
                controller.booking.value != null
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimension.mediumSpace),
                        margin: const EdgeInsets.only(
                          bottom: AppDimension.mediumSpace,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greyBackgroundSecond,
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _builtTitle(title: S.current.infoStore),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.store,
                              value:
                                  controller.booking.value!.store?.storeName ??
                                      S.current.notAvailable,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            GestureDetector(
                              onTap: () => LauncherUtil.launchCall(""),
                              child: _builtItemInfo(
                                title: S.current.hotline,
                                value:
                                    controller.booking.value!.store?.hotline ??
                                        S.current.notAvailable,
                              ),
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.address,
                              value: controller
                                      .booking.value!.store?.addressStore ??
                                  S.current.notAvailable,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),

                /// Technician
                controller.booking.value != null
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimension.mediumSpace),
                        margin: const EdgeInsets.only(
                          bottom: AppDimension.mediumSpace,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greyBackgroundSecond,
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _builtTitle(title: S.current.infoTechnician),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.technician,
                              value: controller.booking.value!.technician
                                      ?.technicianName ??
                                  S.current.notAvailable,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            GestureDetector(
                              onTap: () => LauncherUtil.launchCall(""),
                              child: _builtItemInfo(
                                title: S.current.phoneNumber,
                                value: controller
                                        .booking.value!.technician?.phone ??
                                    S.current.notAvailable,
                              ),
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.address,
                              value: controller.booking.value!.technician
                                      ?.technicianAddress ??
                                  S.current.notAvailable,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),

                /// Info booker
                controller.booking.value != null
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimension.mediumSpace),
                        decoration: BoxDecoration(
                          color: AppColors.greyBackgroundSecond,
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _builtTitle(title: S.current.inforBooker),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.fullName,
                              value: controller.booking.value?.fullName ??
                                  S.current.notAvailable,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.email,
                              value: controller.booking.value?.email ??
                                  S.current.notAvailable,
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            GestureDetector(
                              onTap: () => LauncherUtil.launchCall(""),
                              child: _builtItemInfo(
                                title: S.current.phoneNumber,
                                value: controller.booking.value?.phone ??
                                    S.current.notAvailable,
                              ),
                            ),
                            const SizedBox(height: AppDimension.smallSpace),
                            _builtItemInfo(
                              title: S.current.address,
                              value: controller.booking.value?.address ??
                                  S.current.notAvailable,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
