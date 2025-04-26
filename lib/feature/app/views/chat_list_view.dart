import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/utils/launcher_util.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_form_field_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/chat_list_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/generated/l10n.dart';

class ChatListView extends BaseView<ChatListController> {
  const ChatListView({super.key});

  Widget _buildPreIcon({required IconData icon, VoidCallback? onTap}) =>
      IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: AppColors.greyText,
          size: 24,
        ),
      );

  Widget _buildTabChat() => Column(
        children: [
          TextFormFieldWidget(
            controller: controller.search,
            hintText: S.current.search,
            prefixIcon: _buildPreIcon(icon: Icons.search),
            onChanged: controller.onChangeSearch,
          ),
          const SizedBox(height: AppDimension.largeSpace),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.users.length,
                  itemBuilder: (ct, i) {
                    final item = controller.users[i];
                    return GestureDetector(
                      onTap: () => controller.goChat(user: item),
                      child: Container(
                        margin: i == controller.users.length - 1
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(
                                bottom: AppDimension.mediumSpace,
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                item.avatar ?? '',
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
                            ),
                            const SizedBox(width: AppDimension.smallSpace),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        item.fullName ?? S.current.notAvailable,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppDimension.largeFontSize,
                                  ),
                                  const SizedBox(
                                      height: AppDimension.smallSpace / 2),
                                  TextWidget(
                                    text: item.finalMessage != null
                                        ? controller.userCurrent.value!.email ==
                                                item.finalMessage!.currentMail
                                            ? 'Bạn: ${item.finalMessage?.content ?? ''}'
                                            : item.finalMessage?.content ?? ''
                                        : S.current.notAvailable,
                                    color: AppColors.greyText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppDimension.smallSpace),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  color: AppColors.pink600,
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildTabContact() => Column(
        children: [
          TextFormFieldWidget(
            controller: controller.search,
            hintText: S.current.search,
            prefixIcon: _buildPreIcon(icon: Icons.search),
            onChanged: controller.onChangeSearch,
          ),
          const SizedBox(height: AppDimension.largeSpace),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.users.length,
                  itemBuilder: (ct, i) {
                    final item = controller.users[i];
                    return GestureDetector(
                      onTap: () async => await controller.showBaseBottomSheet(
                        widget: _buildOptionContact(item: item),
                      ),
                      child: Container(
                        margin: i == controller.users.length - 1
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(
                                bottom: AppDimension.mediumSpace,
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                item.avatar ?? '',
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
                            ),
                            const SizedBox(width: AppDimension.smallSpace),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        item.fullName ?? S.current.notAvailable,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppDimension.largeFontSize,
                                  ),
                                  const SizedBox(
                                      height: AppDimension.smallSpace / 2),
                                  const TextWidget(
                                    text: 'Hoạt động',
                                    color: AppColors.greyText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildOptionContact({required UserRegisterEntity item}) => Container(
        width: MediaQuery.of(Get.context!).size.width,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(Get.context!).viewPadding.bottom,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimension.largeBorderRadius),
            topRight: Radius.circular(AppDimension.largeBorderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                await LauncherUtil.launchCall(
                  item.phone ?? '',
                );
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone,
                    size: 22,
                    color: AppColors.blackText,
                  ),
                  const SizedBox(width: AppDimension.mediumBorderRadius),
                  TextWidget(text: S.current.phoneCall),
                ],
              ),
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            GestureDetector(
              onTap: () {
                Get.back();
                controller.goChat(user: item);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.message,
                    size: 22,
                    color: AppColors.blackText,
                  ),
                  const SizedBox(width: AppDimension.mediumBorderRadius),
                  TextWidget(text: S.current.message),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.chat),
      bottomNavigationBar: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Platform.isAndroid ? 70 : 100,
          child: BottomNavigationBar(
            currentIndex: controller.indexCurrentTab.value,
            onTap: controller.onChangeTab,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: AppDimension.smallSpace),
                  child: SvgPicture.asset(
                    AppPaths.icAccount,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      controller.indexCurrentTab.value == 0
                          ? AppColors.pink600
                          : AppColors.greyText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: AppDimension.smallSpace),
                  child: SvgPicture.asset(
                    AppPaths.icChat,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      controller.indexCurrentTab.value == 1
                          ? AppColors.pink600
                          : AppColors.greyText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          AppDimension.mediumSpace,
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            _buildTabContact(),
            _buildTabChat(),
          ],
        ),
      ),
    );
  }
}
