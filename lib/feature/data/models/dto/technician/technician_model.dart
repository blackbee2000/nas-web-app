import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/data/models/dto/base_list_model.dart';
import 'package:nasmobile/feature/domain/entities/technician_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'technician_model.g.dart';

@JsonSerializable()
class TechnicianModel implements Transfer<TechnicianEntity> {
  final int? id;
  final String? technicianName;
  final String? technicianAddress;
  final String? phone;
  final String? avatar;
  final int? ratingStar;
  final DateTime? workingSchedule;
  final int? accountId;
  final int? storeId;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;

  TechnicianModel({
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

  factory TechnicianModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicianModelFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicianModelToJson(this);

  @override
  TechnicianEntity transfer() => TechnicianEntity(
        id: id ?? 0,
        technicianName: technicianName != null && technicianName!.isNotEmpty
            ? technicianName
            : null,
        technicianAddress:
            technicianAddress != null && technicianAddress!.isNotEmpty
                ? technicianAddress
                : null,
        phone: phone != null && phone!.isNotEmpty ? phone : null,
        avatar: avatar != null && avatar!.isNotEmpty ? avatar : null,
        ratingStar: ratingStar ?? 0,
        workingSchedule: workingSchedule != null
            ? DateFormatUtil.parseToDate(workingSchedule!.toString(), true)
            : null,
        accountId: accountId ?? 0,
        storeId: storeId ?? 0,
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
      );
}

@JsonSerializable()
class TechnicianListModel extends BaseListModel<TechnicianModel>
    implements Transfer<TechnicianListEntity> {
  TechnicianListModel({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });

  factory TechnicianListModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicianListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicianListModelToJson(this);

  @override
  TechnicianListEntity transfer() => TechnicianListEntity(
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
