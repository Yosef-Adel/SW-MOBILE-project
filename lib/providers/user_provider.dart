import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late String? token;
  late User user;
  DateTime tokenTime = DateTime.now();

  bool get isAuth {
    return token != null;
  }

  String? get getToken {
    if (DateTime.now().difference(tokenTime).inHours < 24 && token != null) {
      return token;
    }
    return null;
  }

  //Login function
  Future<int> login({String? email, String? password}) async {
    const String baseUrl = 'https://sw-backend-project.vercel.app/auth/login';

    final url = Uri.parse('${baseUrl}');
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
        user = User.fromJson(jsonResponse['user']);
        return 4;
      }
    } catch (error) {
      print('Error while logining in: $error');
      throw 'Failed to login';
    }
  }
}
