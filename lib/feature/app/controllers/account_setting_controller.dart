import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class AccountSettingController extends BaseController {
  late UserRepository _userRepository;
  final Rxn<UserRegisterEntity> user = Rxn();
  @override
  void onInit() async {
    _userRepository = Get.find();
    await getUser();
    super.onInit();
  }

  void showPopupLogout() {
    showErrorDialog(
      title: S.current.signOut,
      content: S.current.youWantLogout,
      textButtonCancel: S.current.cancel,
      textButton: S.current.signOut,
      isCancelButton: true,
      onTap: () async => await onSignOut(),
    );
  }

  Future<void> onSignOut() async {
    await StorageUtil.instance.clearAllStorageExceptValue();
    Get.offAllNamed(AppRoutes.optionLoginRegister);
  }

  void showPopupDeleteAccount() {
    showErrorDialog(
      title: S.current.deleteAccount,
      content: S.current.contentDeleteAccount,
      textButtonCancel: S.current.cancel,
      textButton: S.current.delete,
      isCancelButton: true,
      isGradientButton: false,
      backgroundColorButton: AppColors.redFF4066,
      onTap: () async => await onSignOut(),
    );
  }

  Future<void> getUser() async {
    final result = await _userRepository.getProfile();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    user.value = result.asRight();
  }

  Future<void> onDeleteAccount() async {
    showLoading();
    final result = await _userRepository.editUser(
      id: user.value!.id,
      gender: user.value!.gender,
      phone: user.value?.phone ?? "",
      fullname: user.value?.fullName ?? "",
      isActive: false,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    showSuccessToast(
      message: '${S.current.deleteAccount} ${S.current.success.toLowerCase()}',
    );
    await onSignOut();
  }
}
