import 'package:capp_flutter/api/api.dart';
import 'package:capp_flutter/models/models.dart';

final UserService userService = UserService.instance;
const int maxChats = 35;

class UserService {
  static UserService instance = UserService();

  late final User _user;

  // Getters
  User get user => _user;
  String get deviceId => user.deviceId;
  bool get canCreateChat => user.totalChats < maxChats;

  // Setters
  void setUser(User user) {
    _user = user;
  }

  Future<void> incrementTotalChats() async {
    user.totalChats++;
    await Api.instance.updateUser(user: user);
  }

  Future<void> decrementTotalChats() async {
    user.totalChats--;
    await Api.instance.updateUser(user: user);
  }
}
