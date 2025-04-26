import 'package:get/get.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      /// Check load intro
      final intro = await StorageUtil.instance.readIntro();
      if (intro == null || intro.isEmpty) {
        Get.offAllNamed(AppRoutes.intro);
        return;
      }

      /// Check token
      final token = await StorageUtil.instance.readToken();
      if (token != null) {
        Get.offAllNamed(AppRoutes.homeScreen);
        return;
      }

      Get.offAllNamed(AppRoutes.optionLoginRegister);
    });
    super.onInit();
  }
}
