import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/core/network/exception/network_exceptions.dart';
import 'package:nasmobile/feature/data/datasources/store_datasource.dart';
import 'package:nasmobile/feature/data/models/request/get_list_store_request.dart';
import 'package:nasmobile/feature/data/models/request/get_list_technician_request.dart';
import 'package:nasmobile/feature/data/models/request/like_store_request.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/entities/technician_entity.dart';
import 'package:nasmobile/feature/domain/repositories/store_repository.dart';
import 'package:nasmobile/generated/l10n.dart';

class StoreRepositoryImpl extends StoreRepository {
  @override
  Future<Either<Failure, StoreListEntity>> getListStore({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await StoreDatasource.to.getListStore(
        request: GetListStoreRequest(
          pageNumber: pageNumber,
          pageSize: pageSize,
          searchText: searchText,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getListStoreFailed,
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
  Future<Either<Failure, StoreEntity>> getStoreDetail({required int id}) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await StoreDatasource.to.getStoreDetail(id: id);

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getStoreDetailFailed,
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
  Future<Either<Failure, TechnicianListEntity>> getListTechnician({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
    int? storeId,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await StoreDatasource.to.getListTechnician(
        request: GetListTechnicianRequest(
          pageNumber: pageNumber,
          pageSize: pageSize,
          searchText: searchText,
          storeId: storeId,
        ),
      );

      if (response.succeeded) {
        return right(response.data!.transfer());
      }

      return left(ServerFailure(
        response.message ?? S.current.getListTechnicianFailed,
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
  Future<Either<Failure, bool>> likeStore({
    required int id,
    required bool isFavorite,
  }) async {
    try {
      // if (!(await network.isConnect)) {
      //   return left(NetworkFailure(S.current.noInternet));
      // }

      final response = await StoreDatasource.to.likeStore(
        request: LikeStoreRequest(
          id: id,
          isFavorite: isFavorite,
        ),
      );

      if (response.succeeded) {
        return right(response.succeeded);
      }

      return left(ServerFailure(
        response.message ?? S.current.likeStoreFailed,
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
