import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class TakePhoto360Controller extends BaseController {
  CameraController? cameraController;
  final isShowCamera = false.obs;
  final images = <File>[].obs;

  @override
  void onInit() async {
    await handlePermisson();
    super.onInit();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> handlePermisson() async {
    /// Camera
    final requestCamera = await Permission.camera.request();
    if (!requestCamera.isGranted) {
      showErrorDialog(
        content: S.current.pleasePermissonCamera,
        onTap: () {
          openAppSettings();
        },
      );
    }

    await _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final cameraBack = cameras.firstWhere(
      (e) => e.lensDirection == CameraLensDirection.back,
    );
    cameraController = CameraController(cameraBack, ResolutionPreset.medium);
    await cameraController?.initialize().then((_) {}).catchError((e) {
      showErrorDialog(content: e);
    });

    isShowCamera.value =
        cameraController != null && cameraController!.value.isInitialized;
  }

  /// Take photo
  Future<void> takePhoto() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result == null) return;
    images.add(File(result.path));
  }
}
