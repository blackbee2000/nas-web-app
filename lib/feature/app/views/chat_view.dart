import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/chat_controller.dart';
import 'package:nasmobile/feature/app/controllers/other_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class ChatView extends BaseView<ChatController> {
  const ChatView({super.key});

  Widget _itemCategory({
    required CategoryItem item,
    bool isBorderTop = false,
  }) =>
      InkWell(
        onTap: () => Get.toNamed(item.route),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimension.mediumSpace,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppPaths.icChat,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackText,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppDimension.smallSpace),
                  TextWidget(
                    text: item.title,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimension.largeFontSize,
                  ),
                ],
              ),
              const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: AppColors.blackText,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.chat),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: Column(
          children: [
            CategoryItem(
              title: '${S.current.chat} Gemini',
              icon: '',
              route: AppRoutes.chatGeminiScreen,
            ),
            CategoryItem(
              title: S.current.chat,
              icon: '',
              route: AppRoutes.chatList,
            ),
          ]
              .asMap()
              .entries
              .map(
                (e) => _itemCategory(
                  isBorderTop: e.key == 0 ? true : false,
                  item: e.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
