import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class HomePageController extends GetxController {
  void onTapImageAnalyser() {
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));

    print("EGE 1");
    // Add your code here
  }

  void onTapColorPaletteDetector() {
    // Add your code here
  }

  void onTapColorPaletteGenerator() {
    // Add your code here
  }
}
