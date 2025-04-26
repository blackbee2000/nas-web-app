import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/data/models/dto/base_list_model.dart';
import 'package:nasmobile/feature/domain/entities/booking_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel implements Transfer<BookingEntity> {
  final int? id;
  final int? storeId;
  final int? productId;
  final int? technicianId;
  final String? userId;
  final DateTime? bookingDate;
  final String? bookingTime;
  final int? status;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? note;
  final String? fullName;
  final String? address;
  final int? gender;
  final String? phone;
  final String? email;
  final int? number;
  final int? transactionId;
  final String? payment;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final StoreBookingModel? store;
  final TechnicianBookingModel? technician;

  BookingModel({
    this.id,
    this.storeId,
    this.productId,
    this.technicianId,
    this.userId,
    this.bookingDate,
    this.bookingTime,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.note,
    this.fullName,
    this.address,
    this.gender,
    this.phone,
    this.email,
    this.number,
    this.transactionId,
    this.payment,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.store,
    this.technician,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  @override
  BookingEntity transfer() => BookingEntity(
        id: id ?? 0,
        storeId: storeId ?? 0,
        productId: productId ?? 0,
        technicianId: technicianId ?? 0,
        userId: userId != null && userId!.isNotEmpty ? userId : null,
        bookingDate: bookingDate != null
            ? DateFormatUtil.parseToDate(bookingDate!.toString(), true)
            : null,
        bookingTime:
            bookingTime != null && bookingTime!.isNotEmpty ? bookingTime : null,
        status: status ?? 0,
        paymentStatus: paymentStatus != null && paymentStatus!.isNotEmpty
            ? paymentStatus
            : null,
        paymentMethod: paymentMethod != null && paymentMethod!.isNotEmpty
            ? paymentMethod
            : null,
        note: note != null && note!.isNotEmpty ? note : null,
        fullName: fullName != null && fullName!.isNotEmpty ? fullName : null,
        address: address != null && address!.isNotEmpty ? address : null,
        gender: gender ?? 0,
        phone: phone != null && phone!.isNotEmpty ? phone : null,
        email: email != null && email!.isNotEmpty ? email : null,
        number: number ?? 0,
        transactionId: transactionId ?? 0,
        payment: payment != null && payment!.isNotEmpty ? payment : null,
        created: created != null
            ? DateFormatUtil.parseToDate(created!.toString(), true)
            : null,
        createdBy:
            createdBy != null && createdBy!.isNotEmpty ? createdBy : null,
        lastModified: lastModified != null
            ? DateFormatUtil.parseToDate(lastModified!.toString(), true)
            : null,
        lastModifiedBy: lastModifiedBy != null && lastModifiedBy!.isNotEmpty
            ? lastModifiedBy
            : null,
        store: store?.transfer(),
        technician: technician?.transfer(),
      );
}

@JsonSerializable()
class StoreBookingModel implements Transfer<StoreBookingEntity> {
  final int? id;
  final String? storeName;
  final String? hotline;
  final String? addressStore;

  StoreBookingModel({
    this.id,
    this.storeName,
    this.hotline,
    this.addressStore,
  });

  factory StoreBookingModel.fromJson(Map<String, dynamic> json) =>
      _$StoreBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreBookingModelToJson(this);

  @override
  StoreBookingEntity transfer() => StoreBookingEntity(
        id: id ?? 0,
        storeName:
            storeName != null && storeName!.isNotEmpty ? storeName : null,
        hotline: hotline != null && hotline!.isNotEmpty ? hotline : null,
        addressStore: addressStore != null && addressStore!.isNotEmpty
            ? addressStore
            : null,
      );
}

@JsonSerializable()
class TechnicianBookingModel implements Transfer<TechnicianBookingEntity> {
  final int? id;
  final String? technicianName;
  final String? phone;
  final String? technicianAddress;

  TechnicianBookingModel({
    this.id,
    this.technicianName,
    this.phone,
    this.technicianAddress,
  });

  factory TechnicianBookingModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicianBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicianBookingModelToJson(this);

  @override
  TechnicianBookingEntity transfer() => TechnicianBookingEntity(
        id: id ?? 0,
        technicianName: technicianName != null && technicianName!.isNotEmpty
            ? technicianName
            : null,
        phone: phone != null && phone!.isNotEmpty ? phone : null,
        technicianAddress:
            technicianAddress != null && technicianAddress!.isNotEmpty
                ? technicianAddress
                : null,
      );
}

@JsonSerializable()
class BookingListModel extends BaseListModel<BookingModel>
    implements Transfer<BookingListEntity> {
  BookingListModel({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });

  factory BookingListModel.fromJson(Map<String, dynamic> json) =>
      _$BookingListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingListModelToJson(this);

  @override
  BookingListEntity transfer() => BookingListEntity(
        items: items != null && items!.isNotEmpty
            ? items!.map((e) => e.transfer()).toList()
            : [],
        pageNumber: pageNumber ?? 0,
        totalPages: totalPages ?? 0,
        totalCount: totalCount ?? 0,
        hasPreviousPage: hasPreviousPage ?? false,
        hasNextPage: hasNextPage ?? false,
      );
}
