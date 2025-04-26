import 'package:get/get.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class StoreFilterController extends BaseController {
  final rating = 4.0.obs;

  void onConfirm() {
    showAppInprogress();
  }
}
