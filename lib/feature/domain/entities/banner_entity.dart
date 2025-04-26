import 'package:nasmobile/feature/domain/entities/base_list_entity.dart';

class BannerEntity {
  final int id;
  final List<String> imageUrls;
  final String? title;
  final String? link;
  final bool isActive;
  final DateTime? showFrom;
  final DateTime? showTo;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;

  BannerEntity({
    this.id = 0,
    this.imageUrls = const [],
    this.title,
    this.link,
    this.isActive = false,
    this.showFrom,
    this.showTo,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
  });
}

class BannerListEntity extends BaseListEntity<BannerEntity> {
  BannerListEntity({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });
}
