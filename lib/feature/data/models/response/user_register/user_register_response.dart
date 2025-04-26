import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/user_register/user_register_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'user_register_response.g.dart';

@JsonSerializable()
class UserRegisterResponse extends BaseResponse<UserRegisterModel> {
  UserRegisterResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterResponseToJson(this);
}
