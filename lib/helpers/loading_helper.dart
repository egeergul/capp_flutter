import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingHelper {
  static final LoadingHelper instance = LoadingHelper();
  List<String> keys = [];

  /// Adds a layer of loading animation to the screen with key
  void showLoadingAnimation(String key) {
    if (!keys.contains(key)) {
      keys.add(key);
    }
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(
        const LoadingAnimation(),
        barrierColor: Colors.black.withOpacity(0.6),
        barrierDismissible: false,
      );
    }
  }

  /// Removes a layer of loading animation to the screen with key
  void closeLoadingAnimation(String key) {
    if (keys.contains(key)) {
      keys.remove(key);
    }
    if (keys.isEmpty) {
      Get.until((route) => !(Get.isDialogOpen ?? false));
    }
  }

  void closeAllLoadingAnimations() {
    keys.clear();
    Get.until((route) => !(Get.isDialogOpen ?? false));
  }
}
