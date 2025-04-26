import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class OptionLoginRegisterView extends StatelessWidget {
  const OptionLoginRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppPaths.backgroundOption),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: max(
                AppDimension.largeSpace * 2,
                viewPadding.top,
              ),
              right: AppDimension.largeSpace * 2,
              child: Image.asset(
                width: 62,
                height: 62,
                AppPaths.logoColor,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                  topRight: Radius.circular(
                    AppDimension.largeBorderRadius * 2,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: double.infinity,
                    height: 375,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimension.largeSpace * 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          AppDimension.largeBorderRadius * 2,
                        ),
                        topRight: Radius.circular(
                          AppDimension.largeBorderRadius * 2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: S.current.wellcomeYouToNas,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimension.extraLargeFontSize + 10,
                          color: Colors.white,
                          maxlines: 2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimension.largeSpace * 1.5),
                        RoundedButtonWidget(
                          onPressed: () => Get.toNamed(
                            AppRoutes.registerScreen,
                          ),
                          text: S.current.register,
                        ),
                        const SizedBox(height: AppDimension.mediumSpace),
                        SecondaryRoundedButonWidget(
                          onPressed: () => Get.toNamed(
                            AppRoutes.loginScreen,
                          ),
                          text: S.current.login,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
