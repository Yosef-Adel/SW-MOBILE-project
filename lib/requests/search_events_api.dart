import 'dart:convert';

import 'package:envie_cross_platform/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/event.dart';
import 'routes_api.dart';

Future<List<Event>> searchEvents(BuildContext context, String? keyword) async {
  final url = Uri.parse('${RoutesAPI.searchEvents}?q=$keyword');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');
    int responseStatus = response.statusCode;
    List<Event> eventsList = [];
    if (responseStatus == 200) {
      for (var eventDict in jsonResponse['events']) {
        eventsList.add(Event.fromJson(eventDict));
      }
      return eventsList;
    }
    return [];
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
