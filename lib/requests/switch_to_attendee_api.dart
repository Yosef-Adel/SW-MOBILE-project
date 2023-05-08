import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../screens/tabs_screen.dart';
import 'routes_api.dart';

Future<void> switchtoAttendee(BuildContext context) async {
  final userProv = Provider.of<UserProvider>(context);
  var token = Provider.of<UserProvider>(context, listen: false).token;
  final userID = userProv.user.id;
  //print(userID);
  final url = Uri.parse('${RoutesAPI.changeToAttendee}/$userID');
  //print(url);
  //print(token);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  final response = await http.get(
    url,
    headers: headers,
  );
  final jsonResponse = json.decode(response.body);
  final message = jsonResponse['message'];
  //print(message);
  if (message == "Your token is invalid, your are not authorized!") {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You are not authorized'),
      ),
    );
  } else {
    Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
  }
}
