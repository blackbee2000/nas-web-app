import 'package:dio/dio.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/network/client/dio_client.dart';
import 'package:nasmobile/core/utils/replace_util.dart';
import 'package:nasmobile/feature/data/models/request/get_list_store_request.dart';
import 'package:nasmobile/feature/data/models/request/get_list_technician_request.dart';
import 'package:nasmobile/feature/data/models/request/like_store_request.dart';
import 'package:nasmobile/feature/data/models/response/like_store/like_store_response.dart';
import 'package:nasmobile/feature/data/models/response/store/store_response.dart';
import 'package:nasmobile/feature/data/models/response/store_detail/store_detail_response.dart';
import 'package:nasmobile/feature/data/models/response/technician/technician_response.dart';

class StoreDatasource {
  static StoreDatasource get to => StoreDatasource();

  /// Get list store
  Future<StoreResponse> getListStore({
    required GetListStoreRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.storeList,
      queryParameters: request.toJson(),
    );
    return StoreResponse.fromJson(response.data);
  }

  /// Get store detail
  Future<StoreDetailResponse> getStoreDetail({
    required int id,
  }) async {
    final response = await DioClient.instance.get(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.storeDetail,
        objectReplace: {"{id}": id.toString()},
      ),
    );
    return StoreDetailResponse.fromJson(response.data);
  }

  /// Get list technician
  Future<TechnicianResponse> getListTechnician({
    required GetListTechnicianRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.technicianList,
      queryParameters: request.toJson(),
    );
    return TechnicianResponse.fromJson(response.data);
  }

  /// Like store
  Future<LikeStoreResponse> likeStore({
    required LikeStoreRequest request,
  }) async {
    final response = await DioClient.instance.put(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.likeStore,
        objectReplace: {"{id}": request.id.toString()},
      ),
      data: FormData.fromMap(request.toJson()),
    );
    return LikeStoreResponse.fromJson(response.data);
  }
}
