import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/date_format_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/view_rating_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ViewRatingView extends BaseView<ViewRatingController> {
  const ViewRatingView({super.key});

  Widget _buildItemRating() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppDimension.mediumSpace),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.fourBorder),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDimension.largeBorderRadius * 100,
                  ),
                  child: Image.network(
                    "https://www.lookme.vn/blog/wp-content/uploads/2021/01/nail-do-3.jpeg",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    loadingBuilder: (ct, w, e) {
                      if (e == null) return w;

                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.pink600.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppDimension.largeBorderRadius * 100,
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.pink600.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimension.largeBorderRadius * 100,
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
              ],
            ),
            const SizedBox(width: AppDimension.smallSpace),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'minyoongibts0903',
                  fontSize: AppDimension.largeFontSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.fifBlackText,
                ),
                const SizedBox(height: AppDimension.smallSpace / 3),
                TextWidget(
                  text: DateFormatUtil.parseToString(DateTime.now()),
                  fontSize: AppDimension.smallFontSize,
                  color: AppColors.fourGreyText,
                ),
              ],
            ),
            const SizedBox(height: AppDimension.smallSpace),
            const RatingStars(
              value: 5,
              starCount: 5,
              starSize: 16,
              starColor: AppColors.yellowF4D550,
              starOffColor: AppColors.greyText,
              valueLabelVisibility: false,
            ),
            const TextWidget(
              text: 'Đỉnh qué không chê vào đâu được ạ. Lần đầu'
                  'mua hàng giá trị cao nhưng ok lắm',
              fontSize: AppDimension.largeFontSize,
              color: AppColors.fourGreyText,
              maxlines: 10,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondGreyBackground,
      appBar: AppBarWidget(
        colorLeading: Colors.white,
        titleName: S.current.rating,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: S.current.total,
                fontSize: AppDimension.largeFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.sixBlackText,
              ),
              const SizedBox(height: AppDimension.smallSpace / 2),
              const Row(
                children: [
                  RatingStars(
                    value: 5,
                    starCount: 1,
                    starSize: 16,
                    starColor: AppColors.yellowF4D550,
                    starOffColor: AppColors.greyText,
                    valueLabelVisibility: false,
                  ),
                  SizedBox(width: AppDimension.smallSpace / 2),
                  TextWidget(
                    text: "4.9/5",
                    fontSize: AppDimension.largeFontSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.thirdBlackText,
                  ),
                  TextWidget(
                    text: " (456 đánh giá)",
                    color: AppColors.sevenBlackText,
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.mediumSpace),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (ct, i) => _buildItemRating(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
