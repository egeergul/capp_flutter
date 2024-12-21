import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  late ChatService chatService;
  final Rx<Chat> chat = Chat.empty().obs;

  // Text Field Params
  final FocusNode focusNode = FocusNode();
  final RxBool hasFocus = false.obs;
  final RxString typedText = "".obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    if (Get.arguments['chatService'] != null) {
      chatService = Get.arguments['chatService'];
    } else if (Get.arguments['chat'] != null) {
      chatService = ChatService();
      chatService.initChat(Get.arguments['chat']);
    } else {
      // TODO NavigationService.showSnackbar(
      //     snackbar: SnackbarModel.somethingWentWrong());
      return Get.back();
    }

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

    bool interpretJsonStringMessages = false;
    if (chat.value.type == ChatType.colorPaletteDetector) {
      interpretJsonStringMessages = true;
    }
    chatService.sendMessage(
      message: message,
      expectMetadataResponse: interpretJsonStringMessages,
    );
    textController.clear();
    typedText.value = "";
  }
}
