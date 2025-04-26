import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/banner/banner_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse extends BaseResponse<BannerListModel> {
  BannerResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
