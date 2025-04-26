import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class EasyLoadingConfig {
  static void config() {
    EasyLoading.instance.dismissOnTap = false;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.backgroundColor = Colors.white;
    EasyLoading.instance.indicatorColor = AppColors.pink600;
    EasyLoading.instance.textColor = AppColors.pink600;
  }
}
