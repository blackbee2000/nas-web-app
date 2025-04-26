import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/enums/status_booking.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/history_appoinment_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class HistoryAppoinmentView extends BaseView<HistoryAppoinmentController> {
  const HistoryAppoinmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleName: S.current.history,
        actions: [
          IconButton(
            onPressed: () => controller.showAppInprogress(),
            icon: SvgPicture.asset(
              AppPaths.icFilter,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.blackText,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
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
          () => NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.atEdge) {
                  bool isTop = notification.metrics.pixels == 0;
                  if (!isTop &&
                      controller.bookingList.length <
                          controller.totalCount.value) {
                    controller.loadMoreBooking();
                  }
                }
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async => await controller.getListBooking(),
              child: controller.bookingList.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.bookingList.length,
                      itemBuilder: (ct, i) {
                        final item = controller.bookingList[i];
                        return GestureDetector(
                          onTap: () => controller.goDetail(booking: item),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              bottom: AppDimension.smallSpace,
                            ),
                            child: Slidable(
                              startActionPane: StatusBooking.mapping(
                                          item.status) ==
                                      StatusBooking.completed
                                  ? ActionPane(
                                      motion: const BehindMotion(),
                                      extentRatio: 2 / 5,
                                      dragDismissible: false,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) =>
                                              controller.showFormRating(
                                            item: StoreEntity(),
                                          ),
                                          backgroundColor:
                                              AppColors.successColor,
                                          icon: CupertinoIcons.checkmark_alt,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(
                                              AppDimension.mediumBorderRadius,
                                            ),
                                            bottomLeft: Radius.circular(
                                              AppDimension.mediumBorderRadius,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                              endActionPane: StatusBooking.mapping(
                                          item.status) ==
                                      StatusBooking.pending
                                  ? ActionPane(
                                      motion: const BehindMotion(),
                                      extentRatio: 2 / 5,
                                      dragDismissible: false,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            controller.showErrorDialog(
                                              isCancelButton: true,
                                              content: S
                                                  .current.confirmCancelBooking,
                                              textButton: S.current.confirm,
                                              onTapCancel: Get.back,
                                              textButtonCancel: S.current.close,
                                              onTap: () async =>
                                                  await controller
                                                      .cancelBooking(
                                                booking: item,
                                              ),
                                            );
                                          },
                                          backgroundColor: AppColors.errorColor,
                                          icon: CupertinoIcons.delete,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(
                                              AppDimension.mediumBorderRadius,
                                            ),
                                            bottomRight: Radius.circular(
                                              AppDimension.mediumBorderRadius,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(
                                    AppDimension.mediumSpace),
                                decoration: BoxDecoration(
                                  color: AppColors.greyBackgroundSecond,
                                  border: Border.all(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(
                                    AppDimension.mediumBorderRadius,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text: item.store?.storeName ??
                                              S.current.notAvailable,
                                          fontSize: AppDimension.largeFontSize,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              color: AppColors.pink600,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width:
                                                  AppDimension.smallSpace / 2,
                                            ),
                                            TextWidget(
                                              text: item.bookingDate != null &&
                                                      item.bookingTime != null
                                                  ? "${item.bookingTime!.split(":").sublist(0, 2).join(":")} ${DateFormat(DateFormatUtil.kDDMMYYYY).format(
                                                      item.bookingDate!,
                                                    )}"
                                                  : S.current.notAvailable,
                                              fontSize:
                                                  AppDimension.smallFontSize,
                                              color: AppColors.greyText,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: AppDimension.smallSpace / 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text:
                                              item.technician?.technicianName ??
                                                  S.current.notAvailable,
                                        ),
                                        TextWidget(
                                          text: StatusBooking.mapping(
                                                item.status,
                                              )?.nameVN ??
                                              S.current.notAvailable,
                                          fontSize: AppDimension.smallFontSize,
                                          color: StatusBooking.mapping(
                                                item.status,
                                              )?.color ??
                                              AppColors.blackText,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: NoDataWidget(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
