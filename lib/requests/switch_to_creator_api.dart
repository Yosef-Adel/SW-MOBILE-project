import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<bool> switchToCreator(BuildContext context) async {
  final String? userID =
      Provider.of<UserProvider>(context, listen: false).user.id;
  final String? token = Provider.of<UserProvider>(context, listen: false).token;
  //print(userID);
  final url = Uri.parse('${RoutesAPI.changeToCreator}/$userID');
  //print(url);
  print('Token is: $token');
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
  
  if (message == "Your token is invalid, your are not authorized!") {
    return false;
  }
  
  return true;
}
