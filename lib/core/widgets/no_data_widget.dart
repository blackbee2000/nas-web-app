import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppPaths.icNoData,
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(
            AppColors.greyText,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: AppDimension.mediumSpace),
        TextWidget(
          text: S.current.noData,
          fontSize: AppDimension.largeFontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.greyText,
        ),
      ],
    );
  }
}
