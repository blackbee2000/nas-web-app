import 'package:get/get.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class SettingController extends BaseController {
  final isFaceID = false.obs;

  void onChangeFaceID(bool value) {
    isFaceID.value = value;

    showAppInprogress();
  }
}
