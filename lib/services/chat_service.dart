import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/services/history_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ChatService extends GetxController {
  late Rx<Chat> chat;

  Future<Chat?> initChat({
    required String chatId,
  }) async {
    chat = Chat.empty().obs;
    Chat? c = await Api.instance.getChat(id: chatId);
    if (c == null) return null;
    chat.value = c;
    return c;
  }

  Future<Chat?> createChat() async {
    // Check if the user can create a new chat
    if (!userService.canCreateChat) return null;

    // Create a new chat
    Chat c = await Api.instance.createChat(deviceId: userService.deviceId);
    chat = c.obs;

    await userService.incrementTotalChats();
    historyService.addChat(c);

    return c;
  }

  Future<void> sendMessage({
    required Message message,
  }) async {
    Future<Chat> futureChat = Api.instance.sendMessage(
      user: userService.user,
      chat: chat.value,
      message: message,
    );

    // Wait for the message to be responden by BE
    chat.value = await futureChat;
    chat.refresh();

    // Update the chat in the chat history
    historyService.updateChat(chat.value);
  }

  Future<void> sendInitialImageAnalyserChatMessage({
    required String base64File,
  }) async {
    // Send the initial message to the chat
    Message message = Message.fromValues(
      type: MessageType.user,
      content: "Analyse this image",
      image: base64File,
    );

    await sendMessage(message: message);
  }
}
