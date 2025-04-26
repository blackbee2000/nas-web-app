import 'package:camerakit_flutter/lens_model.dart';
import 'package:get/get.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class LensListController extends BaseController {
  final lens = <Lens>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is List<Lens>) {
      lens.value = Get.arguments;
    }
    super.onInit();
  }

  void onTapItemLens({required Lens lens}) {
    Get.back(result: {'lensId': lens.id ?? "", 'groupId': lens.groupId ?? ""});
  }
}
