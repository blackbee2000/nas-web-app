import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/booking/booking_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse extends BaseResponse<BookingModel> {
  BookingResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}
