import 'package:flutter/material.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

enum StatusBooking {
  pending(
    1,
    'Mới',
    'New',
    AppColors.greyText,
    AppColors.greyText,
    AppColors.greyText,
  ),
  completed(
    2,
    'Hoàn thành',
    'Completed',
    AppColors.greenF9FFE5,
    AppColors.green6CAE05,
    AppColors.green385710,
  ),
  cancelled(
    3,
    'Hủy',
    'Cancelled',
    AppColors.redFEF1F1,
    AppColors.errorColor,
    AppColors.red8F0D38,
  );

  const StatusBooking(
    this.code,
    this.nameVN,
    this.nameEN,
    this.color,
    this.borderColor,
    this.colorText,
  );
  final int code;
  final String nameVN;
  final String nameEN;
  final Color color;
  final Color borderColor;
  final Color colorText;

  static StatusBooking? mapping(int code) {
    switch (code) {
      case 1:
        return StatusBooking.pending;
      case 2:
        return StatusBooking.completed;
      case 3:
        return StatusBooking.cancelled;
      default:
        return null;
    }
  }
}
