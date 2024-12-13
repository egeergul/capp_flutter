import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/models/popup.dart';
import 'package:capp_flutter/services/history_service.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  late RxList<Chat> chats;

  @override
  void onInit() async {
    chats = HistoryService.instance.chats;
    super.onInit();
  }

  void onTap(Chat chat) {
    NavigationService.navigateToChatScreen(chatId: chat.id);
  }

  void onTapDelete(Chat chat) async {
    int? i = await NavigationService.openPopup(
      popup: Popup.deleteChat(),
    );

    if (i != 1) {
      return;
    }

    userService.decrementTotalChats();
    historyService.deleteChat(chat);
    chat.status =
        ChatStatus.deleted; //TODO bence daha iyi bir yöntem bulunabilir
    await Api.instance.updateChat(chat: chat);
  }
}
