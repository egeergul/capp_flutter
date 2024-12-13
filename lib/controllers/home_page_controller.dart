import 'dart:convert';
import 'dart:io';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/services/chat_service.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePageController extends GetxController {
  void onTapImageAnalyser() async {
    // Add your code here
    CroppedFile? cropped = await NavigationService.openSelectImageOptionModal();
    if (cropped == null) return;

    File? file = File(cropped.path);
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    ChatService cs = ChatService();
    Chat? chat = await cs.createChat();

    if (chat == null) {
      //TODO bunu navbar taşı
      Get.showSnackbar(
        const GetSnackBar(
          title: "You have reached the maximum number of chats",
        ),
      );
      return;
    }

    Get.put(cs, tag: chat.id);
    cs.sendInitialImageAnalyserChatMessage(base64File: base64File);

    // Navigate to the chat screen
    NavigationService.navigateToChatScreen(chatId: chat.id);
  }

  void onTapColorPaletteDetector() async {
    // Add your code here
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
