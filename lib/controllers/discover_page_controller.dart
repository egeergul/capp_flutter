import 'dart:convert';

import 'package:capp_flutter/constants/app_jsons.dart';
import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DiscoverPageController extends GetxController {
  RxList tutorials = [].obs;

  @override
  void onInit() async {
    tutorials.value = (await _readAssetJson(AppJsons.tutorials)) ?? [];

    super.onInit();
  }

  Future _readAssetJson(String path) async {
    try {
      // Load the JSON file as a string
      final String jsonString = await rootBundle.loadString(path);

      // Parse the JSON string into a Map
      final jsonData = json.decode(jsonString);

      return jsonData;
    } catch (e) {
      LoggerHelper.logError(
          "DiscoverScreenController.readAssetJson", e.toString());
      return null;
    }
  }

  void onTapTutorial(Map tutorial) async {
    String? path = tutorial["path"];
    if (path == null) return; // TODO missing diye error çıkar
    Map? tutorialMap = await _readAssetJson(path);
    if (tutorialMap == null) return; // TODO missing diye error çıkar

    print(tutorialMap);
  }
}
