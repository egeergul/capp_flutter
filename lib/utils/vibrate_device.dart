import 'dart:io';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

Future<bool> vibrateDevice() async {
  if ((await Vibration.hasVibrator() ?? false)) {
    if (Platform.isIOS) {
      HapticFeedback.lightImpact();
      return true;
    } else {
      Vibration.vibrate(duration: 10);
      return true;
    }
  } else {
    return false;
  }
}
