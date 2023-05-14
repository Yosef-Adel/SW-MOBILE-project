///This function is used to delete a promocode from the server.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<int> creatorDeletePromocode(
    BuildContext context, String PromocodeID) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  final url = Uri.parse('${RoutesAPI.checkPromo}$eventID/$PromocodeID');

  print(url);
  //print('Token: $token');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  try {
    final response = await http.delete(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: $jsonResponse');

    int responseStatus = response.statusCode;
    //print(responseStatus);
    if (responseStatus == 200) return 0;

    return -1;
  } catch (error) {
    print("Error in deleting Promocode: $error");
    return -1;
  }
}
