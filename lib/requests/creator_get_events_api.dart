/// This file contains the API for getting the events of a creator.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<List<Event>> creatorGetEvents(BuildContext context, int choice) async {
  String? userID = Provider.of<UserProvider>(context, listen: false).user.id;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final String baseUrl;
  if (choice == 0)
    baseUrl = '${RoutesAPI.creatorGetEvents}/$userID/all-events';
  else if (choice == 1)
    baseUrl = '${RoutesAPI.creatorGetEvents}/$userID/upcoming-events';
  else
    baseUrl = '${RoutesAPI.creatorGetEvents}/$userID/past-events';
  Uri url = Uri.parse(baseUrl);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  //print(headers);
  //print('Token: ${token}');
  print(url);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    //print('Response: ${jsonResponse}');

    int responseStatus = response.statusCode;

    if (responseStatus == 200) {
      List<Event> eventsList = [];
      final Dict;
      if (choice == 0)
        Dict = jsonResponse['events'];
      else
        Dict = jsonResponse['userEvents'];

      for (var eventDict in Dict) {
        eventsList.add(Event.fromJsonCreator(eventDict));
      }
      return eventsList;
    }

    return [];
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
