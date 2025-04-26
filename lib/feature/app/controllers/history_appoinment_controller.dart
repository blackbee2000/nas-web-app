import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/widgets/form_rating/data_form_rating.dart';
import 'package:nasmobile/core/widgets/form_rating/form_rating_controller.dart';
import 'package:nasmobile/core/widgets/form_rating/form_rating_widget.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class HistoryAppoinmentController extends BaseController {
  late HistoryBookRepository _historyBookRepository;
  final bookingList = <BookingEntity>[].obs;
  final _pageNumber = 1.obs;
  final _pageSize = 10;
  final totalCount = 0.obs;

  @override
  void onInit() async {
    _historyBookRepository = Get.find();
    await getListBooking();
    super.onInit();
  }

  Future<void> showFormRating({required StoreEntity item}) async {
    await showBaseBottomSheet(
      widget: FormRatingWidget(
        formRatingController: FormRatingController(
          dataFormRating: DataFormRating(rating: 2),
        ),
      ),
    );
  }

  /// Get list booking
  Future<void> getListBooking() async {
    showLoading();
    _pageNumber.value = 1;

    final result = await _historyBookRepository.getListBooking(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    bookingList.value = result.asRight().items;
    totalCount.value = result.asRight().totalCount;
  }

  /// Loadmore
  Future<void> loadMoreBooking() async {
    showLoading();
    _pageNumber.value += 1;

    final result = await _historyBookRepository.getListBooking(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    final moreData = result.asRight().items;

    if (moreData.isNotEmpty) {
      bookingList.addAll(moreData);
      bookingList.refresh();
    }
  }

  void goDetail({required BookingEntity booking}) {
    Get.toNamed(AppRoutes.appoinmentDetail, arguments: booking);
  }

  /// Cancel booking
  Future<void> cancelBooking({required BookingEntity booking}) async {
    showLoading();

    final result = await _historyBookRepository.cancelBooking(id: booking.id);
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    showSuccessToast(
      message:
          "${S.current.cancelAppoinment} ${S.current.success.toLowerCase()}",
    );

    await getListBooking();
  }
}
