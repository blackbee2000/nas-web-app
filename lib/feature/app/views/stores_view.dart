import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/stores_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class StoresView extends BaseView<StoresController> {
  const StoresView({super.key});

  Widget _itemTab({required String item}) => InkWell(
        borderRadius: BorderRadius.circular(
          AppDimension.largeBorderRadius + 4,
        ),
        onTap: () {
          controller.indexCurrentTab.value = controller.tabs.indexOf(item);
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.mediumSpace,
            ),
            margin: controller.tabs.indexOf(item) == controller.tabs.length - 1
                ? EdgeInsets.zero
                : const EdgeInsets.only(
                    right: AppDimension.smallSpace / 2,
                  ),
            decoration: BoxDecoration(
              color: controller.indexCurrentTab.value ==
                      controller.tabs.indexOf(item)
                  ? null
                  : AppColors.disableButtonColor,
              borderRadius: BorderRadius.circular(
                AppDimension.largeBorderRadius + 4,
              ),
              gradient: controller.indexCurrentTab.value ==
                      controller.tabs.indexOf(item)
                  ? const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.brownA57B1E,
                        AppColors.brown723F00,
                        AppColors.brownCFA751,
                        AppColors.brownA27D27,
                        AppColors.brown8E6307,
                        AppColors.brown9A7014,
                      ],
                    )
                  : null,
            ),
            child: Center(
              child: TextWidget(
                text: item,
                color: controller.indexCurrentTab.value ==
                        controller.tabs.indexOf(item)
                    ? Colors.white
                    : AppColors.thirdBlackText,
              ),
            ),
          ),
        ),
      );

  Widget _itemStore({required StoreEntity store}) => InkWell(
        onTap: () async => await controller.onViewDetail(store: store),
        child: Container(
          width: double.infinity,
          height: 235,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius + 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(4, 0),
                blurRadius: 32,
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
                  store.avatar ?? "",
                  width: double.infinity,
                  height: 138,
                  fit: BoxFit.cover,
                  loadingBuilder: (ct, w, e) {
                    if (e == null) return w;

                    return Container(
                      width: double.infinity,
                      height: 138,
                      decoration: BoxDecoration(
                        color: AppColors.pink600.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            AppDimension.largeBorderRadius + 4,
                          ),
                          topRight: Radius.circular(
                            AppDimension.largeBorderRadius + 4,
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
                    height: 138,
                    decoration: BoxDecoration(
                      color: AppColors.pink600.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          AppDimension.largeBorderRadius + 4,
                        ),
                        topRight: Radius.circular(
                          AppDimension.largeBorderRadius + 4,
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

              Container(
                padding: const EdgeInsets.all(
                  AppDimension.mediumSpace,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Store name
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: store.storeName ?? S.current.notAvailable,
                            fontWeight: FontWeight.w500,
                            color: AppColors.sixBlackText,
                          ),
                        ),
                        Row(
                          children: [
                            TextWidget(
                              text: store.ratingStar.toString(),
                              fontSize: AppDimension.smallFontSize,
                              color: AppColors.eightBlackText,
                            ),
                            const RatingStars(
                              value: 5,
                              starCount: 1,
                              starSize: 16,
                              starColor: AppColors.yellowF4D550,
                              starOffColor: AppColors.greyText,
                              valueLabelVisibility: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.smallSpace),

                    /// Address
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppPaths.icAddress,
                          width: 16,
                          height: 16,
                        ),
                        Expanded(
                          child: TextWidget(
                            text: store.addressStore ?? S.current.notAvailable,
                            fontSize: AppDimension.smallFontSize,
                            color: AppColors.eightBlackText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimension.smallSpace),

                    /// Phone
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppPaths.icPhone,
                          width: 16,
                          height: 16,
                        ),
                        Expanded(
                          child: TextWidget(
                            text: store.hotline ?? S.current.notAvailable,
                            fontSize: AppDimension.smallFontSize,
                            color: AppColors.eightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ],
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
        titleName: S.current.store,
        imagePath: AppPaths.backgroundAppBar,
        titleColor: Colors.white,
        heightAppBar: 130,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimension.mediumSpace,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius * 10,
                          ),
                          color: Colors.white,
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
                        child: TextFormFieldWidget(
                          isBorder: false,
                          controller: controller.search,
                          hintText: S.current.search,
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(
                              AppDimension.smallSpace + 2,
                            ),
                            child: SvgPicture.asset(
                              AppPaths.icSearch,
                            ),
                          ),
                          onChanged: (String? value) async {
                            if (value != null) {
                              await controller.onSearch(value: value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimension.mediumSpace),
                    InkWell(
                      onTap: () async => await controller.showFilter(),
                      borderRadius: BorderRadius.circular(
                        AppDimension.largeBorderRadius + 3,
                      ),
                      child: Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(
                          AppDimension.smallSpace + 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius + 3,
                          ),
                          color: Colors.white,
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
                        child: SvgPicture.asset(
                          AppPaths.icFilter,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.mediumSpace),
              ],
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
        child: Column(
          children: [
            /// Tab
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.tabs.length,
                  itemBuilder: (ct, i) => _itemTab(item: controller.tabs[i]),
                ),
              ),
            ),
            const SizedBox(height: AppDimension.mediumSpace),

            /// List
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () async => await controller.getStores(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppDimension.mediumSpace,
                      mainAxisSpacing: AppDimension.mediumSpace,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2 - 32) / 235,
                    ),
                    itemCount: controller.stores.length,
                    itemBuilder: (ct, i) => _itemStore(
                      store: controller.stores[i],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
