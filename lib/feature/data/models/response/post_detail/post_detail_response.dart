import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/post/post_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'post_detail_response.g.dart';

@JsonSerializable()
class PostDetailResponse extends BaseResponse<PostModel> {
  PostDetailResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailResponseToJson(this);
}
