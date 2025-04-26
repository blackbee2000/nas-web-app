import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/enums/date_view_mode.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_manage_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentManageView extends BaseView<AppoinmentManageController> {
  const AppoinmentManageView({super.key});

  Widget _dayView() => DayView<BookingEntity>(
        controller: controller.evenController.value,
        dateStringBuilder: (date, {secondaryDate}) => DateFormat(
          DateFormatUtil.kDDMMYYYY,
        ).format(date),
        timeStringBuilder: (date, {secondaryDate}) => DateFormat(
          DateFormatUtil.kHHmm,
        ).format(date),
        timeLineOffset: 12,
        timeLineBuilder: (date) => Padding(
          padding: const EdgeInsets.only(
            left: AppDimension.smallSpace,
          ),
          child: TextWidget(
            text: DateFormat(
              DateFormatUtil.kHHmm,
            ).format(date),
            color: AppColors.blackText,
            fontSize: AppDimension.mediumFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        eventTileBuilder: (date, events, _, s, e) => Container(
          padding: const EdgeInsets.all(AppDimension.smallSpace),
          decoration: BoxDecoration(
            color: events.first.color,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: events.first.title,
                color: Colors.white,
                fontSize: AppDimension.largeFontSize,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: AppDimension.smallSpace / 3),
              TextWidget(
                text: events.first.description ?? '',
                color: Colors.white,
              ),
            ],
          ),
        ),
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(1990),
        maxDay: DateTime(2050),
        initialDay: DateTime.now(),
        heightPerMinute: 1.1,
        onEventTap: controller.goDetail,
        onEventDoubleTap: (events, date) => LogUtil.logDebug(events),
        onEventLongTap: (events, date) => LogUtil.logDebug(events),
        onDateLongPress: (date) => LogUtil.logDebug(date),
        startHour: 0,
        endHour: 24,
        keepScrollOffset: true,
        headerStyle: const HeaderStyle(
          decoration: BoxDecoration(color: AppColors.pink600),
          leftIconConfig: IconDataConfig(color: Colors.white),
          rightIconConfig: IconDataConfig(color: Colors.white),
          headerTextStyle: TextStyle(
            color: Colors.white,
            fontSize: AppDimension.largeFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _weekView() => WeekView<BookingEntity>(
        controller: controller.evenController.value,
        timeLineOffset: 12,
        timeLineBuilder: (date) => Padding(
          padding: const EdgeInsets.only(
            left: AppDimension.smallSpace,
          ),
          child: TextWidget(
            text: DateFormat(
              DateFormatUtil.kHHmm,
            ).format(date),
            color: AppColors.blackText,
            fontSize: AppDimension.mediumFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        eventTileBuilder: (date, events, _, s, e) => Container(
          padding: const EdgeInsets.all(AppDimension.smallSpace),
          decoration: BoxDecoration(
            color: events.first.color,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: events.first.title,
                color: Colors.white,
                fontSize: AppDimension.largeFontSize,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: AppDimension.smallSpace / 3),
              TextWidget(
                text: events.first.description ?? '',
                color: Colors.white,
              ),
            ],
          ),
        ),
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(1990),
        maxDay: DateTime(2050),
        initialDay: DateTime.now(),
        heightPerMinute: 1.1,
        onEventTap: controller.goDetail,
        onEventDoubleTap: (events, date) => LogUtil.logDebug(events),
        onEventLongTap: (events, date) => LogUtil.logDebug(events),
        onDateLongPress: (date) => LogUtil.logDebug(date),
        startHour: 0,
        endHour: 24,
        keepScrollOffset: true,
        headerStringBuilder: (date, {secondaryDate}) => '${DateFormat(
          DateFormatUtil.kDDMMYYYY,
        ).format(date)} ${secondaryDate != null ? '- ${DateFormat(
            DateFormatUtil.kDDMMYYYY,
          ).format(secondaryDate)}' : ''}',
        headerStyle: const HeaderStyle(
          decoration: BoxDecoration(color: AppColors.pink600),
          leftIconConfig: IconDataConfig(color: Colors.white),
          rightIconConfig: IconDataConfig(color: Colors.white),
          headerTextStyle: TextStyle(
            color: Colors.white,
            fontSize: AppDimension.largeFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _monthView() => MonthView<BookingEntity>(
        controller: controller.evenController.value,
        cellBuilder: (date, events, _, __, ___) => events.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(AppDimension.smallSpace),
                decoration: BoxDecoration(
                  color: events.first.color,
                  borderRadius: BorderRadius.circular(
                    AppDimension.largeBorderRadius,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: events.first.title,
                      color: Colors.white,
                      fontSize: AppDimension.largeFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: AppDimension.smallSpace / 3),
                    TextWidget(
                      text: events.first.description ?? '',
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        onCellTap: controller.goDetail,
        onEventDoubleTap: (events, date) => LogUtil.logDebug(events),
        onEventLongTap: (events, date) => LogUtil.logDebug(events),
        onDateLongPress: (date) => LogUtil.logDebug(date),
        headerStringBuilder: (date, {secondaryDate}) => DateFormat(
          DateFormatUtil.kMMYYYY,
        ).format(date),
        headerStyle: const HeaderStyle(
          decoration: BoxDecoration(color: AppColors.pink600),
          leftIconConfig: IconDataConfig(color: Colors.white),
          rightIconConfig: IconDataConfig(color: Colors.white),
          headerTextStyle: TextStyle(
            color: Colors.white,
            fontSize: AppDimension.largeFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _buildOptionModeView() => Container(
        width: MediaQuery.of(Get.context!).size.width,
        constraints: BoxConstraints(maxHeight: Get.height * 0.8),
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(Get.context!).viewPadding.bottom,
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
            children: DateViewMode.values
                .asMap()
                .entries
                .map(
                  (e) => GestureDetector(
                    onTap: () => controller.onTapSelectOptionModeView(
                      mode: e.value,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: e.key == 0
                          ? const EdgeInsets.only(
                              bottom: AppDimension.mediumSpace,
                            )
                          : const EdgeInsets.symmetric(
                              vertical: AppDimension.mediumSpace,
                            ),
                      child: Center(
                        child: TextWidget(
                          text: controller.appService.language.value.locale
                                      .languageCode ==
                                  LanguageMode.vietnamese.locale.languageCode
                              ? e.value.nameVN
                              : e.value.nameEN,
                          fontWeight: FontWeight.w500,
                          fontSize: AppDimension.mediumSpace,
                          color: controller.indexCurrentView.value == e.value
                              ? AppColors.pink600
                              : AppColors.blackText,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleName: S.current.appointmentManage,
        actions: [
          IconButton(
            onPressed: () => controller.showBaseBottomSheet(
              widget: _buildOptionModeView(),
            ),
            icon: const Icon(
              Icons.change_circle_outlined,
              size: 24,
              color: AppColors.blackText,
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(
              AppRoutes.historyAppoinment,
            ),
            icon: const Icon(
              Icons.history,
              size: 24,
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Obx(
          () => IndexedStack(
            index: controller.indexCurrentView.value.code,
            children: [
              _dayView(),
              _weekView(),
              _monthView(),
            ],
          ),
        ),
      ),
    );
  }
}
