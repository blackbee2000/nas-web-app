import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/enums/date_view_mode.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentManageController extends BaseController {
  late HistoryBookRepository _historyBookRepository;
  final evenController = EventController<BookingEntity>().obs;
  final eventData = <CalendarEventData<BookingEntity>>[].obs;
  final indexCurrentView = DateViewMode.date.obs;

  @override
  void onInit() async {
    _historyBookRepository = Get.find();
    await initMapping();
    super.onInit();
  }

  Future<void> initMapping() async {
    showLoading();

    final result = await _historyBookRepository.getListBooking(
      pageNumber: 1,
      pageSize: 100,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    final data = result.asRight().items;

    for (var e in data) {
      final date = e.bookingDate ?? DateTime.now();
      final time = e.bookingTime?.split(":") ?? [];
      eventData.add(
        CalendarEventData<BookingEntity>(
          date: date,
          title:
              '${S.current.store}: ${e.store?.storeName ?? S.current.notAvailable}',
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          description:
              "${S.current.technician}: ${e.technician?.technicianName ?? S.current.notAvailable} - ${e.technician?.phone ?? S.current.notAvailable}",
          descriptionStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          color: AppColors.pink600,
          startTime: DateTime(
            date.year,
            date.month,
            date.day,
            int.parse(time.first),
            int.parse(time[1]),
          ),
          endTime: DateTime(
            date.year,
            date.month,
            date.day,
            int.parse(time.first),
            int.parse(time[1]),
          ).add(const Duration(hours: 1)),
          event: e,
        ),
      );
    }

    evenController.value.addAll(eventData);
  }

  void onTapSelectOptionModeView({required DateViewMode mode}) {
    indexCurrentView.value = mode;
    Get.back();
  }

  void goDetail(
    List<CalendarEventData<BookingEntity>> event,
    DateTime dateTime,
  ) {
    Get.toNamed(AppRoutes.appoinmentDetail, arguments: event.first.event);
  }
}
