class UserLoginEntity {
  final int id;
  final String? fullName;
  final String? email;
  final String? phone;
  final DateTime? dateOfBirth;
  final int gender;
  final String? avatar;
  final String? street;
  final bool isActive;
  final String? jwToken;

  UserLoginEntity({
    this.id = 0,
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender = 0,
    this.avatar,
    this.street,
    this.isActive = true,
    this.jwToken,
  });
}
