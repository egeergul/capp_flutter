import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  RxList<Chat> chats = <Chat>[].obs;

  @override
  void onInit() async {
    chats.value = await Api.instance
        .getUserChats(deviceId: UserService.instance.user.deviceId);
  }

  void onTap(Chat chat) {
    NavigationService.navigateToChatScreen(chatId: chat.id);
  }
}
