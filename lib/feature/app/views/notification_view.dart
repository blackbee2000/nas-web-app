import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/notification_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class NotificationView extends BaseView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.notification),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (ct, i) => Container(
            margin: i == 9
                ? EdgeInsets.zero
                : const EdgeInsets.only(bottom: AppDimension.smallSpace),
            padding: i == 0
                ? const EdgeInsets.only(
                    bottom: AppDimension.mediumSpace,
                  )
                : const EdgeInsets.symmetric(
                    vertical: AppDimension.mediumSpace,
                  ),
            decoration: BoxDecoration(
              border: Border(
                bottom: i == 9
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                /// Logo
                Stack(
                  children: [
                    Image.asset(
                      AppPaths.logo,
                      width: 50,
                      height: 50,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.errorColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppDimension.smallSpace),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Title thông báo',
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: AppDimension.smallSpace / 3),
                    const TextWidget(
                      text: 'Content thông báo',
                      fontSize: AppDimension.smallFontSize,
                    ),
                    const SizedBox(height: AppDimension.smallSpace / 3),
                    TextWidget(
                      text: DateFormat(DateFormatUtil.kDDMMYYYY).format(
                        DateTime.now(),
                      ),
                      fontSize: AppDimension.smallFontSize,
                      fontStyle: FontStyle.italic,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
