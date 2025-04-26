import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/utils/test_database_service.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/data/models/dto/message/message_model.dart';
import 'package:nasmobile/feature/data/models/dto/user_register/user_register_model.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/chat_repository.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';

class ChatListController extends BaseController {
  late UserRepository _userRepository;
  late ChatRepository _chatRepository;
  final indexCurrentTab = 1.obs;
  late PageController pageController;
  final search = TextEditingController();
  final users = <UserRegisterEntity>[].obs;
  late StreamSubscription? streamSubscription;
  final Rxn<UserRegisterEntity> userCurrent = Rxn();

  @override
  void onInit() async {
    _userRepository = Get.find();
    _chatRepository = Get.find();
    pageController = PageController(initialPage: indexCurrentTab.value);

    /// Get user current
    await getCurrentUser();

    // /// Get users
    streamSubscription = TestDatabaseService()
        .fetchUserStream(userCurrent.value?.email ?? '')
        .listen((data) {
      users.value = data.docs
          .map((e) => UserRegisterModel.fromJson(e.data()).transfer())
          .toList();

      /// Mapping final message
      // mappingFinalMessage();
    });
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  void onChangeTab(int index) {
    indexCurrentTab.value = index;
    pageController.jumpToPage(index);
  }

  Future<void> getCurrentUser() async {
    showLoading();
    final result = await _userRepository.getProfile();
    hideLoading();
    userCurrent.value = result.asRight();
  }

  void goChat({required UserRegisterEntity user}) {
    Get.toNamed(AppRoutes.chatDetail, arguments: user);
  }

  String getChatRoom({required UserRegisterEntity user}) {
    if (userCurrent.value!.id > user.id) {
      return '${userCurrent.value?.id}_${user.id}';
    }

    return '${user.id}_${userCurrent.value?.id}';
  }

  void mappingFinalMessage() {
    for (int i = 0; i < users.length; i++) {
      _chatRepository
          .getMessages(chatRoomId: getChatRoom(user: users[i]))
          .listen((messagesGet) {
        users[i] = users[i].copyWith(
          finalMessage: messagesGet.docs
                  .map((e) => MessageModel.fromJson(e.data()).transfer())
                  .toList()
                  .isNotEmpty
              ? messagesGet.docs
                  .map((e) => MessageModel.fromJson(e.data()).transfer())
                  .toList()
                  .last
              : null,
        );
      });
    }
  }

  void onChangeSearch(String? value) {
    showAppInprogress();
  }
}
