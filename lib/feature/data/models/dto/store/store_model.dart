import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/data/models/dto/base_list_model.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel implements Transfer<StoreEntity> {
  final int? id;
  final String? storeName;
  final String? avatar;
  final String? addressStore;
  final int? ratingStar;
  final double? lat;
  final double? lng;
  final String? hotline;
  final String? openTime;
  final String? closeTime;
  final String? googleReviewLink;
  final String? ownerId;
  final List<int>? productIds;
  final List<String>? productsNames;
  final List<String>? imageUrls;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final bool? isFavorite;
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  StoreModel({
    this.id,
    this.storeName,
    this.avatar,
    this.addressStore,
    this.ratingStar,
    this.lat,
    this.lng,
    this.hotline,
    this.openTime,
    this.closeTime,
    this.googleReviewLink,
    this.ownerId,
    this.productIds,
    this.productsNames,
    this.imageUrls,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.isFavorite,
  });

  @override
  StoreEntity transfer() => StoreEntity(
        id: id ?? 0,
        storeName:
            storeName != null && storeName!.isNotEmpty ? storeName : null,
        avatar: avatar != null && avatar!.isNotEmpty ? avatar : null,
        addressStore: addressStore != null && addressStore!.isNotEmpty
            ? addressStore
            : null,
        ratingStar: ratingStar ?? 0,
        lat: lat ?? 0,
        lng: lng ?? 0,
        hotline: hotline != null && hotline!.isNotEmpty ? hotline : null,
        openTime: openTime != null && openTime!.isNotEmpty ? openTime : null,
        closeTime:
            closeTime != null && closeTime!.isNotEmpty ? closeTime : null,
        googleReviewLink:
            googleReviewLink != null && googleReviewLink!.isNotEmpty
                ? googleReviewLink
                : null,
        ownerId: ownerId != null && ownerId!.isNotEmpty ? ownerId : null,
        productIds: productIds ?? [],
        productsNames: productsNames ?? [],
        imageUrls: imageUrls ?? [],
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
        isFavorite: isFavorite ?? false,
      );
}

@JsonSerializable()
class StoreListModel extends BaseListModel<StoreModel>
    implements Transfer<StoreListEntity> {
  StoreListModel({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });

  factory StoreListModel.fromJson(Map<String, dynamic> json) =>
      _$StoreListModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreListModelToJson(this);

  @override
  StoreListEntity transfer() => StoreListEntity(
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
