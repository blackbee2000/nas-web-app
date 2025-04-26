import 'package:get/get.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/account_information_controller.dart';
import 'package:nasmobile/feature/app/controllers/account_setting_controller.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_controller.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_detail_controller.dart';
import 'package:nasmobile/feature/app/controllers/appoinment_manage_controller.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/lens_list_controller.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/media_result_controller.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/try_nails_controller.dart';
import 'package:nasmobile/feature/app/controllers/change_password_controller.dart';
import 'package:nasmobile/feature/app/controllers/chat_controller.dart';
import 'package:nasmobile/feature/app/controllers/chat_detail_controller.dart';
import 'package:nasmobile/feature/app/controllers/chat_gemini_controller.dart';
import 'package:nasmobile/feature/app/controllers/chat_list_controller.dart';
import 'package:nasmobile/feature/app/controllers/forgot_password_controller.dart';
import 'package:nasmobile/feature/app/controllers/history_appoinment_controller.dart';
import 'package:nasmobile/feature/app/controllers/home_controller.dart';
import 'package:nasmobile/feature/app/controllers/intro_controller.dart';
import 'package:nasmobile/feature/app/controllers/login_controller.dart';
import 'package:nasmobile/feature/app/controllers/main_controller.dart';
import 'package:nasmobile/feature/app/controllers/news_controller.dart';
import 'package:nasmobile/feature/app/controllers/news_detail_controller.dart';
import 'package:nasmobile/feature/app/controllers/notification_controller.dart';
import 'package:nasmobile/feature/app/controllers/option_login_register_controller.dart';
import 'package:nasmobile/feature/app/controllers/register_controller.dart';
import 'package:nasmobile/feature/app/controllers/report_controller.dart';
import 'package:nasmobile/feature/app/controllers/reset_password_controller.dart';
import 'package:nasmobile/feature/app/controllers/service_controller.dart';
import 'package:nasmobile/feature/app/controllers/service_detail_controller.dart';
import 'package:nasmobile/feature/app/controllers/setting_controller.dart';
import 'package:nasmobile/feature/app/controllers/setup_account_controller.dart';
import 'package:nasmobile/feature/app/controllers/splash_controller.dart';
import 'package:nasmobile/feature/app/controllers/store_detail_controller.dart';
import 'package:nasmobile/feature/app/controllers/stores_controller.dart';
import 'package:nasmobile/feature/app/controllers/take_photo_360_controller.dart';
import 'package:nasmobile/feature/app/controllers/verify_otp_controller.dart';
import 'package:nasmobile/feature/app/controllers/view_360_store_controller.dart';
import 'package:nasmobile/feature/app/controllers/view_rating_controller.dart';
import 'package:nasmobile/feature/app/views/account_information_view.dart';
import 'package:nasmobile/feature/app/views/account_setting_view.dart';
import 'package:nasmobile/feature/app/views/appoinment_detail_view.dart';
import 'package:nasmobile/feature/app/views/appoinment_manage_view.dart';
import 'package:nasmobile/feature/app/views/appoinment_view.dart';
import 'package:nasmobile/feature/app/views/camera_try_on_nails/lens_list_view.dart';
import 'package:nasmobile/feature/app/views/camera_try_on_nails/media_result_view.dart';
import 'package:nasmobile/feature/app/views/change_password_view.dart';
import 'package:nasmobile/feature/app/views/chat_detail_view.dart';
import 'package:nasmobile/feature/app/views/chat_gemini_view.dart';
import 'package:nasmobile/feature/app/views/chat_list_view.dart';
import 'package:nasmobile/feature/app/views/chat_view.dart';
import 'package:nasmobile/feature/app/views/forgot_password_view.dart';
import 'package:nasmobile/feature/app/views/history_appoinment_view.dart';
import 'package:nasmobile/feature/app/views/home_view.dart';
import 'package:nasmobile/feature/app/views/intro_view.dart';
import 'package:nasmobile/feature/app/views/login_view.dart';
import 'package:nasmobile/feature/app/views/news_detail_view.dart';
import 'package:nasmobile/feature/app/views/notification_view.dart';
import 'package:nasmobile/feature/app/views/option_login_register_view.dart';
import 'package:nasmobile/feature/app/views/register_view.dart';
import 'package:nasmobile/feature/app/views/report_view.dart';
import 'package:nasmobile/feature/app/views/reset_password_view.dart';
import 'package:nasmobile/feature/app/views/service_detail_view.dart';
import 'package:nasmobile/feature/app/views/service_view.dart';
import 'package:nasmobile/feature/app/views/setting_view.dart';
import 'package:nasmobile/feature/app/views/setup_account_view.dart';
import 'package:nasmobile/feature/app/views/splash_view.dart';
import 'package:nasmobile/feature/app/views/store_detail_view.dart';
import 'package:nasmobile/feature/app/views/take_photo_360_view.dart';
import 'package:nasmobile/feature/app/views/verify_otp_view.dart';
import 'package:nasmobile/feature/app/views/view_360_store_view.dart';
import 'package:nasmobile/feature/app/views/view_rating_view.dart';

class AppPages {
  AppPages._();

  static const Transition _kTransition = Transition.rightToLeftWithFade;
  static const Duration _kTransitionDuration = Duration(milliseconds: 200);

  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
        Get.put(MainController());
        Get.put(NewsController());
        Get.put(StoresController());
        Get.put(TryNailsController());
      }),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginView(),
      binding: BindingsBuilder.put(() => LoginController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.registerScreen,
      page: () => const RegisterView(),
      binding: BindingsBuilder.put(() => RegisterController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => const ChangePasswordView(),
      binding: BindingsBuilder.put(() => ChangePasswordController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.accountInformationScreen,
      page: () => const AccountInformationView(),
      binding: BindingsBuilder.put(() => AccountInformationController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.chatGeminiScreen,
      page: () => const ChatGeminiView(),
      binding: BindingsBuilder.put(() => ChatGeminiController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.storeDetail,
      page: () => const StoreDetailView(),
      binding: BindingsBuilder.put(() => StoreDetailController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.view360Store,
      page: () => const View360StoreView(),
      binding: BindingsBuilder.put(() => View360StoreController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailView(),
      binding: BindingsBuilder.put(() => NewsDetailController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.settingScreen,
      page: () => const SettingView(),
      binding: BindingsBuilder.put(() => SettingController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationView(),
      binding: BindingsBuilder.put(() => NotificationController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.appoinmentManageScreen,
      page: () => const AppoinmentManageView(),
      binding: BindingsBuilder.put(() => AppoinmentManageController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.appoinmentDetail,
      page: () => const AppoinmentDetailView(),
      binding: BindingsBuilder.put(() => AppoinmentDetailController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.reportScreen,
      page: () => const ReportView(),
      binding: BindingsBuilder.put(() => ReportController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    // GetPage(
    //   name: AppRoutes.tryNailsScreen,
    //   page: () => const TryNailsView(),
    //   binding: BindingsBuilder.put(() => TryNailsController()),
    //   transition: _kTransition,
    //   transitionDuration: _kTransitionDuration,
    // ),
    GetPage(
      name: AppRoutes.historyAppoinment,
      page: () => const HistoryAppoinmentView(),
      binding: BindingsBuilder.put(() => HistoryAppoinmentController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.appoinmentBook,
      page: () => const AppoinmentView(),
      binding: BindingsBuilder.put(() => AppoinmentController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.chatList,
      page: () => const ChatListView(),
      binding: BindingsBuilder.put(() => ChatListController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.chatDetail,
      page: () => const ChatDetailView(),
      binding: BindingsBuilder.put(() => ChatDetailController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: BindingsBuilder.put(() => ChatController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.takePhoto360,
      page: () => const TakePhoto360View(),
      binding: BindingsBuilder.put(() => TakePhoto360Controller()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.lensList,
      page: () => const LensListView(),
      binding: BindingsBuilder.put(() => LensListController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.mediaResult,
      page: () => const MediaResultView(),
      binding: BindingsBuilder.put(() => MediaResultController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroView(),
      binding: BindingsBuilder.put(() => IntroController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.optionLoginRegister,
      page: () => const OptionLoginRegisterView(),
      binding: BindingsBuilder.put(() => OptionLoginRegisterController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.verifyOtp,
      page: () => const VerifyOtpView(),
      binding: BindingsBuilder.put(() => VerifyOtpController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.setupAccount,
      page: () => const SetupAccountView(),
      binding: BindingsBuilder.put(() => SetupAccountController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder.put(() => ForgotPasswordController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
      binding: BindingsBuilder.put(() => ResetPasswordController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.accountSetting,
      page: () => const AccountSettingView(),
      binding: BindingsBuilder.put(() => AccountSettingController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.service,
      page: () => const ServiceView(),
      binding: BindingsBuilder.put(() => ServiceController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.viewRating,
      page: () => const ViewRatingView(),
      binding: BindingsBuilder.put(() => ViewRatingController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
    GetPage(
      name: AppRoutes.serviceDetail,
      page: () => const ServiceDetailView(),
      binding: BindingsBuilder.put(() => ServiceDetailController()),
      transition: _kTransition,
      transitionDuration: _kTransitionDuration,
    ),
  ];
}
