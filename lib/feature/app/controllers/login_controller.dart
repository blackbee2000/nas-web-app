import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class LoginController extends BaseController {
  late UserRepository _userRepository;
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final isShowPassword = false.obs;
  final isActiveButton = false.obs;
  final isLabelEmail = false.obs;
  final isLabelPass = false.obs;
  final isToggleCheck = false.obs;

  ///Login with google, fb, apple
  final Rxn<User> userGoogle = Rxn();
  final Rxn<User> userFacebook = Rxn();

  @override
  void onInit() {
    _userRepository = Get.find();
    super.onInit();
  }

  void onChangeActiveButton() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isActiveButton.value = true;
      return;
    }

    isActiveButton.value = false;
  }

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    showLoading();
    final result = await _userRepository.login(
      password: password.text,
      email: email.text,
    );
    hideLoading();
    if (result.isLeft()) {
      if (result.asLeft().message == "Invalid email/phone or password") {
        showErrorDialog(
          title: S.current.passwordIncorrect,
          content: S.current.contentPasswordIncorrect,
          onTapCancel: Get.back,
          textButtonCancel: S.current.tryAgainst,
          textButton: S.current.reset,
          icon: AppPaths.icPassIncorrect,
          isCancelButton: true,
        );
        return;
      }
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    final data = result.asRight();
    await StorageUtil.instance.writeToken(data.jwToken ?? '');
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  /// Login with google
  Future<void> loginWithGoogle() async {
    showLoading();
    final result = await authService.signInWithGoogle();
    hideLoading();
    userGoogle.value = result;
    showSuccessToast(
      message: userGoogle.value?.email ?? S.current.notAvailable,
    );
  }

  /// Login with facebook
  Future<void> loginWithFacebook() async {
    showLoading();
    final result = await authService.signInWithFacebook();
    hideLoading();
    userFacebook.value = result;
    showSuccessToast(
      message: userFacebook.value?.email ?? S.current.notAvailable,
    );
  }

  void toggleCheck() {
    isToggleCheck.value = !isToggleCheck.value;
  }
}
