import 'dart:io';

import 'package:get/get.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:video_player/video_player.dart';

class MediaResultController extends BaseController {
  final filePath = ''.obs;
  final fileType = ''.obs;
  VideoPlayerController? videoController;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    if (Get.arguments == null) return;

    filePath.value = Get.arguments['filePath'];
    fileType.value = Get.arguments['fileType'];
    videoController = VideoPlayerController.file(File(filePath.value))
      ..initialize().then((_) {});
  }

  void listenerVideo() {
    videoController?.addListener(() {
      if (!videoController!.value.isPlaying &&
          videoController!.value.isInitialized &&
          (videoController!.value.duration ==
              videoController!.value.position)) {
        showSuccessToast(
          message:
              "*************** video paying c o m p l e t e d *******************",
        );
      }
    });
  }
}
