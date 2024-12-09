import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const String _cropPageName = "Crop Image";
final AndroidUiSettings androidUiSettings = AndroidUiSettings(
  toolbarTitle: _cropPageName,
  toolbarColor: Colors.teal,
  toolbarWidgetColor: Colors.white,
  initAspectRatio: CropAspectRatioPreset.original,
  lockAspectRatio: false,
);
final IOSUiSettings iosUiSettings = IOSUiSettings(
  title: _cropPageName,
);

// TODO: permission case'ini hallet, eğer permisson yoksa pop up çıksın
class SelectImageOptionModalController {
  void onTapCamera() async {
    CroppedFile? cropped = await _selectAndGetCroppedImage(
      ImageSource.camera,
    );

    Get.back(result: cropped);
  }

  void onTapGallery() async {
    CroppedFile? cropped = await _selectAndGetCroppedImage(
      ImageSource.gallery,
    );
    Get.back(result: cropped);
  }

  // Tries to get image from source and crop it
  // If image is selected, returns it, else returns null
  // If native permisson can be asked, it asks for permission
  // If not, it shows a popup and returns null
  static Future<CroppedFile?> _selectAndGetCroppedImage(
    ImageSource source,
  ) async {
    CroppedFile? cropped;
    try {
      cropped = await _selectAndCropImageFromImageSource(
        source,
      );
    } catch (e) {
      // Native permission can't be asked
      if (e.runtimeType == PlatformException &&
          (e as PlatformException).code.contains("access_denied")) {
        // PopupService.instance.showPhotoPermissionPopup(
        //   gallery: source == ImageSource.gallery,
        // );
      } else {
        // something else went wrong
        LoggerHelper.logError(
            "SelectImageOptionModalController.selectAndGetCroppedImage",
            e.toString());
      }
      return null;
    }
    return cropped;
  }

  static Future<CroppedFile?> _selectAndCropImageFromImageSource(
    ImageSource source,
  ) async {
    XFile? picked = await ImagePicker()
        .pickImage(source: source, preferredCameraDevice: CameraDevice.rear);
    if (picked != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        uiSettings: [
          androidUiSettings,
          iosUiSettings,
        ],
      );
      return cropped;
    }
    return null;
  }
}
