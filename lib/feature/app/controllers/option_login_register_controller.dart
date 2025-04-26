import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class OptionLoginRegisterController extends BaseController {
  @override
  void onInit() async {
    /// Write intro
    await StorageUtil.instance.writeIntro();
    super.onInit();
  }
}
