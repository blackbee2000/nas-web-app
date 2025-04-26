import 'package:nasmobile/feature/domain/entities/base_list_entity.dart';

class TechnicianEntity {
  final int id;
  final String? technicianName;
  final String? technicianAddress;
  final String? phone;
  final String? avatar;
  final int ratingStar;
  final DateTime? workingSchedule;
  final int accountId;
  final int storeId;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;

  TechnicianEntity({
    this.id = 0,
    this.technicianName,
    this.technicianAddress,
    this.phone,
    this.avatar,
    this.ratingStar = 0,
    this.workingSchedule,
    this.accountId = 0,
    this.storeId = 0,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
  });
}

class TechnicianListEntity extends BaseListEntity<TechnicianEntity> {
  TechnicianListEntity({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });
}
