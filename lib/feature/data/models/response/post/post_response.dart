import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/post/post_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse extends BaseResponse<PostListModel> {
  PostResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
