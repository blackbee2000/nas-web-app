import 'package:get/get.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/services/base_service.dart';
import 'package:nasmobile/core/utils/storage_util.dart';

class AppService extends BaseService {
  final Rx<LanguageMode> language = Rx(LanguageMode.vietnamese);

  @override
  void onInit() async {
    await checkLanguage();
    super.onInit();
  }

  Future<void> checkLanguage() async {
    final LanguageMode mode = await StorageUtil.instance.readLanguage();

    if (language.value == mode) {
      return;
    }

    await Get.updateLocale(mode.locale);
    language.value = mode;
  }

  Future<void> onChangeLanguage({required LanguageMode mode}) async {
    await StorageUtil.instance.writeLanguage(mode);
    await Get.updateLocale(mode.locale);
    language.value = mode;
  }
}
