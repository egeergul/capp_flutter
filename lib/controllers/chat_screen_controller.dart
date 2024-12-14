import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  late String chatId;
  late ChatService chatService;
  final Rx<Chat> chat = Chat.empty().obs;

  // Text Field Params
  final FocusNode focusNode = FocusNode();
  final RxBool hasFocus = false.obs;
  final RxString typedText = "".obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    chatId = Get.arguments['chatId'] ?? "not_found";
    if (chatId == "not_found") {
      //TODO:   Handle chat not found
      Get.back();
      return;
    }

    if (Get.isRegistered(tag: chatId)) {
      chatService = Get.find<ChatService>(tag: chatId);
    } else {
      chatService = ChatService();
      await chatService.initChat(chatId: chatId);
      Get.put(chatService, tag: chatId);
    }
    //TODO: Handle chat service not found

    chat.value = chatService.chat.value;
    chatService.chat.listen((Chat inChat) {
      chat.value = inChat;
      chat.refresh();
    });

    focusNode.addListener(_listenFocusNode);

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.removeListener(_listenFocusNode);

    super.onClose();
  }

  void _listenFocusNode() {
    hasFocus.value = focusNode.hasFocus;
  }

  // onTaps
  void onTapSendButton() async {
    Message message =
        Message.fromValues(type: MessageType.user, content: typedText.value);
    chatService.sendMessage(message: message);
    textController.clear();
    typedText.value = "";
  }
}
