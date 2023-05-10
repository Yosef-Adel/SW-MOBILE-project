import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<int> creatorAddTicket(
    BuildContext context,
    String name,
    String type,
    int capacity,
    double price,
    int maxQuantityPerOrder,
    DateTime sellingStartDate,
    DateTime sellingEndDate) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse('${RoutesAPI.getAllTickets}${eventID}/createTicket');
  print(url);
  final body = json.encode({
    'name': name,
    'type': type,
    'price': price,
    'capacity': capacity,
    'minQuantityPerOrder': 1,
    'maxQuantityPerOrder': maxQuantityPerOrder,
    'salesStart': DateFormat('yyyy-MM-dd\'T\'HH:mm').format(sellingStartDate),
    'salesEnd': DateFormat('yyyy-MM-dd\'T\'HH:mm').format(sellingEndDate),
  });
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.post(url, headers: headers, body: body);

    final jsonResponse = json.decode(response.body);
    //print(jsonResponse['message']);
    if (response.statusCode == 201) return 0;

    return -1;
  } catch (error) {
    print('Error while adding ticket: $error');
    return -1;
  }
}

Future<int> creatorEditTicket(
  BuildContext context,
  String name,
  double price,
  String ticketId,
) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse('${RoutesAPI.getAllTickets}${eventID}/${ticketId}');
  print(url);
  final body = json.encode({
    'name': name,
    'price': price,
  });
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.put(url, headers: headers, body: body);
    print(response.statusCode);

    final jsonResponse = json.decode(response.body);
    //print(jsonResponse['message']);
    if (response.statusCode == 200) return 0;

    return -1;
  } catch (error) {
    print('Error while adding ticket: $error');
    return -1;
  }
}
