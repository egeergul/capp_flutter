import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';

class UserService {
  static UserService instance = UserService();

  late final User _user;

  void setUser(User user) {
    _user = user;
  }

  get user => _user;

  Future<void> createImageAnalyserChat() async {
    // Add your code here
    // TODO: check if user is able to create a new conversation

    // Create a new chat
    Chat chat = await Api.instance.createChat(deviceId: user.deviceId);
  }
}
