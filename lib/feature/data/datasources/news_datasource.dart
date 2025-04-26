import 'package:dio/dio.dart';
import 'package:nasmobile/core/constants/app_url.dart';
import 'package:nasmobile/core/network/client/dio_client.dart';
import 'package:nasmobile/core/utils/replace_util.dart';
import 'package:nasmobile/feature/data/models/request/get_list_post_request.dart';
import 'package:nasmobile/feature/data/models/request/like_post_request.dart';
import 'package:nasmobile/feature/data/models/response/like_post/like_post_response.dart';
import 'package:nasmobile/feature/data/models/response/post/post_response.dart';
import 'package:nasmobile/feature/data/models/response/post_detail/post_detail_response.dart';

class NewsDatasource {
  static NewsDatasource get to => NewsDatasource();

  /// Get list post
  Future<PostResponse> getListPost({
    required GetListPostRequest request,
  }) async {
    final response = await DioClient.instance.get(
      AppUrl.postList,
      queryParameters: request.toJson(),
    );
    return PostResponse.fromJson(response.data);
  }

  /// Get post detail
  Future<PostDetailResponse> getPostDetail({
    required int id,
  }) async {
    final response = await DioClient.instance.get(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.postDetail,
        objectReplace: {"{id}": id.toString()},
      ),
    );
    return PostDetailResponse.fromJson(response.data);
  }

  /// Like post
  Future<LikePostResponse> likePost({
    required LikePostRequest request,
  }) async {
    final response = await DioClient.instance.put(
      ReplaceUtil.replaceUrlApi(
        url: AppUrl.likePost,
        objectReplace: {"{id}": request.id.toString()},
      ),
      data: FormData.fromMap(request.toJson()),
    );
    return LikePostResponse.fromJson(response.data);
  }
}
