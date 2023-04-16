import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../requests/routes_api.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  late User _user;
  bool _isAuth = false;

  String? get token {
    print('Token is: $_token');
    return _token;
  }

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  bool get isAuth {
    print('isAuth is: $_isAuth');
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
    print('User is: $_user');
    return _user;
  }
}
