import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/enums/language_mode.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/setting_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class SettingView extends BaseView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBarWidget(
        titleName: S.current.settingLanguage,
        imagePath: AppPaths.backgroundAppBar,
        titleColor: Colors.white,
        heightAppBar: 60,
        colorLeading: Colors.white,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: LanguageMode.values.length,
          itemBuilder: (ct, i) {
            final item = LanguageMode.values[i];
            return GestureDetector(
              onTap: () {
                controller.appService.onChangeLanguage(mode: item);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimension.mediumSpace),
                margin: const EdgeInsets.only(bottom: AppDimension.mediumSpace),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppDimension.largeBorderRadius + 8,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimension.largeBorderRadius * 100,
                            ),
                            child: SvgPicture.asset(
                              item.icon,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimension.smallSpace),
                        TextWidget(
                          text: item.fullname,
                          fontSize: AppDimension.largeFontSize,
                          color: AppColors.secondBlackText,
                        )
                      ],
                    ),
                    Obx(
                      () => Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: controller.appService.language.value == item
                              ? null
                              : Border.all(color: AppColors.border),
                          gradient: controller.appService.language.value == item
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.pinkFFBEFF,
                                    AppColors.pinkF01799,
                                  ],
                                )
                              : null,
                        ),
                        child: controller.appService.language.value == item
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
