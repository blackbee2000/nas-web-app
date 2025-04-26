import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/services/app_service.dart';
import 'package:nasmobile/core/services/auth_service.dart';
import 'package:nasmobile/core/widgets/dialog_customer_widget.dart';
import 'package:nasmobile/core/widgets/snackbar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/home_controller.dart';
import 'package:nasmobile/generated/l10n.dart';

class BaseController extends GetxController {
  late AppService appService;
  late AuthService authService;

  /// For bottombar
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    appService = Get.find();
    authService = Get.find();
    // listenScroll();
    super.onInit();
  }

  void showLoading() {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
  }

  void hideLoading() {
    EasyLoading.dismiss(animation: true);
  }

  void showErrorDialog({
    String? title,
    required String content,
    VoidCallback? onTap,
    String? textButton,
    bool isCancelButton = false,
    String? textButtonCancel,
    VoidCallback? onTapCancel,
    String? icon,
    Color? backgroundColorButton,
    Color? backgroundColorButtonCancel,
    bool isGradientButton = true,
  }) {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius,
          ),
        ),
        insetPadding: EdgeInsets.zero,
        child: ErrorDialog(
          icon: icon,
          title: title ?? S.current.fail,
          content: content,
          onTap: () {
            Get.back();
            onTap?.call();
          },
          textButton: textButton ?? S.current.close,
          isCancelButton: isCancelButton,
          textButtonCancel: textButtonCancel,
          onTapCancel: () {
            Get.back();
            onTapCancel?.call();
          },
          backgroundColorButton: backgroundColorButton,
          backgroundColorButtonCancel: backgroundColorButtonCancel,
          isGradientButton: isGradientButton,
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<T?> showBaseBottomSheet<T>({
    required Widget widget,
    bool isDismissible = true,
    RouteSettings? settings,
  }) =>
      Get.bottomSheet<T>(
        widget,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimension.largeBorderRadius),
          ),
        ),
        enterBottomSheetDuration: const Duration(milliseconds: 300),
        exitBottomSheetDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        isDismissible: isDismissible,
        settings: settings,
      );

  void showErrorToast({required String message}) {
    final snackBar = SnackbarWidget.failed(
      screenSize: Get.size,
      title: S.current.fail,
      message: message,
      onClose: ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void showSuccessToast({required String message}) {
    final snackBar = SnackbarWidget.success(
      screenSize: Get.size,
      title: S.current.success,
      message: message,
      onClose: ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void listenScroll() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        Get.find<HomeController>().isVisible.value = false;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        Get.find<HomeController>().isVisible.value = true;
      }
    });
  }

  bool hasUpperCase(String input) {
    return input.contains(RegExp(r'[A-Z]'));
  }

  bool hasLowerCase(String input) {
    return input.contains(RegExp(r'[a-z]'));
  }

  bool hasSpecialCharacter(String input) {
    return input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void showAppInprogress() {
    showErrorDialog(content: S.current.appInProgress);
  }

  void showLoadingLottie({
    required String text,
    required String routeSettings,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius + 4,
          ),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: (Get.width - 200) / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius + 4,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 180,
              height: 150,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.largeSpace,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                  topRight: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    AppPaths.lottieLoading,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: AppDimension.largeSpace),
                  TextWidget(
                    text: text,
                    fontSize: AppDimension.largeFontSize,
                    color: Colors.white,
                    maxlines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.1),
      routeSettings: RouteSettings(name: routeSettings),
    );
  }

  void showSuccessLottie({
    required String text,
    required String routeSettings,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius + 4,
          ),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: (Get.width - 200) / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius + 4,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 180,
              height: 140,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.largeSpace,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                  topRight: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    AppPaths.lottieSuccessfully,
                    width: 120,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                  TextWidget(
                    text: text,
                    fontSize: AppDimension.largeFontSize,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.1),
      routeSettings: RouteSettings(name: routeSettings),
    );
  }
}
