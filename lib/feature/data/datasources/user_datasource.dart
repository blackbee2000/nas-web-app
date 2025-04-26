import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/network/client/dio_client.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/core/utils/replace_util.dart';
import 'package:nasmobile/feature/data/models/request/change_password_request.dart';
import 'package:nasmobile/feature/data/models/request/login_request.dart';
import 'package:nasmobile/feature/data/models/request/register_request.dart';
import 'package:nasmobile/feature/data/models/response/banner/banner_response.dart';
import 'package:nasmobile/feature/data/models/response/user_login/user_login_response.dart';
import 'package:nasmobile/feature/data/models/response/user_register/user_register_response.dart';
import 'package:dio/dio.dart' as dio;

class UserDatasource {
  static UserDatasource get to => UserDatasource();

  /// Register
  Future<UserRegisterResponse> register({
    required RegisterRequest request,
  }) async {
    final response = await DioClient.instance.post(
      AppUrl.register,
      data: dio.FormData.fromMap(await request.toJson()),
    );
    return UserRegisterResponse.fromJson(response.data);
  }

  /// Login
  Future<UserLoginResponse> login({
    required LoginRequest request,
  }) async {
    final response = await DioClient.instance.post(
      AppUrl.login,
      data: request.toJson(),
    );
    return UserLoginResponse.fromJson(response.data);
  }

  /// Get profile
  Future<UserRegisterResponse> getProfile() async {
    final response = await DioClient.instance.get(AppUrl.profile);
    return UserRegisterResponse.fromJson(response.data);
  }

  /// Change password
  Future<UserRegisterResponse> changePassword({
    required ChangePasswordRequest request,
  }) async {
    final response = await DioClient.instance.post(
      AppUrl.changePassword,
      data: request.toJson(),
    );
    return UserRegisterResponse.fromJson(response.data);
  }

  /// Update user
  Future<UserRegisterResponse> editUser({
    required RegisterRequest request,
  }) async {
    LogUtil.logDebug(request.toJson(isUpdate: true));
    final response = await DioClient.instance.put(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.updateUser,
        objectReplace: {"{id}": request.id.toString()},
      ),
      data: dio.FormData.fromMap(await request.toJson(isUpdate: true)),
    );
    return UserRegisterResponse.fromJson(response.data);
  }

  /// Get list banner
  Future<BannerResponse> getListBanner() async {
    final response = await DioClient.instance.get(AppUrl.bannerList);
    return BannerResponse.fromJson(response.data);
  }
}
