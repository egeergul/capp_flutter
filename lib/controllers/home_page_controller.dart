import 'dart:convert';
import 'dart:io';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/chat_service.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePageController extends GetxController {
  void onTapImageAnalyser() async {
    if (!userService.canCreateChat) {
      NavigationService.showSnackbar(
        snackbar: SnackbarModel.maximumChatsReached(),
      );
      return;
    }
    // Add your code here
    CroppedFile? cropped = await NavigationService.openSelectImageOptionModal();
    if (cropped == null) return;

    File? file = File(cropped.path);
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    ChatService cs = ChatService();
    Chat? chat = await cs.createChat(
      chatType: ChatType.imageAnalyser,
    );

    if (chat == null) {
      NavigationService.showSnackbar(
        snackbar: SnackbarModel.maximumChatsReached(),
      );
      return;
    }
    //Get.put(cs, tag: chat.id); TODO kontrol et
    cs.sendInitialImageAnalyserChatMessage(base64File: base64File);

    // Navigate to the chat screen
    NavigationService.navigateToChatScreen(chatService: cs);
  }

  void onTapColorPaletteDetector() async {
    if (!userService.canCreateChat) {
      NavigationService.showSnackbar(
        snackbar: SnackbarModel.maximumChatsReached(),
      );
      return;
    }
    // Add your code here
    CroppedFile? cropped = await NavigationService.openSelectImageOptionModal();
    if (cropped == null) return;

    File? file = File(cropped.path);
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    ChatService cs = ChatService();
    Chat? chat = await cs.createChat(
      chatType: ChatType.colorPaletteDetector,
    );

    if (chat == null) {
      NavigationService.showSnackbar(
        snackbar: SnackbarModel.maximumChatsReached(),
      );
      return;
    }
    //Get.put(cs, tag: chat.id); TODO kontrol et
    cs.sendInitialImageColorPaletteDetector(base64File: base64File);

    // Navigate to the chat screen
    NavigationService.navigateToChatScreen(chatService: cs);
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
