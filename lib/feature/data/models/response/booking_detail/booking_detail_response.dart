import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/booking/booking_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'booking_detail_response.g.dart';

@JsonSerializable()
class BookingDetailResponse extends BaseResponse<BookingModel> {
  BookingDetailResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailResponseToJson(this);
}
