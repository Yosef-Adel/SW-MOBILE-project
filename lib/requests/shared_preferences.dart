///This file handles the shared preferences for the app. It contains the methods to save and get the user data from the shared preferences.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<void> saveUserData(String token, String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('userId', userId);
  //print('Saved token: $token');
  //print('Saved userId: $userId');
}

Future<void> getUserData(BuildContext context) async {
  final _isAuth = Provider.of<UserProvider>(context, listen: false).isAuth;
  if (_isAuth) {
    //print("Already Authorized");
    return;
  }
  final prefs = await SharedPreferences.getInstance();
  bool containsKey = prefs.containsKey('token');
  if (containsKey) {
    final _token = prefs.getString('token') ?? '';
    final _userId = prefs.getString('userId') ?? '';
    //print("Token is: $_token");
    //print("UserID is: $_userId");
    final url = Uri.parse('${RoutesAPI.getUser}/$_userId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_token}'
    };
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];
      //print("Message is: $message");
      if (message == 'Success') {
        final jsonResponse = json.decode(response.body);
        //print(jsonResponse['user']);
        Provider.of<UserProvider>(context, listen: false).token = _token;
        Provider.of<UserProvider>(context, listen: false).user =
            User.fromJson(jsonResponse['user']);
        Provider.of<UserProvider>(context, listen: false).isAuth = true;
      }
    } catch (error) {
      print('Error (Shared Preferences): $error');
      return;
    }
  }
}

Future<void> clearUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
