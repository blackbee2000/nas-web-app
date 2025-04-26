import 'dart:io';

import 'package:nasmobile/core/utils/image_picker_util.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

class RegisterRequest {
  final int? id;
  final int? gender;
  final String? street;
  final String phone;
  final bool isActive;
  final File? avatar;
  final DateTime? dateOfBirth;
  final String fullname;
  final String password;
  final String email;

  RegisterRequest({
    this.id,
    this.gender,
    this.street,
    required this.phone,
    this.isActive = true,
    this.avatar,
    this.dateOfBirth,
    required this.fullname,
    required this.password,
    required this.email,
  });

  Future<Map<String, dynamic>> toJson({bool isUpdate = false}) async {
    final params = {
      'Phone': phone,
      'IsActive': isActive,
      'FullName': fullname,
    };

    if (isUpdate) {
      if (id != null) {
        params['Id'] = id!;
      }
      if (gender != null) {
        params['Gender'] = gender!.toString();
      }
      if (dateOfBirth != null) {
        params['DateOfBirth'] = dateOfBirth!.toUtc().toIso8601String();
      }
      if (avatar != null) {
        final newFile = await ImagePickerUtil.renameFile(file: avatar!);
        final uploadFile = await dio.MultipartFile.fromFile(
          newFile.path,
          filename: newFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        );
        params['Avatar'] = uploadFile;
      }
      params['Street'] = street ?? '';
    } else {
      params['Password'] = password;
      params['Email'] = email;
    }

    return params;
  }
}
