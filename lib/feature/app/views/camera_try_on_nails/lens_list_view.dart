import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/no_data_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/lens_list_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class LensListView extends BaseView<LensListController> {
  const LensListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.lensList),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: Obx(
          () => controller.lens.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.lens.length,
                    itemBuilder: (ct, i) {
                      final item = controller.lens[i];
                      return GestureDetector(
                        onTap: () => controller.onTapItemLens(lens: item),
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: AppDimension.mediumSpace,
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                item.thumbnail?.first ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder: (ct, w, e) {
                                  if (e == null) return w;

                                  return Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.pink600.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.pink600,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (ct, o, s) => Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.pink600.withOpacity(0.2),
                                    shape: BoxShape.circle,
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
                              const SizedBox(width: AppDimension.mediumSpace),
                              TextWidget(
                                text: item.name != null && item.name!.isNotEmpty
                                    ? item.name!
                                    : S.current.notAvailable,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const NoDataWidget(),
        ),
      ),
    );
  }
}
