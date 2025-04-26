import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/generated/l10n.dart';

class ResetPasswordController extends BaseController {
  final password = TextEditingController();
  final showPassword = false.obs;
  final isLabelPassword = false.obs;
  final confirmPassword = TextEditingController();
  final showConfirmPassword = false.obs;
  final isLabelConfirmPassword = false.obs;
  final isActiveButton = false.obs;
  final formKey = GlobalKey<FormState>();
  final isShowRule = false.obs;
  final isGreaterThanOrEqual8 = false.obs;
  final isUpperAndLower = false.obs;
  final isHaveSpecialCharacters = false.obs;

  void onChangeActiveButton() {
    if (password.text.isNotEmpty && confirmPassword.text.isNotEmpty) {
      isActiveButton.value = true;
      return;
    }

    isActiveButton.value = false;
  }

  void onReset() {
    if (!formKey.currentState!.validate()) return;

    if (!isGreaterThanOrEqual8.value ||
        !isHaveSpecialCharacters.value ||
        !isUpperAndLower.value) {
      showErrorDialog(content: S.current.pleaseDoneRule);
      return;
    }

    showLoadingLottie(
      text: S.current.resettingPassword,
      routeSettings: Get.previousRoute,
    );
  }

  void checkRule({required String value}) {
    isShowRule.value = true;

    /// Check >= 8 characters
    if (value.length >= 8) {
      isGreaterThanOrEqual8.value = true;
    } else {
      isGreaterThanOrEqual8.value = false;
    }

    /// Check upper and lower
    if (hasUpperCase(value) && hasLowerCase(value)) {
      isUpperAndLower.value = true;
    } else {
      isUpperAndLower.value = false;
    }

    /// Check have speacial charaters
    if (hasSpecialCharacter(value)) {
      isHaveSpecialCharacters.value = true;
    } else {
      isHaveSpecialCharacters.value = false;
    }
  }
}
