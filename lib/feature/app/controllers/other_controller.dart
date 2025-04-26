import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class CategoryItem {
  final String title;
  final String icon;
  final String route;

  CategoryItem({required this.title, required this.icon, required this.route});
}

class OtherController extends BaseController {
  late UserRepository _userRepository;
  final Rxn<UserRegisterEntity> user = Rxn();

  @override
  void onInit() async {
    _userRepository = Get.find();
    await getUser();
    super.onInit();
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

  Future<void> onSignOut() async {
    await StorageUtil.instance.clearAllStorageExceptValue();
    Get.offAllNamed(AppRoutes.optionLoginRegister);
  }

  Future<void> viewAccountInformation() async {
    final result = await Get.toNamed(AppRoutes.accountInformationScreen);

    if (result == null) return;
    if (result is! bool) return;

    if (result) {
      await getUser();
    }
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
