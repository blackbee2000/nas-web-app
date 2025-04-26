import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/data/models/dto/base_list_model.dart';
import 'package:nasmobile/feature/domain/entities/banner_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel implements Transfer<BannerEntity> {
  final int? id;
  final List<String>? imageUrls;
  final String? title;
  final String? link;
  final bool? isActive;
  final DateTime? showFrom;
  final DateTime? showTo;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;

  BannerModel({
    this.id,
    this.imageUrls,
    this.title,
    this.link,
    this.isActive,
    this.showFrom,
    this.showTo,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

  @override
  BannerEntity transfer() => BannerEntity(
        id: id ?? 0,
        imageUrls: imageUrls ?? [],
        title: title != null && title!.isNotEmpty ? title : null,
        link: link != null && link!.isNotEmpty ? link : null,
        isActive: isActive ?? false,
        showFrom: showFrom != null
            ? DateFormatUtil.parseToDate(showFrom!.toString(), true)
            : null,
        showTo: showTo != null
            ? DateFormatUtil.parseToDate(showTo!.toString(), true)
            : null,
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
class BannerListModel extends BaseListModel<BannerModel>
    implements Transfer<BannerListEntity> {
  BannerListModel({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });

  factory BannerListModel.fromJson(Map<String, dynamic> json) =>
      _$BannerListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerListModelToJson(this);

  @override
  BannerListEntity transfer() => BannerListEntity(
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
