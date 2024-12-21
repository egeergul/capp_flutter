import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/services/history_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ChatService extends GetxController {
  late Rx<Chat> chat;

  void initChat(Chat c) {
    chat = c.obs;
  }

  Future<Chat?> createChat({required ChatType chatType}) async {
    // Check if the user can create a new chat
    if (!userService.canCreateChat) return null;

    // Create a new chat
    Chat c = await Api.instance.createChat(
      deviceId: userService.deviceId,
      chatType: chatType,
    );
    chat = c.obs;

    await userService.incrementTotalChats();
    historyService.addChat(c);

    return c;
  }

  Future<void> sendMessage({
    required Message message,
    bool expectMetadataResponse = false,
  }) async {
    chat.value.messages.add(message);
    chat.value.status = ChatStatus.waiting;
    chat.value.updatedAt = DateTime.now().millisecondsSinceEpoch;
    chat.refresh();

    historyService.updateChat(chat.value);

    Future<Message> futureMessage = Api.instance.sendMessage(
      chatJson: chat.value.toJson(),
      messageJson: message.toJson(),
      expectMetadataResponse: expectMetadataResponse,
    );

    Message inMessage = await futureMessage;

    // Wait for the message to be responden by BE

    // TODO aslında burada conversation en güncel halini çekebiliriz direkt
    chat.value.messages.add(inMessage);
    chat.value.status = ChatStatus.completed;
    chat.value.updatedAt = DateTime.now().millisecondsSinceEpoch;
    chat.refresh();

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

  Future<void> sendInitialImageColorPaletteDetector({
    required String base64File,
  }) async {
    // Send the initial message to the chat
    Message message = Message.fromValues(
      type: MessageType.user,
      content: "Detect the color palette of this image",
      image: base64File,
    );

    await sendMessage(
      message: message,
      expectMetadataResponse: true,
    );
  }
}
