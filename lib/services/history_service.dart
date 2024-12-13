import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

final HistoryService historyService = HistoryService.instance;

class HistoryService extends GetxController {
  static HistoryService instance = HistoryService();

  final RxList<Chat> chats = <Chat>[].obs;

  Future<void> fetchChats() async {
    // Fetch chats from the API
    chats.value =
        await Api.instance.getUserChats(deviceId: userService.deviceId);
  }

  void addChat(Chat chat) {
    chats.add(chat);
  }

  void updateChat(Chat chat) {
    final index = chats.indexWhere((element) => element.id == chat.id);
    if (index != -1) {
      chats[index] = chat;
    }
  }

  void deleteChat(Chat chat) {
    chats.remove(chat);
  }
}
