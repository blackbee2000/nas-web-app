import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/store/store_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'store_response.g.dart';

@JsonSerializable()
class StoreResponse extends BaseResponse<StoreListModel> {
  StoreResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}
