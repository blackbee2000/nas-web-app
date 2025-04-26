import 'package:nasmobile/feature/domain/entities/message_entity.dart';

class UserRegisterEntity {
  final int id;
  final String? fullName;
  final String? email;
  final String? phone;
  final DateTime? dateOfBirth;
  final int gender;
  final String? avatar;
  final String? street;
  final bool isActive;
  final MessageEntity? finalMessage;

  UserRegisterEntity({
    this.id = 0,
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender = 0,
    this.avatar,
    this.street,
    this.isActive = true,
    this.finalMessage,
  });

  UserRegisterEntity copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phone,
    DateTime? dateOfBirth,
    int? gender,
    String? avatar,
    String? street,
    bool? isActive,
    MessageEntity? finalMessage,
  }) =>
      UserRegisterEntity(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        avatar: avatar ?? this.avatar,
        street: street ?? this.street,
        isActive: isActive ?? this.isActive,
        finalMessage: finalMessage ?? this.finalMessage,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
      };
}
