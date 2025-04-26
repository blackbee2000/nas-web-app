import 'package:dio/dio.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/core/utils/storage_util.dart';

class ApiTrackingInterceptor extends Interceptor {
  ApiTrackingInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.baseUrl != AppUrl.login && options.baseUrl != AppUrl.register) {
      final token = await StorageUtil.instance.readToken();
      options.headers.addAll({
        'Authorization': 'Bearer ${token ?? ''}',
      });
    }
    LogUtil.logDebug('Base URL: ${options.baseUrl}');
    LogUtil.logDebug('${options.path} | ${options.method}');
    LogUtil.logDebug(options.headers);
    LogUtil.logDebug(options.queryParameters);
    LogUtil.logDebug(options.data);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil.logDebug('Base URL: ${response.requestOptions.baseUrl}');
    LogUtil.logDebug(
        '${response.requestOptions.path} | ${response.requestOptions.method}');
    LogUtil.logDebug(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogUtil.logDebug('Base URL: ${err.requestOptions.baseUrl}');
    LogUtil.logDebug(
        '${err.requestOptions.path} | ${err.requestOptions.method}');
    LogUtil.logDebug(err.response?.statusCode);
    LogUtil.logDebug(err.response?.data);
    throw err;
  }
}
