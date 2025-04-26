import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/generated/l10n.dart';

class VerifyOtpController extends BaseController {
  final isActiveButton = false.obs;
  final otpCode = TextEditingController();
  final focusNode = FocusNode();
  final previousRoute = ''.obs;

  @override
  void onInit() {
    previousRoute.value = Get.previousRoute;
    super.onInit();
  }

  void onChangeCode(String code) {
    otpCode.text = code;

    if (otpCode.text.length == 6) {
      isActiveButton.value = true;
      return;
    }

    isActiveButton.value = false;
  }

  void onVerify() {
    showLoadingLottie(
      text: S.current.verifying,
      routeSettings: Get.previousRoute,
    );

    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      Get.back();

      if (previousRoute.value == AppRoutes.registerScreen) {
        Get.toNamed(AppRoutes.setupAccount);
        return;
      }

      if (previousRoute.value == AppRoutes.forgotPassword) {
        Get.toNamed(AppRoutes.resetPassword);
        return;
      }
    });
  }
}
