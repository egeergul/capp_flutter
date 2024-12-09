import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/models/popup.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  RxList<Chat> chats = <Chat>[].obs;

  @override
  void onInit() async {
    var list = await Api.instance
        .getUserChats(deviceId: UserService.instance.user.deviceId);
    list.sort((a, b) => a.updatedAt > b.updatedAt ? -1 : 1);
    chats.value = list;
    super.onInit();
  }

  void onTap(Chat chat) {
    NavigationService.navigateToChatScreen(chatId: chat.id);
  }

  void onTapDelete(Chat chat) async {
    int? i = await NavigationService.openPopup(
      popup: Popup.deleteChat(),
    );

    if (i == 0) {
      return;
    }
    chat.status = ChatStatus.deleted;
    Api.instance
        .updateConversation(user: UserService.instance.user, chat: chat);
    chats.remove(chat);
    Get.back();
  }
}
