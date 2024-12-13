import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/chat_service.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  late String chatId;
  late ChatService chatService;
  final Rx<Chat> chat = Chat.empty().obs;

  @override
  void onInit() async {
    chatId = Get.arguments['chatId'] ?? "not_found";
    if (chatId == "not_found") {
      //TODO:   Handle chat not found
      Get.back();
      return;
    }

    print("EGE $chatId");

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
    });

    print('ChatScreenController Created');

    super.onInit();
  }

  @override
  void onClose() {
    print('ChatScreenController Closed');
    super.onClose();
  }
}
