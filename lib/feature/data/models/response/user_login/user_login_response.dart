import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/user_login/user_login_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'user_login_response.g.dart';

@JsonSerializable()
class UserLoginResponse extends BaseResponse<UserLoginModel> {
  UserLoginResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}
