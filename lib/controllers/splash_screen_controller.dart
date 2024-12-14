import 'dart:io';

import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:capp_flutter/services/history_service.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/services/user_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    // Ensure the splash screen is displayed for at least 1.5 seconds
    Future minSplashDuration =
        Future.delayed(const Duration(milliseconds: 1500));

    User user = await Api.instance.getUser(deviceId: (await _getId())!);
    userService.setUser(user);
    await historyService.fetchChats();

    await minSplashDuration;
    NavigationService.navigateHome();

    super.onInit();
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      return const AndroidId().getId(); // unique ID on Android
    }
    return null;
  }
}
