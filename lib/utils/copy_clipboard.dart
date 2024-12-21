import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:capp_flutter/models/snackbar.dart';
import 'package:capp_flutter/services/navigation_service.dart';
import 'package:capp_flutter/utils/vibrate_device.dart';
import 'package:flutter/services.dart';

Future<bool> copyClipboard(
  String str, {
  bool hapticFeedback = true,
  bool showSnackbarIfHapticUnavailble = true,
  bool snackbarMessage = true,
}) async {
  try {
    await Clipboard.setData(ClipboardData(text: str));

    bool snackbarShown = false;
    if (hapticFeedback == true) {
      bool hapticFeedbackGiven = await vibrateDevice();
      if (!hapticFeedbackGiven && showSnackbarIfHapticUnavailble) {
        NavigationService.showSnackbar(
          snackbar: SnackbarModel.copiedToClipboard(),
        );
        snackbarShown = true;
      }
    }

    if (snackbarMessage && !snackbarShown) {
      NavigationService.showSnackbar(
        snackbar: SnackbarModel.copiedToClipboard(),
      );
    }

    return true;
  } catch (e) {
    LoggerHelper.logError("copyClipboard", e.toString());
    return false;
  }
}
