import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'user_register_model.g.dart';

@JsonSerializable()
class UserRegisterModel implements Transfer<UserRegisterEntity> {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final DateTime? dateOfBirth;
  final int? gender;
  final String? avatar;
  final String? street;
  final bool? isActive;

  UserRegisterModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.avatar,
    this.street,
    this.isActive,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterModelToJson(this);

  @override
  UserRegisterEntity transfer() => UserRegisterEntity(
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
      );
}
