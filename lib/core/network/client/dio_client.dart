import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:nasmobile/core/flavor/app_flavor.dart';
import 'package:nasmobile/core/network/interceptors/api_tracking_interceptor.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/core/utils/storage_util.dart';
import 'package:nasmobile/core/widgets/snackbar_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final String baseUrl;
  final List<Interceptor>? interceptors;

  late Dio _dio;

  DioClient({Dio? dio, required this.baseUrl, this.interceptors}) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'vi',
      };

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client = HttpClient(
          context: SecurityContext(
            withTrustedRoots: false,
          ),
        );
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    // Handle API Unauthorised
    _dio.interceptors.add(QueuedInterceptorsWrapper(
      onError: (error, handler) async {
        // Do something with response error
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          final snackBar = SnackbarWidget.failed(
            screenSize: getx.Get.size,
            title: S.current.fail,
            message: S.current.tokenExprired,
            onClose: ScaffoldMessenger.of(
              getx.Get.context!,
            ).hideCurrentSnackBar,
          );
          ScaffoldMessenger.of(getx.Get.context!).showSnackBar(snackBar);
          await StorageUtil.instance.clearAllStorageExceptValue();
          getx.Get.offAllNamed(AppRoutes.loginScreen);
          return handler.reject(error);
        }

        return handler.next(error);
      },
    ));

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false));
    }
  }

  static DioClient get instance => DioClient(
        baseUrl: AppFlavor.instance.value.baseUrl,
        interceptors: [ApiTrackingInterceptor()],
      );

  Future<Response<dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      LogUtil.logError(e.toString());
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      LogUtil.logError(e.toString());
      throw const FormatException("Unable to process the data");
    } on DioException catch (e) {
      LogUtil.logError(e.toString());
      LogUtil.logError(e.response.toString());

      // final data = e.response?.data;
      // if (data != null) {
      //   return Response(
      //     requestOptions: e.requestOptions,
      //     statusCode: e.response?.statusCode,
      //     data: {
      //       "status": data['status'] ?? 500,
      //       "message": data['detail'],
      //     },
      //   );
      // }

      rethrow;
    } catch (e) {
      LogUtil.logError(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (e) {
      LogUtil.logError(e.toString());
      throw const FormatException("Unable to process the data");
    } on DioException catch (e) {
      LogUtil.logError(e.toString());
      LogUtil.logError(e.response.toString());

      final data = e.response?.data;
      if (data != null) {
        return Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
          data: {
            "status": data['status'] ?? 500,
            "message": data['detail'],
          },
        );
      }

      rethrow;
    } catch (e) {
      LogUtil.logError(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (e) {
      LogUtil.logError(e.toString());
      throw const FormatException("Unable to process the data");
    } on DioException catch (e) {
      LogUtil.logError(e.toString());
      LogUtil.logError(e.response.toString());

      // final data = e.response?.data;
      // if (data != null) {
      //   return Response(
      //     requestOptions: e.requestOptions,
      //     statusCode: e.response?.statusCode,
      //     data: {
      //       "status": data['status'] ?? 500,
      //       "message": data['detail'],
      //     },
      //   );
      // }

      rethrow;
    } catch (e) {
      LogUtil.logError(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> delete(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      var response = await _dio.delete(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
      return response;
    } on FormatException catch (e) {
      LogUtil.logError(e.toString());
      throw const FormatException("Unable to process the data");
    } on DioException catch (e) {
      LogUtil.logError(e.toString());
      LogUtil.logError(e.response.toString());

      // final data = e.response?.data;
      // if (data != null) {
      //   return Response(
      //     requestOptions: e.requestOptions,
      //     statusCode: e.response?.statusCode,
      //     data: {
      //       "status": data['status'] ?? 500,
      //       "message": data['detail'],
      //     },
      //   );
      // }

      rethrow;
    } catch (e) {
      LogUtil.logError(e.toString());
      rethrow;
    }
  }
}
