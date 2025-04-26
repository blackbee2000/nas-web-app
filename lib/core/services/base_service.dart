import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/widgets/dialog_customer_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class BaseService extends GetxService {
  void showErrorDialog({required String content, VoidCallback? onTap}) {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius,
          ),
        ),
        insetPadding: EdgeInsets.zero,
        child: ErrorDialog(
          title: S.current.fail,
          textButton: S.current.close,
          content: content,
          onTap: () {
            Get.back();
            onTap?.call();
          },
        ),
      ),
      barrierDismissible: false,
    );
  }
}
