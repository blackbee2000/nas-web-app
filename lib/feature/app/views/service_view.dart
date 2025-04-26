import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/service_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ServiceView extends BaseView<ServiceController> {
  const ServiceView({super.key});

  Widget _buildItemService() => GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.serviceDetail),
        child: Container(
          width: double.infinity,
          height: 138,
          margin: const EdgeInsets.only(bottom: AppDimension.smallSpace),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimension.largeBorderRadius + 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 0),
                blurRadius: 24,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    AppDimension.largeBorderRadius + 4,
                  ),
                  bottomLeft: Radius.circular(
                    AppDimension.largeBorderRadius + 4,
                  ),
                ),
                child: Image.network(
                  "https://www.lookme.vn/blog/wp-content/uploads/2021/01/nail-do-3.jpeg",
                  width: 168,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (ct, w, e) {
                    if (e == null) return w;

                    return Container(
                      width: 168,
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
                    width: 168,
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Tên của dịch vụ tối đa 2 dòng",
                        fontWeight: FontWeight.w500,
                        color: AppColors.sixBlackText,
                        maxlines: 3,
                      ),
                      SizedBox(height: AppDimension.smallSpace / 2),
                      Row(
                        children: [
                          RatingStars(
                            value: 5,
                            starCount: 1,
                            starSize: 16,
                            starColor: AppColors.yellowF4D550,
                            starOffColor: AppColors.greyText,
                            valueLabelVisibility: false,
                          ),
                          TextWidget(
                            text: "5(456 đánh giá)",
                            fontSize: AppDimension.smallFontSize,
                            color: AppColors.sevenBlackText,
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimension.smallSpace / 2),
                      TextWidget(
                        text: "Chỉ từ",
                        fontSize: AppDimension.smallFontSize,
                        color: AppColors.eightBlackText,
                      ),
                      SizedBox(height: AppDimension.smallSpace / 3),
                      TextWidget(
                        text: "2.000.000 đ",
                        fontWeight: FontWeight.w700,
                        color: AppColors.sixBlackText,
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
        colorLeading: Colors.white,
        titleName: S.current.service,
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
                          onChanged: (String? value) async {},
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimension.mediumSpace),
                    InkWell(
                      onTap: () {},
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          padding: const EdgeInsets.all(AppDimension.mediumSpace),
          itemCount: 10,
          itemBuilder: (ct, i) => _buildItemService(),
        ),
      ),
    );
  }
}
