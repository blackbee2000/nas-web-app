import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/enums/sex_type.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/widgets/date_select_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class AccountInformationController extends BaseController {
  late UserRepository _userRepository;
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final birthday = DateTime.now().obs;
  final birthdayController = TextEditingController(
    text: DateFormatUtil.parseToString(
      DateTime.now(),
    ),
  );
  final Rxn<SexType> sex = Rxn();
  final address = TextEditingController();
  final formSaveKey = GlobalKey<FormState>();
  final avatar = ''.obs;
  final Rxn<UserRegisterEntity> user = Rxn();

  @override
  void onInit() async {
    _userRepository = Get.find();
    await getUser();
    await mappingData();
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

  Future<void> mappingData() async {
    /// Mapping
    avatar.value = user.value?.avatar ?? '';
    fullName.text = user.value?.fullName ?? '';
    phoneNumber.text = user.value?.phone ?? '';
    email.text = user.value?.email ?? '';
    birthday.value = user.value?.dateOfBirth != null
        ? user.value!.dateOfBirth!
        : DateTime.now();
    birthdayController.text = DateFormatUtil.parseToString(birthday.value);
    sex.value = SexType.mapping(user.value?.gender ?? 0);
    address.text = user.value?.street ?? '';
  }

  Future<void> onSave() async {
    if (!formSaveKey.currentState!.validate()) return;

    showLoading();
    final result = await _userRepository.editUser(
      id: user.value!.id,
      gender: sex.value!.code,
      phone: phoneNumber.text,
      dateOfBirth: birthday.value,
      fullname: fullName.text,
      street: address.text,
      avatar: File(avatar.value).existsSync() ? File(avatar.value) : null,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    showSuccessToast(
      message: '${S.current.saveInfor} ${S.current.success.toLowerCase()}',
    );

    Get.back<bool>(result: true);
  }

  Future<void> onOpenDateSelectWidget() async {
    final date = await showBaseBottomSheet(
      widget: DateSelectWidget(
        startDate: birthday.value,
        onSubmit: (selectedDate, selectedRange) {
          if (selectedDate != null) {
            Get.back(result: selectedDate);
          }
        },
      ),
    );

    if (date is! DateTime) return;
    birthday.value = date;
    birthdayController.text = DateFormatUtil.parseToString(birthday.value);
  }

  Future<void> takePhoto({required ImageSource source}) async {
    Get.back();

    showLoading();
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) {
      hideLoading();
      showErrorDialog(content: S.current.errorHappen);
      return;
    }

    hideLoading();
    avatar.value = image.path;
  }

  Future<void> openOptionAvatar() async {
    showBaseBottomSheet(
      widget: Container(
        width: MediaQuery.of(Get.context!).size.width,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(Get.context!).viewPadding.bottom,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimension.largeBorderRadius),
            topRight: Radius.circular(AppDimension.largeBorderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async => await takePhoto(source: ImageSource.camera),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 22,
                    color: AppColors.blackText,
                  ),
                  const SizedBox(width: AppDimension.mediumBorderRadius),
                  TextWidget(text: S.current.camera),
                ],
              ),
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            GestureDetector(
              onTap: () async => await takePhoto(source: ImageSource.gallery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 22,
                    color: AppColors.blackText,
                  ),
                  const SizedBox(width: AppDimension.mediumBorderRadius),
                  TextWidget(text: S.current.gallery),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
