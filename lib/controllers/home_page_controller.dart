import 'dart:convert';
import 'dart:io';

import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/screens/home_page.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePageController extends GetxController {
  void onTapImageAnalyser() async {
    // Add your code here
    CroppedFile? cropped = await NavigationService.openSelectImageOptionModal();
    if (cropped == null) return;

    Get.dialog(
      Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(0.2),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    File? file = File(cropped.path);
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    String result =
        await Api.instance.getImageAnalyses(base64Image: base64File);

    Get.back();
    Get.dialog(
      Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(result),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapColorPaletteDetector() {
    // Add your code here
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
