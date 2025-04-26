import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/chat_detail_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetailView extends BaseView<ChatDetailController> {
  const ChatDetailView({super.key});

  Widget _buildSuffixIcon({required IconData icon, VoidCallback? onTap}) =>
      IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: AppColors.pink600,
          size: 30,
        ),
      );

  Widget _itemChatUser({required MessageEntity message}) => Container(
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
                        text: message.content ?? S.current.notAvailable,
                        maxlines: 1000000,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _itemChatGemini({required MessageEntity message}) => Container(
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
                    text: message.content ?? S.current.notAvailable,
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
      appBar: AppBarWidget(
        titleName: '',
        centerTitle: false,
        customeTitle: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                controller.user.value?.avatar ?? '',
                width: 45,
                height: 45,
                fit: BoxFit.cover,
                loadingBuilder: (ct, w, e) {
                  if (e == null) return w;

                  return Container(
                    width: 45,
                    height: 45,
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
                  width: 45,
                  height: 45,
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
            ),
            const SizedBox(width: AppDimension.smallSpace),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text:
                        controller.user.value?.email ?? S.current.notAvailable,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: AppDimension.smallSpace / 2),
                  const TextWidget(
                    text: 'Hoạt động',
                    color: AppColors.greyText,
                    fontSize: AppDimension.smallFontSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: ScrollablePositionedList.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.messages.length,
                  itemBuilder: (ct, i) {
                    final item = controller.messages[i];
                    final isNowUser =
                        item.currentMail == controller.userCurrent.value?.email;
                    return isNowUser
                        ? _itemChatUser(message: item)
                        : _itemChatGemini(message: item);
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    controller: controller.textSend,
                    hintText: S.current.whatQuestion,
                    maxLines: null,
                    onChanged: (String? value) {
                      controller.isReadySend.value =
                          value != null && value.isNotEmpty;
                    },
                  ),
                ),
                const SizedBox(width: AppDimension.smallSpace),
                Obx(
                  () => controller.isReadySend.value
                      ? GestureDetector(
                          onTap: () async => await controller.sendMessage(),
                          child: _buildSuffixIcon(icon: Icons.send),
                        )
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: () async => await controller.getImage(
                                source: ImageSource.camera,
                              ),
                              child: _buildSuffixIcon(
                                icon: Icons.camera_enhance_rounded,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async => await controller.getImage(
                                source: ImageSource.gallery,
                              ),
                              child: _buildSuffixIcon(
                                icon: Icons.image_rounded,
                              ),
                            )
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
