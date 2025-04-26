import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/domain/entities/banner_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_login_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';

abstract class UserRepository {
  /// Register
  Future<Either<Failure, UserRegisterEntity>> register({
    required String phone,
    bool isActive = true,
    required String fullname,
    required String password,
    required String email,
  });

  /// Login
  Future<Either<Failure, UserLoginEntity>> login({
    required String password,
    required String email,
  });

  /// Profile
  Future<Either<Failure, UserRegisterEntity>> getProfile();

  /// Change password
  Future<Either<Failure, UserRegisterEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Edit user
  Future<Either<Failure, UserRegisterEntity>> editUser({
    required int id,
    required int gender,
    String? street,
    required String phone,
    File? avatar,
    DateTime? dateOfBirth,
    required String fullname,
    bool isActive = true,
  });

  /// Get list banner
  Future<Either<Failure, BannerListEntity>> getListBanner();
}
