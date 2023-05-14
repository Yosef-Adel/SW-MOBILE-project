///This function is used to create a promocode for the event that the creator is currently updating.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<int> creatorAddPromocode(
  BuildContext context,
  String name,
  String tickets,
  int percentOff,
  int amountOff,
  int limit,
  DateTime startDate,
  DateTime endDate,
) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse('${RoutesAPI.checkPromo}${eventID}');
  print(url);
  final body = json.encode({
    'name': name,
    'tickets': tickets,
    amountOff == -1 ? 'percentOff' : 'amountOff':
        amountOff == -1 ? percentOff : amountOff,
    'limit': limit,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  });

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.post(url, headers: headers, body: body);

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) return 0;

    return -1;
  } catch (error) {
    print('Error while adding promocode: $error');
    return -1;
  }
}
