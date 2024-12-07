import 'package:capp_flutter/models/models.dart';

class UserService {
  static UserService instance = UserService();

  late final User _user;

  void setUser(User user) {
    _user = user;
  }

  get user => _user;
}
