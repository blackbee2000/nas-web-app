import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/store/store_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'store_detail_response.g.dart';

@JsonSerializable()
class StoreDetailResponse extends BaseResponse<StoreModel> {
  StoreDetailResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);
}
