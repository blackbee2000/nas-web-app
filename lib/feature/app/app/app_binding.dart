import 'package:get/get.dart';
import 'package:nasmobile/core/services/app_service.dart';
import 'package:nasmobile/core/services/auth_service.dart';
import 'package:nasmobile/core/services/location_services.dart';
import 'package:nasmobile/feature/data/repositories/chat_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/common_data_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/date_time_book_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/history_book_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/news_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/store_repository_impl.dart';
import 'package:nasmobile/feature/data/repositories/user_repository_impl.dart';
import 'package:nasmobile/feature/domain/repositories/chat_repository.dart';
import 'package:nasmobile/feature/domain/repositories/common_data_repository.dart';
import 'package:nasmobile/feature/domain/repositories/date_time_book_repository.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/feature/domain/repositories/news_repository.dart';
import 'package:nasmobile/feature/domain/repositories/store_repository.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    /// Service
    Get.lazyPut(
      () => LocationServices(),
      fenix: true,
    );
    Get.lazyPut(
      () => AppService(),
      fenix: true,
    );
    Get.lazyPut(
      () => AuthService(),
      fenix: true,
    );

    /// Repository
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<StoreRepository>(
      () => StoreRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<NewsRepository>(
      () => NewsRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<CommonDataRepository>(
      () => CommonDataRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<DateTimeBookRepository>(
      () => DateTimeBookRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<HistoryBookRepository>(
      () => HistoryBookRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<ChatRepository>(
      () => ChatRepositoryImpl(),
      fenix: true,
    );
  }
}
