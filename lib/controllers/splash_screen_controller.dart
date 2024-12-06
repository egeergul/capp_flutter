import 'package:capp_flutter/services/navigation_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    // Since there are no loading operations currently
    await Future.delayed(const Duration(milliseconds: 1500));
    NavigationService.navigateHome();

    super.onInit();
  }
}
