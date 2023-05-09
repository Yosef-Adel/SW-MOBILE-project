import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<int> switchtoAttendee(BuildContext context) async {
  final String? userID =
      Provider.of<UserProvider>(context, listen: false).user.id;
  final String? token = Provider.of<UserProvider>(context, listen: false).token;
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
    return -1;
  }
  return 0;
}
