import 'package:capp_flutter/constants/routes.dart';
import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class NavigationService {
  static void closeAllModals() {
    Get.until((route) => !(Get.isBottomSheetOpen ?? false));
  }

  static navigateHome() {
    Get.offAllNamed(Routes.home);
  }

  static navigateToChatScreen({required String chatId}) {
    Get.toNamed(Routes.chat, arguments: {
      "chatId": chatId,
    });
  }

  // Modals
  static Future<CroppedFile?> openSelectImageOptionModal() async {
    return await Get.bottomSheet(
      const SelectImageOptionModal(),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // Dialogs
  static Future<void> openImageDisplayDialog({
    Uint8List? base64String,
  }) async {
    return await Get.dialog(
      ImageDisplay(
        base64String: base64String,
      ),
      barrierColor: Colors.black.withOpacity(0.6),
      barrierDismissible: false,
    );
  }
}
