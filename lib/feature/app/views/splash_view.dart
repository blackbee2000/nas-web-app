import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/splash_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class SplashView extends BaseView<SplashController> {
  const SplashView({super.key});

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
            image: AssetImage(AppPaths.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: viewPadding.top + AppDimension.largeSpace * 5),
            Image.asset(
              AppPaths.mainLogo,
              width: 210,
              height: 210,
            ),
            TextWidget(
              text: S.current.wellcomeSplash,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: AppDimension.largeFontSize + 8,
            ),
          ],
        ),
      ),
    );
  }
}
