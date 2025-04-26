import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/feature/data/models/dto/base_list_model.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel implements Transfer<PostEntity> {
  final int? id;
  final String? title;
  final int? userId;
  final String? avatar;
  final String? content;
  final String? description;
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final bool? isFavorite;

  PostModel({
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
    this.isFavorite,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  PostEntity transfer() => PostEntity(
        id: id ?? 0,
        title: title != null && title!.isNotEmpty ? title : null,
        userId: userId ?? 0,
        avatar: avatar != null && avatar!.isNotEmpty ? avatar : null,
        content: content != null && content!.isNotEmpty ? content : null,
        description:
            description != null && description!.isNotEmpty ? description : null,
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
class PostListModel extends BaseListModel<PostModel>
    implements Transfer<PostListEntity> {
  PostListModel({
    required super.items,
    super.pageNumber,
    super.totalPages,
    super.totalCount,
    super.hasPreviousPage,
    super.hasNextPage,
  });

  factory PostListModel.fromJson(Map<String, dynamic> json) =>
      _$PostListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostListModelToJson(this);

  @override
  PostListEntity transfer() => PostListEntity(
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
