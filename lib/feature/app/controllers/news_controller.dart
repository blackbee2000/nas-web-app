import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';
import 'package:nasmobile/feature/domain/repositories/news_repository.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';

class NewsController extends BaseController {
  late NewsRepository _newsRepository;
  final news = <PostEntity>[].obs;
  final _pageNumber = 1.obs;
  final _pageSize = 10;
  final totalCount = 0.obs;
  final tabs = [S.current.all, S.current.hot, S.current.favorite].obs;
  final indexCurrentTab = 0.obs;

  @override
  void onInit() async {
    _newsRepository = Get.find();
    await getNews();
    super.onInit();
  }

  Future<void> getNews() async {
    showLoading();
    _pageNumber.value = 1;

    final result = await _newsRepository.getListPost(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    news.value = result.asRight().items;
    totalCount.value = result.asRight().totalCount;
  }

  Future<void> loadMore() async {
    showLoading();
    _pageNumber.value += 1;

    final result = await _newsRepository.getListPost(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    final moreData = result.asRight().items;

    if (moreData.isNotEmpty) {
      news.addAll(moreData);
      news.refresh();
    }
  }

  Future<void> onViewDetail({required PostEntity post}) async {
    final result = await Get.toNamed(AppRoutes.newsDetail, arguments: post);

    if (result == null || result is! bool) return;

    if (result) {
      final result = await _newsRepository.getListPost();
      if (result.isLeft()) {
        showErrorDialog(content: result.asLeft().message);
        return;
      }

      news.value = result.asRight().items;
      news.refresh();
    }
  }

  Future<void> shareNews() async {
    await Share.share(
      'Link bài viết: https://simplepage.vn/blog/bai-viet-quang-cao-nail',
    );
  }

  Future<void> likePost({required PostEntity post}) async {
    final result = await _newsRepository.likePost(
      id: post.id,
      isFavorite: !post.isFavorite,
    );

    if (result.asRight()) {
      for (int i = 0; i < news.length; i++) {
        if (post.id == news[i].id) {
          news[i] = news[i].copyWith(isFavorite: !post.isFavorite);
        }
      }

      news.refresh();
    }
  }
}
