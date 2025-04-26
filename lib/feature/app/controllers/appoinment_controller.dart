import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentController extends BaseController {
  final currentTab = 0.obs;
  final tabs = <String>[
    S.current.appointment,
    S.current.history,
  ];
  late PageController pageController;

  @override
  void onInit() async {
    pageController = PageController(initialPage: currentTab.value);
    super.onInit();
  }

  void onChangeTab(int value) {
    currentTab.value = value;
    pageController.jumpToPage(value);
  }

  void openOptionBooking() {
    showBaseBottomSheet(
      widget: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
            AppDimension.mediumSpace,
            AppDimension.mediumSpace,
            AppDimension.mediumSpace,
            max(AppDimension.mediumSpace,
                MediaQuery.of(Get.context!).viewPadding.bottom)),
        decoration: BoxDecoration(
          color: AppColors.secondGreyBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimension.largeBorderRadius + 4),
            topRight: Radius.circular(AppDimension.largeBorderRadius + 4),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: S.current.appoinmentBook,
              fontSize: AppDimension.extraLargeFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.twelveBlackText,
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimension.mediumSpace),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppDimension.largeBorderRadius + 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 0),
                    blurRadius: 24,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: S.current.bookingFollowStore,
                    fontWeight: FontWeight.w700,
                    color: AppColors.thirdteenBlackText,
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      AppPaths.icArrowLeft,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        AppColors.thirdteenBlackText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimension.mediumSpace),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppDimension.largeBorderRadius + 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 0),
                    blurRadius: 24,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: S.current.bookingFollowTechnician,
                    fontWeight: FontWeight.w700,
                    color: AppColors.thirdteenBlackText,
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      AppPaths.icArrowLeft,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        AppColors.thirdteenBlackText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<String?> createCalendarEvent() async {
  //   final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

  //   // Yêu cầu quyền truy cập lịch
  //   var permissionsGranted = await deviceCalendarPlugin.requestPermissions();
  //   if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
  //     showErrorDialog(content: S.current.noPermissionCalendar);
  //     return null;
  //   }

  //   // Lấy danh sách lịch có sẵn
  //   var calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
  //   if (calendarsResult.data == null || calendarsResult.data!.isEmpty) {
  //     showErrorDialog(content: S.current.notExistCalendar);
  //     return null;
  //   }

  //   // Chọn Google Calendar (hoặc mặc định là lịch đầu tiên)
  //   var calendar = calendarsResult.data!.firstWhere(
  //     (cal) => cal.isReadOnly == false, // Chỉ chọn lịch có thể ghi dữ liệu
  //     orElse: () => calendarsResult.data!.first,
  //   );
  //   final date = dateSelected.value ?? DateTime.now();
  //   final time = timeSelected.value ?? const Duration();
  //   final dateTime = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     time.inHours,
  //     time.inMinutes.remainder(60),
  //   );
  //   final tz.TZDateTime startTz = tz.TZDateTime.from(
  //     dateTime,
  //     tz.local,
  //   );
  //   final tz.TZDateTime endTz = tz.TZDateTime.from(
  //     dateTime.add(const Duration(hours: 1)),
  //     tz.local,
  //   );

  //   // Tạo sự kiện mới
  //   var event = Event(
  //     calendar.id,
  //     title:
  //         "Dịch vụ nail: ${store.value?.storeName ?? S.current.notAvailable}",
  //     start: startTz,
  //     end: endTz,
  //     location:
  //         "Kỹ thuật viên: ${technician.value?.technicianName ?? S.current.notAvailable}",
  //     reminders: [
  //       Reminder(minutes: 10),
  //       Reminder(minutes: 30),
  //       Reminder(minutes: 60),
  //       Reminder(minutes: 120),
  //     ],
  //   );

  //   // Lưu sự kiện vào lịch
  //   var result = await deviceCalendarPlugin.createOrUpdateEvent(event);
  //   if (result!.isSuccess && result.data != null) {
  //     return result.data;
  //   } else {
  //     return null;
  //   }
  // }
}
