import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class View360StoreController extends BaseController {
  final imageDemo = AppPaths.demo360.obs;
  final isCamera = false.obs;
  final imgUrl = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is String) {
      imgUrl.value = Get.arguments;
      LogUtil.logDebug('DATA ===> ${imgUrl.value}');
    }
    super.onInit();
  }
}
