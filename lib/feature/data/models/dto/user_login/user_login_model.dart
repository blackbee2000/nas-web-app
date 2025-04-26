import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/domain/entities/user_login_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel implements Transfer<UserLoginEntity> {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final DateTime? dateOfBirth;
  final int? gender;
  final String? avatar;
  final String? street;
  final bool? isActive;
  final String? jwToken;

  UserLoginModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.avatar,
    this.street,
    this.isActive,
    this.jwToken,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);

  @override
  UserLoginEntity transfer() => UserLoginEntity(
        id: id ?? 0,
        fullName: fullName != null && fullName!.isNotEmpty ? fullName : null,
        email: email != null && email!.isNotEmpty ? email : null,
        phone: phone != null && phone!.isNotEmpty ? phone : null,
        dateOfBirth: dateOfBirth != null
            ? DateFormatUtil.parseToDate(dateOfBirth!.toString(), true)
            : null,
        gender: gender ?? 0,
        avatar: avatar != null && avatar!.isNotEmpty ? avatar : null,
        street: street != null && street!.isNotEmpty ? street : null,
        isActive: isActive ?? true,
        jwToken: jwToken != null && jwToken!.isNotEmpty ? jwToken : null,
      );
}
