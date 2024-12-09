import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  Rx<Chat> chat = Chat.empty().obs;

  @override
  void onInit() async {
    print('ChatScreenController Created');

    String? chatId = Get.arguments['chatId'];
    if (chatId == null) {
      //TODO:Handle chat not found
      Get.back();
      return;
    }
    Chat? c = await Api.instance
        .getChat(deviceId: UserService.instance.user.deviceId, id: chatId);

    if (c == null) {
      //TODO:Handle chat not found
      Get.back();
      return;
    }

    chat.value = c;

    super.onInit();
  }

  @override
  void onClose() {
    print('ChatScreenController Closed');
    super.onClose();
  }
}
