import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/media_result_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:video_player/video_player.dart';

class MediaResultView extends BaseView<MediaResultController> {
  const MediaResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.result),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.filePath.value.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(
                          bottom: AppDimension.mediumSpace,
                        ),
                        child: controller.fileType.value == "video" &&
                                controller.videoController != null
                            ? Center(
                                child: AspectRatio(
                                  aspectRatio: controller
                                      .videoController!.value.aspectRatio,
                                  child: VideoPlayer(
                                    controller.videoController!,
                                  ),
                                ),
                              )
                            : controller.fileType.value == "image"
                                ? Image.network(
                                    controller.filePath.value,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (ct, w, e) {
                                      if (e == null) return w;

                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColors.pink600
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.pink600,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (ct, o, s) => Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.pink600.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.error_outline,
                                          size: 30,
                                          color: AppColors.errorColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : const NoDataWidget(),
                      )
                    : const NoDataWidget(),
              ),
              controller.filePath.value.isNotEmpty &&
                      controller.fileType.value == "video"
                  ? RoundedButtonWidget(text: S.current.view)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
