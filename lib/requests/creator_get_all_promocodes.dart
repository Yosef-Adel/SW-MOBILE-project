import 'dart:convert';

import 'package:envie_cross_platform/models/promocode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<List<Promocode>> creatorGetAllPromocodes(BuildContext context) async {
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final eventID = Provider.of<CreatorEventProvider>(context, listen: false)
      .selectedEventId!;

  final url = Uri.parse('${RoutesAPI.checkPromo}${eventID}');

  print(url);
  //print('Token: $token');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');

    int responseStatus = response.statusCode;
    List<Promocode> promocodesList = [];
    if (responseStatus == 200) {
      for (var promoDict in jsonResponse['promocodes']) {
        promocodesList.add(Promocode.fromJson(promoDict));
      }
      return promocodesList;
    }
    return [];
  } catch (error) {
    print("Error in getting promocodes: $error");
    return [];
  }
}
