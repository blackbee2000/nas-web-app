import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';

abstract class NewsRepository {
  /// Get list post
  Future<Either<Failure, PostListEntity>> getListPost({
    int pageNumber = 1,
    int pageSize = 10,
  });

  /// Get post detail
  Future<Either<Failure, PostEntity>> getPostDetail({
    required int id,
  });

  /// Like post
  Future<Either<Failure, bool>> likePost({
    required int id,
    required bool isFavorite,
  });
}
