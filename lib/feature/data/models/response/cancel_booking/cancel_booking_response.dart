import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'cancel_booking_response.g.dart';

@JsonSerializable()
class CancelBookingResponse extends BaseResponse {
  CancelBookingResponse({
    required super.succeeded,
    super.message,
  });

  factory CancelBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelBookingResponseToJson(this);
}
