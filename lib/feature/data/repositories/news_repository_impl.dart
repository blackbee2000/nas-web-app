import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/core/network/exception/network_exceptions.dart';
import 'package:nasmobile/feature/data/datasources/news_datasource.dart';
import 'package:nasmobile/feature/data/models/request/get_list_post_request.dart';
import 'package:nasmobile/feature/data/models/request/like_post_request.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';
import 'package:nasmobile/feature/domain/repositories/news_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class NewsRepositoryImpl extends NewsRepository {
  @override
  Future<Either<Failure, PostListEntity>> getListPost({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await NewsDatasource.to.getListPost(
        request: GetListPostRequest(
          pageNumber: pageNumber,
          pageSize: pageSize,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getListPostFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostDetail({required int id}) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await NewsDatasource.to.getPostDetail(id: id);

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getPostDetailFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> likePost({
    required int id,
    required bool isFavorite,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await NewsDatasource.to.likePost(
        request: LikePostRequest(
          id: id,
          isFavorite: isFavorite,
        ),
      );

      if (response.succeeded) {
        return right(response.succeeded);
      }

      return left(ServerFailure(
        response.message ?? S.current.likePostFailed,
      ));
    } catch (e) {
      final NetworkExceptions networkExceptions =
          NetworkExceptions.getDioException(e);
      return left(SystemFailure(
        NetworkExceptions.getErrorMessage(networkExceptions),
      ));
    }
  }
}
