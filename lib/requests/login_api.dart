import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';
import 'shared_preferences.dart';

//Login function
Future<int> login(
    {required BuildContext context, String? email, String? password}) async {
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
    } else if (message == "user not found") {
      return 2;
    } else if (message == "Password is incorrect") {
      return 3;
    } else //successful login
    {
      final jsonResponse = json.decode(response.body);
      //print(jsonResponse['user']);
      Provider.of<UserProvider>(context, listen: false).token =
          jsonResponse['token'];
      Provider.of<UserProvider>(context, listen: false).user =
          User.fromJson(jsonResponse['user']);
      Provider.of<UserProvider>(context, listen: false).isAuth = true;
      //print(Provider.of<UserProvider>(context).token);

      saveUserData(Provider.of<UserProvider>(context, listen: false).token!,
          Provider.of<UserProvider>(context, listen: false).user.id!);

      return 4;
    }
  } catch (error) {
    print('Error while logging in: $error');
    throw 'Failed to login';
  }
}
