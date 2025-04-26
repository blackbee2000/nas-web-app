import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/generated/l10n.dart';

class IntroItem {
  final String image;
  final String title;
  final String content;

  IntroItem({required this.image, required this.title, required this.content});
}

class IntroController extends BaseController {
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  final currentIndex = 0.obs;
  final introItems = [
    IntroItem(
      image: AppPaths.imageIntro1,
      title: S.current.wellcomeToNas,
      content: S.current.introText1,
    ),
    IntroItem(
      image: AppPaths.imageIntro2,
      title: S.current.suggestNail,
      content: S.current.introText2,
    ),
    IntroItem(
      image: AppPaths.imageIntro3,
      title: S.current.bookingAndRemind,
      content: S.current.introText3,
    ),
  ].obs;

  void onChangeIntro() {
    if (currentIndex.value == introItems.length - 1) {
      Get.offAllNamed(AppRoutes.optionLoginRegister);
      return;
    }

    carouselSliderController.nextPage();
  }
}
