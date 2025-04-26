import 'package:nasmobile/feature/domain/entities/base_list_entity.dart';

class BookingEntity {
  final int id;
  final int storeId;
  final int productId;
  final int technicianId;
  final String? userId;
  final DateTime? bookingDate;
  final String? bookingTime;
  final int status;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? note;
  final String? fullName;
  final String? address;
  final int gender;
  final String? phone;
  final String? email;
  final int number;
  final int transactionId;
  final String? payment;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final StoreBookingEntity? store;
  final TechnicianBookingEntity? technician;

  BookingEntity({
    this.id = 0,
    this.storeId = 0,
    this.productId = 0,
    this.technicianId = 0,
    this.userId,
    this.bookingDate,
    this.bookingTime,
    this.status = 0,
    this.paymentStatus,
    this.paymentMethod,
    this.note,
    this.fullName,
    this.address,
    this.gender = 0,
    this.phone,
    this.email,
    this.number = 0,
    this.transactionId = 0,
    this.payment,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.store,
    this.technician,
  });
}

class StoreBookingEntity {
  final int id;
  final String? storeName;
  final String? hotline;
  final String? addressStore;

  StoreBookingEntity({
    this.id = 0,
    this.storeName,
    this.hotline,
    this.addressStore,
  });
}

class TechnicianBookingEntity {
  final int id;
  final String? technicianName;
  final String? phone;
  final String? technicianAddress;

  TechnicianBookingEntity({
    this.id = 0,
    this.technicianName,
    this.phone,
    this.technicianAddress,
  });
}

class BookingListEntity extends BaseListEntity<BookingEntity> {
  BookingListEntity({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });
}
