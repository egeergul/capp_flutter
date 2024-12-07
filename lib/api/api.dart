import 'package:capp_flutter/api/api_constants.dart';
import 'package:capp_flutter/api/openai_api.dart';
import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:capp_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class Api {
  static Api instance = Api();

  final CollectionReference userCollection = db.collection("users");

  // Creates a new user in the database if it doesn't exist
  // Returns the user
  Future<User> getUser({
    required String deviceId,
  }) async {
    // Check if the user exists
    final DocumentSnapshot userDoc = await userCollection.doc(deviceId).get();
    if (userDoc.exists) {
      LoggerHelper.logInfo("Api.getUser", "User found");
      return User.fromJson(userDoc.data()! as Map<String, dynamic>);
    } else {
      // Create a new user
      User user = User.fromValues(deviceId: deviceId);
      LoggerHelper.logInfo("Api.getUser", "User created");
      await userCollection.doc(deviceId).set(user.toJson());
      return user;
    }
  }

  //
  Future<String> getImageAnalyses({
    required String base64Image,
  }) async {
    Map<String, dynamic> response = await OpenaiApi.instance.sendMessage(
      systemMessage: ApiConstants.analyzeImageSystemMessageV1,
      userMessage: "Analyze this image",
      base64Image: base64Image,
    );

    return response["choices"][0]["message"]["content"];
  }
}
