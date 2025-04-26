import 'package:get/get.dart';
import 'package:nasmobile/feature/domain/entities/base_list_entity.dart';

class StoreEntity {
  final int id;
  final String? storeName;
  final String? avatar;
  final String? addressStore;
  final int ratingStar;
  final double lat;
  final double lng;
  final String? hotline;
  final String? openTime;
  final String? closeTime;
  final String? googleReviewLink;
  final String? ownerId;
  final List<int> productIds;
  final List<String> productsNames;
  final List<String> imageUrls;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final bool isFavorite;

  RxDouble distance = 0.0.obs;

  StoreEntity({
    this.id = 0,
    this.storeName,
    this.avatar,
    this.addressStore,
    this.ratingStar = 0,
    this.lat = 0,
    this.lng = 0,
    this.hotline,
    this.openTime,
    this.closeTime,
    this.googleReviewLink,
    this.ownerId,
    this.productIds = const [],
    this.productsNames = const [],
    this.imageUrls = const [],
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.isFavorite = false,
  });

  StoreEntity copyWith({
    int? id,
    String? storeName,
    String? avatar,
    String? addressStore,
    int? ratingStar,
    double? lat,
    double? lng,
    String? hotline,
    String? openTime,
    String? closeTime,
    String? googleReviewLink,
    String? ownerId,
    List<int>? productIds,
    List<String>? productsNames,
    List<String>? imageUrls,
    DateTime? created,
    String? createdBy,
    DateTime? lastModified,
    String? lastModifiedBy,
    bool? isFavorite,
  }) =>
      StoreEntity(
        id: id ?? this.id,
        storeName: storeName ?? this.storeName,
        avatar: avatar ?? this.avatar,
        addressStore: addressStore ?? this.addressStore,
        ratingStar: ratingStar ?? this.ratingStar,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        hotline: hotline ?? this.hotline,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
        googleReviewLink: googleReviewLink ?? this.googleReviewLink,
        ownerId: ownerId ?? this.ownerId,
        productIds: productIds ?? this.productIds,
        productsNames: productsNames ?? this.productsNames,
        imageUrls: imageUrls ?? this.imageUrls,
        created: created ?? this.created,
        createdBy: createdBy ?? this.createdBy,
        lastModified: lastModified ?? this.lastModified,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

class StoreListEntity extends BaseListEntity<StoreEntity> {
  StoreListEntity({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });
}
