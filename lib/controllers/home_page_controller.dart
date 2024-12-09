import 'dart:convert';
import 'dart:io';
import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/helpers/loading_helper.dart';
import 'package:capp_flutter/models/chat.dart';
import 'package:capp_flutter/models/message.dart';
import 'package:capp_flutter/models/user.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
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

    chat = await Api.instance.sendMessage(
      user: user,
      chat: chat,
      message: message,
    );

    LoadingHelper.instance.closeLoadingAnimation("analyse_image");
    Get.dialog(
      Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(chat.messages.last.content),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapColorPaletteDetector() async {
    // Add your code here
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
