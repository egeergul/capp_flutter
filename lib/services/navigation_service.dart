import 'package:capp_flutter/constants/routes.dart';
import 'package:capp_flutter/widgets/modals/modals.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class NavigationService {
  static void closeAllModals() {
    Get.until((route) => !(Get.isBottomSheetOpen ?? false));
  }

  static navigateHome() {
    Get.offAllNamed(Routes.home);
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
}
