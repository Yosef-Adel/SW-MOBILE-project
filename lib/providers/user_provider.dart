import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../requests/routes_api.dart';

class UserProvider with ChangeNotifier {
  late String token = 'null';
  late User user;
  //late DateTime tokenTime;

  bool get isAuth {
    //you call it to check whether the user logged in or not
    return token != 'null';
  }

  // String? get token {
  //   if (_token != null && DateTime.now().difference(tokenTime).inHours < 24) {
  //     return _token;
  //   }
  //   return null;
  // }

  //Login function
  Future<int> login({String? email, String? password}) async {
    final url = Uri.parse('${RoutesAPI.login}');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'emailAddress': email,
      'password': password,
    });
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];
      if (message == "Please verify your email first.") {
        return 1;
      } else if (message == "user nor found") {
        return 2;
      } else if (message == "Password is incorrect") {
        return 3;
      } else //successful login
      {
        final jsonResponse = json.decode(response.body);
        token = jsonResponse['token'];
        //tokenTime = DateTime.now();
        user = User.fromJson(jsonResponse['user']);
        notifyListeners();
        return 4;
      }
    } catch (error) {
      print('Error while logining in: $error');
      throw 'Failed to login';
    }
  }

  //Logout function
  Future<void> logout() async {
    token = 'null';
    notifyListeners();
  }
}
