import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';
import 'package:nasmobile/feature/domain/repositories/news_repository.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailController extends BaseController {
  late NewsRepository _newsRepository;
  final Rxn<PostEntity> news = Rxn();

  @override
  void onInit() async {
    _newsRepository = Get.find();
    await mappingData();
    super.onInit();
  }

  Future<void> mappingData() async {
    if (Get.arguments == null) return;
    if (Get.arguments is! PostEntity) return;
    await getPostDetail(id: (Get.arguments as PostEntity).id);
  }

  Future<void> getPostDetail({required int id}) async {
    showLoading();
    final result = await _newsRepository.getPostDetail(id: id);
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    news.value = result.asRight();
  }

  Future<void> shareNews() async {
    await Share.share(
      'Link bài viết: https://simplepage.vn/blog/bai-viet-quang-cao-nail',
    );
  }

  Future<void> likePost() async {
    final result = await _newsRepository.likePost(
      id: news.value!.id,
      isFavorite: !news.value!.isFavorite,
    );

    if (result.asRight()) {
      news.value = news.value!.copyWith(isFavorite: !news.value!.isFavorite);
      news.refresh();
    }
  }
}
