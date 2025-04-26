import 'package:camerakit_flutter/camerakit_flutter.dart';
import 'package:camerakit_flutter/lens_model.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class TryNailsController extends BaseController with CameraKitFlutterEvents {
  final filePath = ''.obs;
  final fileType = ''.obs;
  final lensList = <Lens>[];
  CameraKitFlutterImpl? cameraKitFlutterImpl;

  @override
  void onInit() async {
    cameraKitFlutterImpl = CameraKitFlutterImpl(
      cameraKitFlutterEvents: this,
    );

    super.onInit();
  }

  @override
  void onCameraKitResult(Map<dynamic, dynamic> result) {
    filePath.value = result["path"] as String;
    fileType.value = result["type"] as String;

    Get.toNamed(AppRoutes.mediaResult, arguments: {
      "filePath": filePath.value,
      "fileType": fileType.value,
    });
  }

  @override
  void receivedLenses(List<Lens> lensList) async {
    hideLoading();
    final result = await Get.toNamed(AppRoutes.lensList, arguments: lensList);

    if (result == null || result is! Map) return;

    LogUtil.logDebug('RESULT ====> ${result.toString()}');

    final lensId = result['lensId'] as String?;
    final groupId = result['groupId'] as String?;

    final isCheck = lensId != null &&
        lensId.isNotEmpty &&
        groupId != null &&
        groupId.isNotEmpty;
    if (isCheck) {
      cameraKitFlutterImpl?.openCameraKitWithSingleLens(
        lensId: lensId,
        groupId: groupId,
        isHideCloseButton: false,
      );
    }
  }

  Future<void> initCameraKit() async {
    try {
      await cameraKitFlutterImpl?.openCameraKit(
        groupIds: AppUrl.groupIdList,
        isHideCloseButton: false,
      );
    } catch (e) {
      LogUtil.logDebug("Failed to open camera kit ===> $e");
    }
  }

  Future<void> getGroupLenses() async {
    showLoading();

    try {
      cameraKitFlutterImpl?.getGroupLenses(groupIds: AppUrl.groupIdList);
    } catch (e) {
      LogUtil.logDebug("Failed to open camera kit ===> $e");
    }
  }
}
