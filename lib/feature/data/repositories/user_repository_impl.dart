import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/core/network/exception/network_exceptions.dart';
import 'package:nasmobile/feature/data/datasources/user_datasource.dart';
import 'package:nasmobile/feature/data/models/request/change_password_request.dart';
import 'package:nasmobile/feature/data/models/request/login_request.dart';
import 'package:nasmobile/feature/data/models/request/register_request.dart';
import 'package:nasmobile/feature/domain/entities/banner_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_login_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<Failure, UserRegisterEntity>> register({
    required String phone,
    bool isActive = true,
    required String fullname,
    required String password,
    required String email,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.register(
        request: RegisterRequest(
          password: password,
          email: email,
          fullname: fullname,
          phone: phone,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(response.message ?? S.current.registerFailed));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, UserLoginEntity>> login({
    required String password,
    required String email,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.login(
        request: LoginRequest(
          email: email,
          password: password,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(response.message ?? S.current.loginFailed));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, UserRegisterEntity>> getProfile() async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.getProfile();

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getProfileFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, UserRegisterEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.changePassword(
        request: ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.changePassFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, UserRegisterEntity>> editUser({
    required int id,
    required int gender,
    String? street,
    required String phone,
    File? avatar,
    DateTime? dateOfBirth,
    required String fullname,
    bool isActive = true,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.editUser(
        request: RegisterRequest(
          id: id,
          gender: gender,
          street: street,
          avatar: avatar,
          dateOfBirth: dateOfBirth,
          phone: phone,
          fullname: fullname,
          password: "",
          email: "",
          isActive: isActive,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.updateUserFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, BannerListEntity>> getListBanner() async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await UserDatasource.to.getListBanner();

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getListBannerFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }
}
