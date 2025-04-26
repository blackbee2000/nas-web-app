import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/chat_gemini_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatGeminiView extends BaseView<ChatGeminiController> {
  const ChatGeminiView({super.key});

  Widget _buildSuffixIcon({required IconData icon, VoidCallback? onTap}) =>
      IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: AppColors.pink600,
          size: 24,
        ),
      );

  Widget _itemChatUser({required ChatItem chat}) => Container(
        margin: const EdgeInsets.only(bottom: AppDimension.largeSpace),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 50),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(AppDimension.smallSpace),
                      decoration: BoxDecoration(
                        color: AppColors.pink600,
                        borderRadius: BorderRadius.circular(
                          AppDimension.mediumBorderRadius,
                        ),
                      ),
                      child: TextWidget(
                        text: chat.text,
                        maxlines: 1000000,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            controller.isShowLoadingMessage.value &&
                    controller.chats.indexOf(chat) ==
                        controller.chats.length - 1
                ? Container(
                    margin: const EdgeInsets.only(top: AppDimension.largeSpace),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.pink600,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: TextWidget(
                              text: 'GE',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: AppDimension.mediumSpace,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.pink50,
                            borderRadius: BorderRadius.circular(
                              AppDimension.mediumBorderRadius,
                            ),
                          ),
                          child: LottieBuilder.asset(
                            AppPaths.loadingMessage,
                            width: 65,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );

  Widget _itemChatGemini({required ChatItem chat}) => Container(
        margin: const EdgeInsets.only(bottom: AppDimension.largeSpace),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(AppDimension.mediumSpace),
                  decoration: BoxDecoration(
                    color: AppColors.pink50,
                    borderRadius: BorderRadius.circular(
                      AppDimension.mediumBorderRadius,
                    ),
                  ),
                  child: TextWidget(
                    text: chat.text,
                    maxlines: 1000000,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: "${S.current.chat} Gemini"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(context).viewPadding.bottom,
          ),
        ),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.chats.isNotEmpty
                    ? ScrollablePositionedList.builder(
                        itemScrollController: controller.itemScrollController,
                        padding: EdgeInsets.zero,
                        itemCount: controller.chats.length,
                        itemBuilder: (ct, i) {
                          final item = controller.chats[i];
                          return item.chatType == ChatType.user
                              ? _itemChatUser(chat: item)
                              : _itemChatGemini(chat: item);
                        },
                      )
                    : Center(
                        child: TextWidget(
                          text:
                              "Gemini, ${S.current.wellcome.substring(0, S.current.wellcome.length - 1).toLowerCase()} ${controller.user.value?.fullName != null ? controller.user.value!.fullName!.split(' ').last : S.current.notAvailable}!",
                          fontSize: AppDimension.largeFontSize * 1.5,
                          color: AppColors.pink600,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              TextFormFieldWidget(
                controller: controller.textSend,
                hintText: S.current.whatQuestion,
                suffixIcon: GestureDetector(
                  onTap: () async => await controller.sendQuestion(),
                  child: _buildSuffixIcon(icon: Icons.send),
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
