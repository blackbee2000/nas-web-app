import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'like_store_response.g.dart';

@JsonSerializable()
class LikeStoreResponse extends BaseResponse {
  LikeStoreResponse({
    required super.succeeded,
    super.message,
  });

  factory LikeStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$LikeStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LikeStoreResponseToJson(this);
}
