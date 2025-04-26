import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';
import 'package:nasmobile/feature/domain/repositories/user_repository.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:typewritertext/typewritertext.dart';

enum ChatType { user, gemini }

class ChatItem {
  final String text;
  final ChatType chatType;
  final TypeWriterController? typeWriterController;

  ChatItem({
    required this.text,
    required this.chatType,
    this.typeWriterController,
  });
}

class ChatGeminiController extends BaseController {
  late UserRepository _userRepository;
  final apiKey = 'AIzaSyCoccvbMYthEQafgvMEleKnzUNuEF9du7M';
  final textSend = TextEditingController();
  final chats = <ChatItem>[].obs;
  final isShowLoadingMessage = false.obs;
  final ItemScrollController itemScrollController = ItemScrollController();
  final Rxn<UserRegisterEntity> user = Rxn();

  @override
  void onInit() async {
    _userRepository = Get.find();
    Gemini.init(apiKey: apiKey);
    await getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    showLoading();
    final result = await _userRepository.getProfile();
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    user.value = result.asRight();
  }

  Future<void> sendQuestion() async {
    try {
      isShowLoadingMessage.value = true;

      if (textSend.text.isEmpty) {
        isShowLoadingMessage.value = false;
        showErrorDialog(content: S.current.pleaseEnterText);
        return;
      }

      chats.add(
        ChatItem(
          text: textSend.text,
          chatType: ChatType.user,
        ),
      );
      if (chats.length != 1) {
        itemScrollController.jumpTo(index: chats.length - 1);
      }

      await Gemini.instance.prompt(parts: [
        Part.text(textSend.text),
      ]).then((value) {
        textSend.clear();
        isShowLoadingMessage.value = false;
        if (value != null && value.output != null && value.output!.isNotEmpty) {
          chats.add(
            ChatItem(
              text: value.output!,
              chatType: ChatType.gemini,
              typeWriterController: TypeWriterController(
                text: value.output!,
                duration: const Duration(milliseconds: 10),
              ),
            ),
          );
          itemScrollController.jumpTo(index: chats.length - 1);
        }
      });
    } catch (e) {
      isShowLoadingMessage.value = false;
      showErrorDialog(
        content: e.toString(),
      );
    }
  }
}
