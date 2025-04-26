import 'package:dio/dio.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/network/client/dio_client.dart';
import 'package:nasmobile/core/utils/replace_util.dart';
import 'package:nasmobile/feature/data/models/request/cancel_booking_request.dart';
import 'package:nasmobile/feature/data/models/request/create_booking_request.dart';
import 'package:nasmobile/feature/data/models/request/get_list_booking_request.dart';
import 'package:nasmobile/feature/data/models/response/booking/booking_response.dart';
import 'package:nasmobile/feature/data/models/response/booking_detail/booking_detail_response.dart';
import 'package:nasmobile/feature/data/models/response/booking_list/booking_list_response.dart';
import 'package:nasmobile/feature/data/models/response/cancel_booking/cancel_booking_response.dart';

class AppoinmentDatasource {
  static AppoinmentDatasource get to => AppoinmentDatasource();

  /// Booking create
  Future<BookingResponse> bookingCreate({
    required CreateBookingRequest request,
  }) async {
    final response = await DioClient.instance.post(
      AppUrl.bookingCreate,
      data: FormData.fromMap(request.toJson()),
    );
    return BookingResponse.fromJson(response.data);
  }

  /// Get list booking
  Future<BookingListResponse> getListBooking({
    required GetListBookingRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.bookingList,
      queryParameters: request.toJson(),
    );
    return BookingListResponse.fromJson(response.data);
  }

  /// Get booking detail
  Future<BookingDetailResponse> getBookingDetail({
    required int id,
  }) async {
    final response = await DioClient.instance.get(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.bookingDetail,
        objectReplace: {"{id}": id.toString()},
      ),
    );
    return BookingDetailResponse.fromJson(response.data);
  }

  /// Cancel booking
  Future<CancelBookingResponse> cancelBooking({
    required CancelBookingRequest request,
  }) async {
    final response = await DioClient.instance.put(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.cancelBooking,
        objectReplace: {"{id}": request.id.toString()},
      ),
      data: FormData.fromMap(request.toJson()),
    );
    return CancelBookingResponse.fromJson(response.data);
  }
}
