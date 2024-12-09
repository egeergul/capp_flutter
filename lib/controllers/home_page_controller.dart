import 'dart:convert';
import 'dart:io';
import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/helpers/loading_helper.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/models/user.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePageController extends GetxController {
  void onTapImageAnalyser() async {
    // Add your code here
    CroppedFile? cropped = await NavigationService.openSelectImageOptionModal();
    if (cropped == null) return;

    LoadingHelper.instance.showLoadingAnimation("analyse_image");

    File? file = File(cropped.path);
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    User user = UserService.instance.user;
    Chat chat = await Api.instance.createChat(deviceId: user.deviceId);
    Message message = Message.fromValues(
      type: MessageType.user,
      content: "Analyse this image",
      image: base64File,
    );

    // Send the message but don't await for a response
    Api.instance.sendMessage(
      user: user,
      chat: chat,
      message: message,
    );

    LoadingHelper.instance.closeLoadingAnimation("analyse_image");
    NavigationService.navigateToChatScreen(chatId: chat.id);
  }

  void onTapColorPaletteDetector() async {
    // Add your code here
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
