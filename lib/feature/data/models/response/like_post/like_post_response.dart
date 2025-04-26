import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'like_post_response.g.dart';

@JsonSerializable()
class LikePostResponse extends BaseResponse {
  LikePostResponse({
    required super.succeeded,
    super.message,
  });

  factory LikePostResponse.fromJson(Map<String, dynamic> json) =>
      _$LikePostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LikePostResponseToJson(this);
}
