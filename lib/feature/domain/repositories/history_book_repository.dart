import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';

abstract class HistoryBookRepository {
  /// Booking
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
  });

  /// Get list booking
  Future<Either<Failure, BookingListEntity>> getListBooking({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
  });

  /// Get booking detail
  Future<Either<Failure, BookingEntity>> getBookingDetail({
    required int id,
  });

  /// Cancel booking
  Future<Either<Failure, bool>> cancelBooking({
    required int id,
  });
}
