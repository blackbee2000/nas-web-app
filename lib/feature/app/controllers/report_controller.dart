import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class ReportController extends BaseController {
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      showAppInprogress();
    });
    super.onInit();
  }
}
