import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';

abstract class BaseView<T extends GetxController> extends GetWidget<T> {
  const BaseView({super.key});

  Widget buttonIcon({required String icon, VoidCallback? onTap}) => InkWell(
        borderRadius: BorderRadius.circular(
          AppDimension.mediumBorderRadius + 2,
        ),
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(AppDimension.smallSpace - 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.mediumBorderRadius + 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: SvgPicture.asset(icon),
        ),
      );
}
