import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/feature/app/controllers/take_photo_360_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class TakePhoto360View extends BaseView<TakePhoto360Controller> {
  const TakePhoto360View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleName: S.current.camera,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Container(
                  margin:
                      const EdgeInsets.only(bottom: AppDimension.mediumSpace),
                  child: controller.images.length == 3
                      ? RoundedButtonWidget(
                          onPressed: () {},
                          text: 'Tạo ảnh 360',
                        )
                      : RoundedButtonWidget(
                          onPressed: () async => await controller.takePhoto(),
                          text: S.current.camera,
                        ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.images.length,
                  itemBuilder: (ct, i) => Container(
                    width: double.infinity,
                    height: Get.height / 4,
                    margin: const EdgeInsets.only(
                      bottom: AppDimension.mediumSpace,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppDimension.mediumBorderRadius,
                      ),
                      child: Image.file(
                        controller.images[i],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (ct, o, s) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.pink600.withOpacity(0.2),
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
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // child: Obx(
        //   () => controller.isShowCamera.value
        //       ? CameraPreview(controller.cameraController!)
        //       : const Center(
        //           child: CircularProgressIndicator(),
        //         ),
        // ),
      ),
    );
  }
}
