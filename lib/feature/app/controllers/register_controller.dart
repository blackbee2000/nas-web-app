import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final isLabelEmail = false.obs;
  final isActiveButton = false.obs;
  final isToggleCheck = false.obs;

  void onChangeActiveButton() {
    if (email.text.isNotEmpty && isToggleCheck.value) {
      isActiveButton.value = true;
      return;
    }

    isActiveButton.value = false;
  }

  void toggleCheck() {
    isToggleCheck.value = !isToggleCheck.value;
    onChangeActiveButton();
  }

  void onNext() {
    if (!formKey.currentState!.validate()) return;

    Get.toNamed(AppRoutes.verifyOtp);
  }
}
