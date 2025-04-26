import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/app/controllers/main_controller.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';

class NavigatorBottomItem {
  final String title;
  final String icon;
  final String activeIcon;

  NavigatorBottomItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

class HomeController extends BaseController {
  late UserRepository _userRepository;
  late PageController pageController;
  final currentPage = 0.obs;
  final isVisible = true.obs;
  final Rxn<UserRegisterEntity> user = Rxn();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() async {
    _userRepository = Get.find();
    pageController = PageController(initialPage: currentPage.value);
    await getUser();
    super.onInit();
  }

  void onChangeNavigatorBottom(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  Future<void> gotoBooking() async {
    final result = await Get.toNamed(AppRoutes.appoinmentBook);
    if (result == null || result is! bool) return;

    if (result) {
      await Get.find<MainController>().getListBooking();
    }
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

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Future<void> onSignOut() async {
    await StorageUtil.instance.clearAllStorageExceptValue();
    Get.offAllNamed(AppRoutes.optionLoginRegister);
  }
}
