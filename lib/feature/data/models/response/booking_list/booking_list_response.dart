import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/booking/booking_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'booking_list_response.g.dart';

@JsonSerializable()
class BookingListResponse extends BaseResponse<BookingListModel> {
  BookingListResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory BookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingListResponseToJson(this);
}
