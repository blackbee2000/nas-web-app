import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/entities/technician_entity.dart';

abstract class StoreRepository {
  /// Get list store
  Future<Either<Failure, StoreListEntity>> getListStore({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
  });

  /// Get store detail
  Future<Either<Failure, StoreEntity>> getStoreDetail({
    required int id,
  });

  /// Get list technician
  Future<Either<Failure, TechnicianListEntity>> getListTechnician({
    int pageNumber = 1,
    int pageSize = 10,
    String searchText = "",
    int? storeId,
  });

  /// Like store
  Future<Either<Failure, bool>> likeStore({
    required int id,
    required bool isFavorite,
  });
}
