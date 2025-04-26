import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/data/models/dto/message/message_model.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/chat_repository.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ChatDetailController extends BaseController {
  late UserRepository _userRepository;
  late ChatRepository _chatRepository;
  final textSend = TextEditingController();
  final isReadySend = false.obs;
  late StreamSubscription? _streamSubscription;
  final messages = <MessageEntity>[].obs;
  final Rxn<UserRegisterEntity> user = Rxn();
  final Rxn<UserRegisterEntity> userCurrent = Rxn();

  @override
  void onInit() async {
    _userRepository = Get.find();
    _chatRepository = Get.find();
    await init();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  Future<void> init() async {
    if (Get.arguments != null && Get.arguments is UserRegisterEntity) {
      user.value = Get.arguments;
    }

    /// Get user current
    await getCurrentUser();

    /// Listen get list messages
    _streamSubscription = _chatRepository
        .getMessages(chatRoomId: getChatRoom())
        .listen((messagesGet) {
      messages.value = messagesGet.docs
          .map((e) => MessageModel.fromJson(e.data()).transfer())
          .toList();
    });
  }

  Future<void> getCurrentUser() async {
    showLoading();
    final result = await _userRepository.getProfile();
    hideLoading();
    userCurrent.value = result.asRight();
  }

  String getChatRoom() {
    if (userCurrent.value!.id > user.value!.id) {
      return '${userCurrent.value?.id}_${user.value?.id}';
    }

    return '${user.value?.id}_${userCurrent.value?.id}';
  }

  // Rename File
  Future<File> renameFile(File originalFile, String newName) async {
    final directory = await getTemporaryDirectory();
    String newPath = path.join(directory.path, newName);
    return originalFile.copy(newPath);
  }

  Future<void> getImage({required ImageSource source}) async {
    try {
      final result = await ImagePicker().pickImage(source: source);
      if (result == null) return;
      LogUtil.logDebug('GET IMAGE ===> ${result.path}');
    } catch (e) {
      LogUtil.logDebug('Upload failed: $e');
    }
  }

  Future<void> sendMessage() async {
    try {
      final message = MessageEntity(
        currentMail: userCurrent.value?.email,
        receiverMail: user.value?.email,
        timestamp: DateTime.now(),
        content: textSend.text,
      );
      await _chatRepository.saveMessages(
        message: message,
        chatRoomId: getChatRoom(),
      );
      textSend.clear();
    } catch (e) {
      showErrorDialog(content: e.toString());
    }
  }
}
