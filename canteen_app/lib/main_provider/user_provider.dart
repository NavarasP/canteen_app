// main_provider/user_provider.dart

import 'package:flutter/material.dart';
import 'package:canteen_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
