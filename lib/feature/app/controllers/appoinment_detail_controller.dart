import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class AppoinmentDetailController extends BaseController {
  late HistoryBookRepository _historyBookRepository;
  final Rxn<BookingEntity> booking = Rxn();

  @override
  void onInit() async {
    _historyBookRepository = Get.find();
    await initMapping();
    super.onInit();
  }

  Future<void> initMapping() async {
    if (Get.arguments == null || Get.arguments is! BookingEntity) return;

    showLoading();
    final result = await _historyBookRepository.getBookingDetail(
      id: (Get.arguments as BookingEntity).id,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    booking.value = result.asRight();
  }

  /// Cancel booking
  Future<void> cancelBooking() async {
    showLoading();

    final result = await _historyBookRepository.cancelBooking(
      id: booking.value!.id,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    showSuccessToast(
      message:
          "${S.current.cancelAppoinment} ${S.current.success.toLowerCase()}",
    );

    Get.back();
  }
}
