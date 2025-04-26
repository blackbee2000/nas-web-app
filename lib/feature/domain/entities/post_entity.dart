import 'package:nasmobile/feature/domain/entities/base_list_entity.dart';

class PostEntity {
  final int id;
  final String? title;
  final int userId;
  final String? avatar;
  final String? content;
  final String? description;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final bool isFavorite;

  PostEntity({
    this.id = 0,
    this.title,
    this.userId = 0,
    this.avatar,
    this.content,
    this.description,
    this.created,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.isFavorite = false,
  });

  PostEntity copyWith({
    int? id,
    String? title,
    int? userId,
    String? avatar,
    String? content,
    String? description,
    DateTime? created,
    String? createdBy,
    DateTime? lastModified,
    String? lastModifiedBy,
    bool? isFavorite,
  }) =>
      PostEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        userId: userId ?? this.userId,
        avatar: avatar ?? this.avatar,
        content: content ?? this.content,
        description: description ?? this.description,
        created: created ?? this.created,
        createdBy: createdBy ?? this.createdBy,
        lastModified: lastModified ?? this.lastModified,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

class PostListEntity extends BaseListEntity<PostEntity> {
  PostListEntity({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });
}
