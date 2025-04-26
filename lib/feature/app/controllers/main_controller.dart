import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/banner_entity.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/feature/domain/repositories/store_repository.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';

class MainController extends BaseController {
  late UserRepository _userRepository;
  late StoreRepository _storeRepository;
  late HistoryBookRepository _historyBookRepository;
  final indexCurrentBanner = 0.obs;
  final stores = <StoreEntity>[].obs;
  final _pageNumber = 1.obs;
  final _pageSize = 5;
  final bookingList = <BookingEntity>[].obs;
  final Rxn<UserRegisterEntity> user = Rxn();
  final banners = <BannerEntity>[].obs;
  final search = TextEditingController();

  @override
  void onInit() async {
    _userRepository = Get.find();
    _storeRepository = Get.find();
    _historyBookRepository = Get.find();
    await init();
    super.onInit();
  }

  Future<void> init() async {
    await getUser();
    await getListBooking();
    await getStores();
    await getBanners();
  }

  Future<void> getUser() async {
    showLoading();
    final result = await _userRepository.getProfile();
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    user.value = result.asRight();
  }

  Future<void> onViewDetail({required StoreEntity store}) async {
    final result = await Get.toNamed(AppRoutes.storeDetail, arguments: store);

    if (result == null || result is! bool) return;

    if (result) {
      final result = await _storeRepository.getListStore(
        pageNumber: _pageNumber.value,
        pageSize: _pageSize,
      );

      if (result.isLeft()) {
        showErrorDialog(content: result.asLeft().message);
        return;
      }

      stores.value = result.asRight().items;
      stores.refresh();
    }
  }

  void goDetail({required BookingEntity booking}) {
    Get.toNamed(AppRoutes.appoinmentDetail, arguments: booking);
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
  }

  Future<void> getStores() async {
    showLoading();
    final result = await _storeRepository.getListStore(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    stores.value = result.asRight().items;
  }

  Future<void> likeStore({required StoreEntity store}) async {
    final result = await _storeRepository.likeStore(
      id: store.id,
      isFavorite: !store.isFavorite,
    );

    if (result.asRight()) {
      for (int i = 0; i < stores.length; i++) {
        if (store.id == stores[i].id) {
          stores[i] = stores[i].copyWith(isFavorite: !store.isFavorite);
        }
      }

      stores.refresh();
    }
  }

  Future<void> getBanners() async {
    showLoading();
    final result = await _userRepository.getListBanner();
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    banners.value = result.asRight().items;
  }
}
