import 'package:capp_flutter/constants/routes.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/models/popup.dart';
import 'package:capp_flutter/widgets/popup_box.dart';
import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:capp_flutter/utils/base_imports.dart';

class NavigationService {
  static void closeAllModals() {
    Get.until((route) => !(Get.isBottomSheetOpen ?? false));
  }

  static void closeAllDialogs() {
    Get.until((route) => !(Get.isDialogOpen ?? false));
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

  // 1: if confirm button pressed
  // 0: if reject button pressed
  // null if nothing is pressed
  static Future<int?> openPopup({required Popup popup}) async {
    int? res = await Get.dialog(
      PopupBox(popup: popup),
      barrierColor: Colors.black.withOpacity(0.6),
      barrierDismissible: true,
    );

    return res;
  }

  // Snackbars
  static void showTopSnackbar({
    required SnackbarModel snackbar,
  }) {
    GetSnackBar bar = GetSnackBar(
      snackPosition: snackbar.snackPosition,
      duration: snackbar.duration,
      borderRadius: 12.r,
      borderWidth: 1.5.w,
      backgroundColor: snackbar.backgroundColor!,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      titleText: Text(
        snackbar.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: snackbar.message != null
          ? Text(
              snackbar.message!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            )
          : const EmptyWidget(),
    );
    Get.showSnackbar(bar);
  }
}
