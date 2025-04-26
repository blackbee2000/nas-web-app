import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/core/network/exception/network_exceptions.dart';
import 'package:nasmobile/feature/data/datasources/appoinment_datasource.dart';
import 'package:nasmobile/feature/data/models/request/cancel_booking_request.dart';
import 'package:nasmobile/feature/data/models/request/create_booking_request.dart';
import 'package:nasmobile/feature/data/models/request/get_list_booking_request.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/repositories/history_book_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class HistoryBookRepositoryImpl extends HistoryBookRepository {
  @override
  Future<Either<Failure, BookingEntity>> bookingCreate({
    required int storeId,
    required int productId,
    required int technicianId,
    required DateTime bookingDate,
    required String bookingTime,
    required String note,
    required String fullName,
    required String address,
    required int gender,
    required String phone,
    required String email,
    required int number,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await AppoinmentDatasource.to.bookingCreate(
        request: CreateBookingRequest(
          storeId: storeId,
          productId: productId,
          technicianId: technicianId,
          bookingDate: bookingDate,
          bookingTime: bookingTime,
          note: note,
          fullName: fullName,
          address: address,
          gender: gender,
          phone: phone,
          email: email,
          number: number,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(response.message ?? S.current.bookingFailed));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, BookingListEntity>> getListBooking({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await AppoinmentDatasource.to.getListBooking(
        request: GetListBookingRequest(
          pageNumber: pageNumber,
          pageSize: pageSize,
          searchText: searchText,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getListBookingFailed,
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
  Future<Either<Failure, BookingEntity>> getBookingDetail({
    required int id,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await AppoinmentDatasource.to.getBookingDetail(id: id);

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getBookingDetailFailed,
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
  Future<Either<Failure, bool>> cancelBooking({required int id}) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await AppoinmentDatasource.to.cancelBooking(
        request: CancelBookingRequest(id: id),
      );

      if (response.succeeded) {
        return right(response.succeeded);
      }

      return left(ServerFailure(
        response.message ?? S.current.cancelBookingFailed,
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
