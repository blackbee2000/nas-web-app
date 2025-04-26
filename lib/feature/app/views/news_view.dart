import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/utils/decoration_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/news_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/post_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class NewsView extends BaseView<NewsController> {
  const NewsView({super.key});

  Widget _itemNewsFeed({required PostEntity news}) => GestureDetector(
        onTap: () async => await controller.onViewDetail(post: news),
        child: Container(
          width: double.infinity,
          height: 105,
          margin: controller.news.indexOf(news) == controller.news.length - 1
              ? EdgeInsets.zero
              : const EdgeInsets.only(
                  bottom: AppDimension.mediumSpace,
                ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimension.largeBorderRadius),
            border: Border.all(color: AppColors.disableButtonColor),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimension.largeBorderRadius),
                  bottomLeft: Radius.circular(AppDimension.largeBorderRadius),
                ),
                child: Image.network(
                  news.avatar ?? '',
                  width: 80,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (ct, w, e) {
                    if (e == null) return w;

                    return Container(
                      width: 80,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.pink600.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                          bottomLeft: Radius.circular(
                            AppDimension.largeBorderRadius,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.pink600,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (ct, o, s) => Container(
                    width: 80,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.pink600.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          AppDimension.largeBorderRadius,
                        ),
                        bottomLeft: Radius.circular(
                          AppDimension.largeBorderRadius,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        size: 30,
                        color: AppColors.errorColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(AppDimension.smallSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Date
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.brownA57B1E,
                              AppColors.brown723F00,
                              AppColors.brownCFA751,
                              AppColors.brownA27D27,
                              AppColors.brown8E6307,
                              AppColors.brown9A7014,
                            ],
                          ).createShader(bounds);
                        },
                        child: TextWidget(
                          text: controller.news.first.created != null
                              ? DateFormatUtil.parseToString(
                                  controller.news.first.created!,
                                )
                              : S.current.notAvailable,
                          fontSize: AppDimension.extraSmallFontSize,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimension.smallSpace / 2,
                      ),

                      /// Title
                      TextWidget(
                        text: controller.news.first.title ??
                            S.current.notAvailable,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondBlackText,
                      ),
                      const SizedBox(
                        height: AppDimension.smallSpace / 2,
                      ),

                      /// Description
                      TextWidget(
                        text: controller.news.first.description ??
                            S.current.notAvailable,
                        color: AppColors.tenBlackText,
                        maxlines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBarWidget(
        leadingWidth: 0,
        titleName: S.current.news,
        imagePath: AppPaths.backgroundAppBar,
        titleColor: Colors.white,
        heightAppBar: 110,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.mediumSpace,
            ),
            child: Obx(
              () => DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: TabBar(
                  indicator: RoundedTabIndicator(
                    color: Colors.white,
                    radius: AppDimension.largeBorderRadius,
                    indicatorHeight: 6,
                  ),
                  onTap: (value) {
                    controller.indexCurrentTab.value = value;
                  },
                  tabs: controller.tabs
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimension.mediumSpace,
                          ),
                          child: Opacity(
                            opacity: controller.indexCurrentTab.value ==
                                    controller.tabs.indexOf(e)
                                ? 1
                                : 0.7,
                            child: TextWidget(
                              text: e,
                              color: Colors.white,
                              fontSize: AppDimension.largeFontSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: Obx(
          () => NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.atEdge) {
                  bool isTop = notification.metrics.pixels == 0;
                  if (!isTop &&
                      controller.news.length < controller.totalCount.value) {
                    controller.loadMore();
                  }
                }
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async => await controller.getNews(),
              child: SingleChildScrollView(
                child: controller.news.isNotEmpty
                    ? Column(
                        children: [
                          /// Item first
                          GestureDetector(
                            onTap: () async => await controller.onViewDetail(
                              post: controller.news.first,
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppDimension.largeBorderRadius + 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  /// Image
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(
                                        AppDimension.largeBorderRadius + 4,
                                      ),
                                      topRight: Radius.circular(
                                        AppDimension.largeBorderRadius + 4,
                                      ),
                                    ),
                                    child: Image.network(
                                      controller.news.first.avatar ?? "",
                                      width: double.infinity,
                                      height: 160,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (ct, w, e) {
                                        if (e == null) return w;

                                        return Container(
                                          width: double.infinity,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            color: AppColors.pink600
                                                .withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(
                                                AppDimension.largeBorderRadius +
                                                    4,
                                              ),
                                              topRight: Radius.circular(
                                                AppDimension.largeBorderRadius +
                                                    4,
                                              ),
                                            ),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.pink600,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (ct, o, s) => Container(
                                        width: double.infinity,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          color: AppColors.pink600
                                              .withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(
                                              AppDimension.largeBorderRadius +
                                                  4,
                                            ),
                                            topRight: Radius.circular(
                                              AppDimension.largeBorderRadius +
                                                  4,
                                            ),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 30,
                                            color: AppColors.errorColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// Content
                                  Container(
                                    padding: const EdgeInsets.all(
                                      AppDimension.smallSpace,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Date
                                        ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                AppColors.brownA57B1E,
                                                AppColors.brown723F00,
                                                AppColors.brownCFA751,
                                                AppColors.brownA27D27,
                                                AppColors.brown8E6307,
                                                AppColors.brown9A7014,
                                              ],
                                            ).createShader(bounds);
                                          },
                                          child: TextWidget(
                                            text: controller
                                                        .news.first.created !=
                                                    null
                                                ? DateFormatUtil.parseToString(
                                                    controller
                                                        .news.first.created!,
                                                  )
                                                : S.current.notAvailable,
                                            fontSize:
                                                AppDimension.smallFontSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppDimension.smallSpace / 2,
                                        ),

                                        /// Title
                                        TextWidget(
                                          text: controller.news.first.title ??
                                              S.current.notAvailable,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondBlackText,
                                        ),
                                        const SizedBox(
                                          height: AppDimension.smallSpace / 2,
                                        ),

                                        /// Description
                                        TextWidget(
                                          text: controller
                                                  .news.first.description ??
                                              S.current.notAvailable,
                                          color: AppColors.nineBlackText,
                                          maxlines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimension.mediumSpace),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemCount: controller.news
                                .sublist(1, controller.news.length)
                                .length,
                            itemBuilder: (ct, i) {
                              final news = controller.news[i];
                              return _itemNewsFeed(
                                news: news,
                              );
                            },
                          ),
                        ],
                      )
                    : const NoDataWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
