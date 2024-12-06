import 'package:capp_flutter/constants/routes.dart';
import 'package:get/get.dart';

class NavigationService {
  static void closeAllModals() {
    Get.until((route) => !(Get.isBottomSheetOpen ?? false));
  }

  static navigateHome() {
    Get.offAllNamed(Routes.home);
  }
}
