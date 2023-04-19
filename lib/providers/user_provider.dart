/// This file contains the UserProvider class which is used to store the user data and the methods to update the user data.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  late User _user;
  bool _isAuth = false;

  String? get token {
    return _token;
  }

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  bool get isAuth {
    return _isAuth;
  }

  set isAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  User get user {
    return _user;
  }
}
